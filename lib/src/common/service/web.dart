import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/cli_buddy.dart';
import 'package:cli_buddy/src/common/domain/config.dart';
import 'package:cli_buddy/src/common/service/action.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:cli_buddy/src/common/service/global.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:archive/archive_io.dart';

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
    configuration ??= await ConfigService.loadConfig().getOrThrow();
    defaultDir ??= SysInfoService.getConfigDirectory();

    // Ensure the directory exists
    final fileDirectory = p.join(defaultDir!, 'web');
    _logger?.info('File Directory: $fileDirectory');
    final directory = Directory(fileDirectory);
    if (!directory.existsSync()) {
      await _downloadAndDecompressWebFiles(defaultDir!);
    }

    final staticHandler = createStaticHandler(
      fileDirectory,
      defaultDocument: 'index.html',
      listDirectories: true,
    );
    final routerHandler = HandlerService.router;

    final cascade = Cascade().add(staticHandler).add(routerHandler);

    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addMiddleware(MiddlerWareService.addCustomHeaders())
        .addHandler(cascade.handler);

    _server = await io.serve(handler, address, port);
    _logger
        ?.info('Serving at http://${_server?.address.host}:${_server?.port}');
  }

  Future<void> stop() async {
    if (_server != null) {
      WebService.webSocket = null;
      await _server!.close(force: true);
      _logger?.info('Server stopped');
    }
  }

  Future<void> _downloadAndDecompressWebFiles(String targetDirectory) async {
    final zipFilePath = p.join(targetDirectory, 'web.zip');
    const url =
        'https://drive.google.com/uc?export=download&id=1BUHFKOJBv68n3btCF3c_JJAjX4cL9icM';

    await dio.download(url, zipFilePath);
    final bytes = File(zipFilePath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

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

    // Remove the zip file
    File(zipFilePath).deleteSync();
  }
}

class HandlerService {
  factory HandlerService() => _instance;
  HandlerService._internal();
  static final HandlerService _instance = HandlerService._internal();
  static const jsonHeaders = {'content-type': 'application/json'};

  static Handler get router {
    final router = Router()
      // ..get('/', _htmlHandler)
      ..get('/session-list', sessionsHandler)
      ..post('/remove-all', _removeAllHandler)
      ..get('/ws', webSocketHandler(_handleWebSocket))
      ..get('/config', _getConfigHandler)
      ..post('/config', _setConfigHandler)
      ..post('/remove-session', _removeSessionHandler)
      ..post('/make-file', _makeFileHandler)
      ..get('/prompts', _getPromptsHandler)
      ..post('/prompts', _setPromptsHandler)
      ..get('/models', _getModelsHandler)
      ..post('/parameters', _getParametersHandler);
    return router.call;
  }

  static Future<Response> _getModelsHandler(Request request) async {
    try {
      final models = await openRouter.getModelList().getOrThrow();
      return Response.ok(jsonEncode(models), headers: jsonHeaders);
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to get models - $e',
      );
    }
  }

  static Future<Response> _getParametersHandler(Request request) async {
    try {
      final payload = await request.readAsString();
      final json = jsonDecode(payload) as Map<String, dynamic>;
      final model = json['model'] as String;
      final parameters =
          await openRouter.getParameterInfo(model: model).getOrThrow();
      return Response.ok(jsonEncode(parameters.toJson()), headers: jsonHeaders);
    } catch (e) {
      return Response.internalServerError(
        body: 'Failed to get models - $e',
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
        'File is created at $filePath',
      );
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
      return Response.ok({'result': 'File is created at $path'},
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
      return Response.ok({'result': 'Session is removed'},
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
            {'result': 'No changes made because it is the same as the current'},
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

  static Future<Response> sessionsHandler(Request request) async {
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

  static void _handleWebSocket(WebSocketChannel socket) {
    WebService.webSocket = socket;
    socket.stream.listen((message) async {
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
          return;
        }
      }
    }, onDone: () {
      WebService.webSocket = null;
    });
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
