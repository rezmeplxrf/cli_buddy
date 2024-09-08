import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/cli_buddy.dart';
import 'package:cli_buddy/src/common/domain/config.dart';
import 'package:cli_buddy/src/common/service/action.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/html.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
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
  static List<ChatSession>? _sessions = [];
  static String? msg;
  Future<void> start() async {
    configuration ??= await ConfigService.loadConfig().getOrThrow();
    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addHandler(_router);

    _server = await io.serve(handler, '127.0.0.1', 43210);
    _logger
        ?.info('Serving at http://${_server?.address.host}:${_server?.port}');
  }

  Handler get _router {
    final router = Router()
      ..get('/', _htmlHandler)
      ..get('/session-list', _sessionsHandler)
      ..post('/remove-all', _removeAllHandler)
      ..get('/ws', webSocketHandler(_handleWebSocket))
      ..get('/config', _getConfigHandler)
      ..post('/config', _setConfigHandler)
      ..post('/remove-session', _removeSessionHandler)
      ..post('/make-file', _makeFileHandler)
      ..get('/prompts', _getPromptsHandler)
      ..post('/prompts', _setPromptsHandler);
    return router.call;
  }

  Future<Response> _getPromptsHandler(Request request) async {
    final defaultDir = SysInfoService.getConfigDirectory();
    final filePath = p.join(defaultDir!, 'prompts.json');
    final content = await ActionService.retrieveFile(filePath);
    final jsonList = jsonDecode(content as String) as List<dynamic>;
    final prompts = jsonList.map((e) => SysPrompt.fromJson(e as Map<String, dynamic>)).toList();
    return Response.ok(jsonEncode(prompts), headers: {'content-type': 'application/json'});
  }

  Future<Response> _setPromptsHandler(Request request) async {
    try {
      final payload = await request.readAsString();

      final jsonList = jsonDecode(payload) as List<dynamic>;
      final prompts = jsonList.map((e) => SysPrompt.fromJson(e as Map<String, dynamic>)).toList();
      defaultDir ??= SysInfoService.getConfigDirectory();
      final filePath = p.join(defaultDir!, 'prompts.json');
      await ActionService.saveToFile(filePath, jsonEncode(prompts), shouldAutoOvewrite: true);
      return Response.ok({'result': 'File is created at $filePath'},
          headers: {'content-type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(
        body: {'result': 'Failed to create file - $e'},
      );
    }
  }

  Future<Response> _makeFileHandler(Request request) async {
    try {
      final payload = await request.readAsString();

      final data = jsonDecode(payload) as Map<String, dynamic>;
      final content = data['code'] as String;
      final path = data['path'] as String;
      await ActionService.saveToFile(path, content, shouldAutoOvewrite: true);
      return Response.ok({'result': 'File is created at $path'},
          headers: {'content-type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(
        body: {'result': 'Failed to create file - $e'},
      );
    }
  }

  Future<Response> _removeSessionHandler(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final sessionId = data['sessionId'];
    final result = await SessionService.removeSession(id: sessionId as int);
    if (result) {
      return Response.ok({'result': 'Session is removed'},
          headers: {'content-type': 'application/json'});
    } else {
      return Response.internalServerError(
          body: {result: 'Failed to remove session'},
          headers: {'content-type': 'application/json'});
    }
  }

  Future<Response> _getConfigHandler(Request request) async {
    configuration = await ConfigService.loadConfig().getOrNull();
    if (configuration == null) {
      return Response.notFound(
          {'result': 'Config is empty or failed to load config'},
          headers: {'content-type': 'application/json'});
    } else {
      return Response.ok(jsonEncode(configuration?.toJson()),
          headers: {'content-type': 'application/json'});
    }
  }

  Future<Response> _setConfigHandler(Request request) async {
    try {
      configuration = await ConfigService.loadConfig().getOrNull();
      final payload = await request.readAsString();
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final newConfig = Configuration.fromJson(data);
      print(newConfig);

      if (newConfig != configuration) {
        await ConfigService.saveConfig(newConfig: newConfig);
        return Response.ok(jsonEncode(configuration?.toJson()),
            headers: {'content-type': 'application/json'});
      } else {
        return Response.ok(
            {'result': 'No changes made because it is the same as the current'},
            headers: {'content-type': 'application/json'});
      }
    } catch (e) {
      _logger?.err('Failed to set config. Error: $e');
      return Response.internalServerError(
        body: {e.toString(): 'Failed to set config'},
      );
    }
  }

  Future<Response> _removeAllHandler(Request request) async {
    final result = await SessionService.removeSessions();
    if (result) {
      _sessions?.clear();
      return Response.ok(
        {'result': 'All sessions are removed'},
      );
    } else {
      return Response.internalServerError(
          body: 'Failed to remove all sessions');
    }
  }

  Future<Response> _sessionsHandler(Request request) async {
    try {
      _sessions = await SessionService.listSessions();
      if (_sessions == null || _sessions!.isEmpty) {
        return Response.notFound(
            {'result': 'Session is empty or failed to load sessions'},
            headers: {'content-type': 'application/json'});
      }
      final sessionsJson =
          jsonEncode(_sessions?.map((s) => s.toJson()).toList());
      return Response.ok(
        sessionsJson,
      );
    } catch (e) {
      return Response.internalServerError(
        body: {'result': 'Failed to load sessions - $e'},
      );
    }
  }

  void _handleWebSocket(WebSocketChannel socket) {
    webSocket = socket;
    socket.stream.listen((message) async {
      final userSentSession = ChatSession.fromJson(
          jsonDecode(message as String) as Map<String, dynamic>);
      if (message.trim().isNotEmpty) {
        webSocket?.sink
            .add(jsonEncode(const MessageChunk(type: ChunkType.start)));
        try {
          final newSession = await openRouter
              .invoke(session: userSentSession, markdown: false)
              .getOrThrow();
          final lastResponse = newSession.messages.last;
          webSocket?.sink.add(jsonEncode(
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
      webSocket = null;
    });
  }

  Future<void> stop() async {
    if (_server != null) {
      webSocket = null;
      await _server!.close(force: true);
      _logger?.info('Server stopped');
    }
  }

  static Response _htmlHandler(Request request) {
    return Response.ok(htmlContent, headers: {'content-type': 'text/html'});
  }
}
