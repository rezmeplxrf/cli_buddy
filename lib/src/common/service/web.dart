import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import '../../../cli_buddy.dart';
import 'action.dart';
import 'config.dart';
import 'dio.dart';
import 'global.dart';
import 'open_router.dart';
import 'session.dart';
import 'sys_info.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebService {
  factory WebService() => _instance;
  WebService._internal();
  static final WebService _instance = WebService._internal();

  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;
  static HttpServer? _server;
  static WebSocketChannel? webSocket;
  static List<ChatSession>? sessions = [];
  static String? msg;

  Future<void> start({required String address, required int port}) async {
    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addMiddleware(MiddlerWareService.addCustomHeaders())
        .addHandler(HandlerService.router);

    _server = await io.serve(handler, address, port);
    _logger
        ?.info('Serving at http://${_server?.address.host}:${_server?.port}');
  }

  Future<void> stop() async {
    if (_server != null) {
      await _server!.close(force: true);
      WebService.webSocket = null;
      _logger?.info('Server stopped');
    }
  }
}

class HandlerService {
  factory HandlerService() => _instance;
  HandlerService._internal();
  static final HandlerService _instance = HandlerService._internal();
  static const jsonHeaders = {'content-type': 'application/json'};

  static Handler get router {
    final router = Router()
      ..get('/ws', webSocketHandler(_handleWebSocket))
      ..get('/session-list', _sessionListHandler)
      ..post('/save-session', _saveSessionHandler)
      ..post('/remove-all', _removeAllHandler)
      ..get('/config', _getConfigHandler)
      ..post('/config', _setConfigHandler)
      ..post('/remove-session', _removeSessionHandler)
      ..post('/make-file', _makeFileHandler)
      ..get('/prompts', _getPromptsHandler)
      ..post('/prompts', _setPromptsHandler);
    return router.call;
  }

  static void _handleWebSocket(WebSocketChannel socket) {
    WebService.webSocket = socket;
    socket.stream.listen((message) async {
      if (message.toString().startsWith('Cancel')) {
        OpenRouterService.cancelToken?.cancel();
        return;
      }
      final userSentSession = ChatSession.fromJson(
          jsonDecode(message as String) as Map<String, dynamic>);
      if (message.trim().isNotEmpty) {
        WebService.webSocket?.sink
            .add(jsonEncode(const MessageChunk(type: ChunkType.start)));
        try {
          final newSession = await openRouter
              .invoke(session: userSentSession, markdown: false)
              .getOrThrow();
          final lastResponse = newSession.messages.last;
          WebService.webSocket?.sink.add(jsonEncode(
              MessageChunk(type: ChunkType.end, usage: lastResponse.usage)));
        } catch (e) {
          const msgChunk = MessageChunk(
              type: ChunkType.error,
              content: 'Error while making API request.');
          WebService.webSocket?.sink.add(jsonEncode(msgChunk));
          return;
        }
      }
    }, onDone: () {
      WebService.webSocket?.sink.close();
      WebService.webSocket = null;
    }, onError: (e) {
      WebService.webSocket?.sink.close();
      WebService.webSocket = null;
    });
  }

