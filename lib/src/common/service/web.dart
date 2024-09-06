import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/cli_buddy.dart';
import 'package:cli_buddy/src/common/domain/config.dart';
import 'package:cli_buddy/src/common/service/action.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/html.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:collection/collection.dart';
import 'package:mason_logger/mason_logger.dart';
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
  static ChatSession? _currentSession;
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
      ..get('/sessions', _sessionsHandler)
      ..post('/remove-all', _removeAllHandler)
      ..post('/select-session', _selectSessionHandler)
      ..post('/new-session', _newSessionHandler)
      ..get('/ws', webSocketHandler(_handleWebSocket))
      ..get('/config', _getConfigHandler)
      ..post('/config', _setConfigHandler)
      ..post('/remove-session', _removeSessionHandler)
      ..post('/make-file', _makeFileHandler)
      
      ;
    return router.call;
  }

  Future<Response> _makeFileHandler(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final content = data['code'] as String;
    final path = data['path'] as String;
   await ActionService.saveToFile(path, content, shouldAutoOvewrite: true);
    return Response.ok('File is created');
  }

  Future<Response> _removeSessionHandler(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final sessionId = data['sessionId'];
    final result = await SessionService.removeSession(id: sessionId as int);
    if (result) {
      return Response.ok(
        'Session is removed',
      );
    } else {
      return Response.internalServerError(body: 'Failed to remove session');
    }
  }

  Future<Response> _getConfigHandler(Request request) async {
    configuration = await ConfigService.loadConfig().getOrNull();
    if (configuration == null) {
      return Response.notFound('Config is empty or failed to load config');
    } else {
      return Response.ok(jsonEncode(configuration?.toJson()),
          headers: {'content-type': 'application/json'});
    }
  }

  Future<Response> _setConfigHandler(Request request) async {
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
          'No changes made because it is the same as the current',
          headers: {'content-type': 'text/plain'});
    }
  }

  Future<Response> _newSessionHandler(Request request) async {
    // Check for an existing session without user messages
    final existingSession = _sessions?.firstWhereOrNull(
      (session) =>
          session.messages.length == 1 &&
          session.messages.first.role == Role.system,
    );

    if (existingSession != null) {
      _currentSession = existingSession;
      return Response.ok(jsonEncode(_currentSession?.toJson()),
          headers: {'content-type': 'application/json'});
    }

    // Create a new session if no such session exists
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final sysMsg = Message(
        role: Role.system,
        content: PromptService.chat(),
        timestamp: currentTime);
    _currentSession = ChatSession(id: currentTime, messages: [sysMsg]);
    _sessions?.add(_currentSession!);

    return Response.ok(jsonEncode(_currentSession?.toJson()),
        headers: {'content-type': 'application/json'});
  }

  Future<Response> _removeAllHandler(Request request) async {
    final result = await SessionService.removeSessions();
    if (result) {
      _currentSession = null;
      _sessions?.clear();
      return Response.ok(
        'All sessions are removed',
      );
    } else {
      return Response.internalServerError(
          body: 'Failed to remove all sessions');
    }
  }

  Future<Response> _sessionsHandler(Request request) async {
    _sessions = await SessionService.listSessions();
    if (_sessions == null || _sessions!.isEmpty) {
      return Response.notFound('Session is empty or failed to load sessions');
    }
    final sessionsJson = jsonEncode(_sessions?.map((s) => s.toJson()).toList());
    return Response.ok(sessionsJson,
        headers: {'content-type': 'application/json'});
  }

  Future<Response> _selectSessionHandler(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final sessionId = data['sessionId'];

    _currentSession =
        _sessions?.firstWhere((session) => session.id == sessionId);
    if (_currentSession == null) {
      return Response.notFound('Session is not found');
    }

    return Response.ok(jsonEncode(_currentSession?.toJson()),
        headers: {'content-type': 'application/json'});
  }

  void _handleWebSocket(WebSocketChannel socket) {
    webSocket = socket;
    socket.stream.listen((message) async {
      final userSentSession = ChatSession.fromJson(
          jsonDecode(message as String) as Map<String, dynamic>);
      if (_currentSession != null && message.trim().isNotEmpty) {
        webSocket?.sink
            .add(jsonEncode(const MessageChunk(type: ChunkType.start)));
        try {
          _currentSession = await openRouter
              .invoke(session: userSentSession, markdown: false)
              .getOrThrow();
        } catch (e) {
          const msgChunk = MessageChunk(
              type: ChunkType.error,
              content: 'Error while making API request.');
          WebService.webSocket?.sink.add(jsonEncode(msgChunk));
          return;
        }

        final lastResponse = _currentSession?.messages.last;
        webSocket?.sink.add(jsonEncode(
            MessageChunk(type: ChunkType.end, usage: lastResponse?.usage)));
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
