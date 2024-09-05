import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/cli_buddy.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/html.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:cli_buddy/src/common/service/session.dart';
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
      ..put('/remove-all-sessions', _removeAllSessionsHandler)
      ..post('/select-session', _selectSessionHandler)
      ..post('/new-session', _newSessionHandler)
      ..get('/ws', webSocketHandler(_handleWebSocket));
    return router.call;
  }

  Future<Response> _newSessionHandler(Request request) async {
    configuration ??= await ConfigService.loadConfig().getOrThrow();
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

  Future<Response> _removeAllSessionsHandler(Request request) async {
    _currentSession = null;
    _sessions?.clear();
    final result = await SessionService.removeSessions();
    if (result) {
      return Response.ok('All sessions are removed',
          headers: {'content-type': 'application/json'});
    } else {
      return Response.internalServerError(
          body: 'Failed to remove all sessions');
    }
  }

  Future<Response> _sessionsHandler(Request request) async {
    _sessions = await SessionService.listSessions();
    if (_sessions == null || _sessions!.isEmpty) {
      return Response.internalServerError(
          body: 'Session is empty or failed to load sessions');
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
      final userMsg = Message.fromJson(
          jsonDecode(message as String) as Map<String, dynamic>);
      if (_currentSession != null && userMsg.content.trim().isNotEmpty) {
        final tempSession = _currentSession!
            .copyWith(messages: [..._currentSession!.messages, userMsg]);

        // Start a new response
        webSocket?.sink
            .add(jsonEncode(const MessageChunk(type: ChunkType.start)));

        _currentSession = await openRouter
            .invoke(session: tempSession, markdown: false)
            .getOrThrow();

        // Send usage information at the end
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