  static Future<Response> _saveSessionHandler(Request request) async {
    try {
      final payload = await request.readAsString();

      final sessionJson = jsonDecode(payload) as Map<String, dynamic>;
      final chatSession = ChatSession.fromJson(sessionJson);
      await SessionService.saveSession(session: chatSession);

      return Response.ok(jsonEncode({'result': 'File is saved'}),
          headers: jsonHeaders);
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to create file - $e',
      );
    }
  }

  static Response _getPromptsHandler(Request request) {
    try {
      final defaultDir = SysInfoService.getConfigDirectory();
      final filePath = p.join(defaultDir!, 'prompts.json');

      final content = ActionService.retrieveFile(filePath).getOrNull();

      if (content == null) {
        return Response.notFound('File not found at $filePath');
      }

      return Response.ok(content, headers: jsonHeaders);
    } catch (e) {
      return Response.notFound('File not found');
    }
  }

  static Future<Response> _setPromptsHandler(Request request) async {
    try {
      final payload = await request.readAsString();

      final jsonList = jsonDecode(payload) as List<dynamic>;
      final prompts = jsonList
          .map((e) => SysPrompt.fromJson(e as Map<String, dynamic>))
          .toList();
      defaultDir ??= SysInfoService.getConfigDirectory();
      final filePath = p.join(defaultDir!, 'prompts.json');
      await ActionService.saveToFile(filePath, jsonEncode(prompts),
          shouldAutoOvewrite: true);

      return Response.ok(
          jsonEncode(jsonEncode({'result': 'File is created at $filePath'})),
          headers: jsonHeaders);
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to create file - $e',
      );
    }
  }

  static Future<Response> _makeFileHandler(Request request) async {
    try {
      final payload = await request.readAsString();

      final data = jsonDecode(payload) as Map<String, dynamic>;
      final content = data['code'] as String;
      final path = data['path'] as String;
      await ActionService.saveToFile(path, content, shouldAutoOvewrite: true);
      return Response.ok(jsonEncode({'result': 'File is created at $path'}),
          headers: jsonHeaders);
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to create file - $e',
      );
    }
  }

  static Future<Response> _removeSessionHandler(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final sessionId = data['sessionId'];
    final result = await SessionService.removeSession(id: sessionId as int);
    if (result) {
      return Response.ok(jsonEncode({'result': 'Session is removed'}),
          headers: jsonHeaders);
    } else {
      return Response.internalServerError(
        body: 'Failed to remove session',
      );
    }
  }

  static Future<Response> _getConfigHandler(Request request) async {
    configuration = await ConfigService.loadConfig().getOrNull();
    if (configuration == null) {
      return Response.notFound(
        'Config is empty or failed to load config',
      );
    } else {
      return Response.ok(jsonEncode(configuration?.toJson()),
          headers: jsonHeaders);
    }
  }

  static Future<Response> _setConfigHandler(Request request) async {
    try {
      configuration = await ConfigService.loadConfig().getOrNull();
      final payload = await request.readAsString();
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final newConfig = Configuration.fromJson(data);
      print(newConfig);

      if (newConfig != configuration) {
        await ConfigService.saveConfig(newConfig: newConfig);
        return Response.ok(jsonEncode(configuration?.toJson()),
            headers: jsonHeaders);
      } else {
        return Response.ok(
            jsonEncode({
              'result': 'No changes made because it is the same as the current'
            }),
            headers: jsonHeaders);
      }
    } catch (e) {
      return Response.internalServerError(
        body: e.toString(),
      );
    }
  }

  static Future<Response> _removeAllHandler(Request request) async {
    final result = await SessionService.removeSessions();
    if (result) {
      WebService.sessions?.clear();
      return Response.ok(jsonEncode({'result': 'All sessions are removed'}),
          headers: jsonHeaders);
    } else {
      return Response.internalServerError(
          body: 'Failed to remove all sessions');
    }
  }

  static Future<Response> _sessionListHandler(Request request) async {
    try {
      WebService.sessions = await SessionService.listSessions();
      if (WebService.sessions == null || WebService.sessions!.isEmpty) {
        return Response.notFound('Session is empty or failed to load sessions');
      } else {
        final sessionsJson =
            jsonEncode(WebService.sessions?.map((s) => s.toJson()).toList());
        return Response.ok(
          sessionsJson,
          headers: jsonHeaders,
        );
      }
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to load sessions - $e',
      );
    }
  }
}

class MiddlerWareService {
  factory MiddlerWareService() => _instance;
  MiddlerWareService._internal();
  static final MiddlerWareService _instance = MiddlerWareService._internal();

  static Middleware addCustomHeaders() {
    return (Handler handler) {
      return (Request request) async {
        final response = await handler(request);
        return response.change(headers: {
          'Cross-Origin-Embedder-Policy': 'credentialless',
          'Cross-Origin-Opener-Policy': 'same-origin',
        });
      };
    };
  }
}

class LocalWebService {
  factory LocalWebService() => _instance;
  LocalWebService._internal();
  static final LocalWebService _instance = LocalWebService._internal();

  static bool isFileRecent(File file) {
    if (!file.existsSync()) {
      return false;
    }
    final lastModified = file.lastModifiedSync();
    final now = DateTime.now();
    final difference = now.difference(lastModified);
    return difference.inHours < 24;
  }

  static Future<void> downloadAndDecompressWebFiles(
      String targetDirectory, Logger? logger) async {
    final zipFilePath = p.join(targetDirectory, 'web.zip');
    const url =
        'https://drive.google.com/uc?export=download&id=1xhV7pWwsD9H-NSECPf0xJDc_yafL9Iwj';
    final progress = logger?.progress('Downloading files for Web UI...');
    final result = await dio.download(
      url,
      zipFilePath,
      onReceiveProgress: (count, total) {
        progress?.update(
            'Downloaded: ${(count / total * 100).toStringAsFixed(0)}%');
      },
    );

    if (result.statusCode != 200) {
      logger?.err('Failed to download web files');
      progress?.fail();
      throw Exception('Failed to download web files');
    }

    progress?.complete('Completed');
    final bytes = File(zipFilePath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    logger?.info('Saving in $targetDirectory');
    for (final file in archive) {
      final fileName = p.join(targetDirectory, file.name);
      if (file.isFile) {
        File(fileName)
          ..createSync(recursive: true)
          ..writeAsBytesSync(file.content as List<int>);
      } else {
        await Directory(fileName).create(recursive: true);
      }
    }

    logger?.info('Cleaning up zip file');
    File(zipFilePath).deleteSync();
  }
}
