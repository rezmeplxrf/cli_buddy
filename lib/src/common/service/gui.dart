import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

class GUIService {
  factory GUIService() => _instance;
  GUIService._internal();
  static final GUIService _instance = GUIService._internal();

  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;
  static HttpServer? _server;

  Future<void> start() async {
    final handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(_router);

    _server = await io.serve(handler, 'localhost', 43210);
    _logger
        ?.info('Serving at http://${_server?.address.host}:${_server?.port}');
  }

  Handler get _router {
    final router = Router()
      ..get('/', _htmlHandler)
      ..get('/sessions', _sessionsHandler);
    return router.call;
  }

  Future<Response> _sessionsHandler(Request request) async {
    final sessions = await SessionService.listSessions(_logger!);
    if (sessions == null) {
      return Response.internalServerError(body: 'Failed to load sessions');
    }
    final sessionsJson = jsonEncode(sessions.map((s) => s.toJson()).toList());
    return Response.ok(sessionsJson,
        headers: {'content-type': 'application/json'});
  }

  Future<void> stop() async {
    if (_server != null) {
      await _server!.close(force: true);
      _logger?.info('Server stopped');
    }
  }

  static Response _htmlHandler(Request request) {
    return Response.ok(_htmlContent, headers: {'content-type': 'text/html'});
  }
}

const _htmlContent = r'''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Improved ChatGPT-like Interface</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 300px;
            background-color: #202123;
            color: white;
            padding: 20px;
            overflow-y: auto;
        }
        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            background-color: #343541;
        }
        .chat-container {
            flex-grow: 1;
            overflow-y: auto;
            padding: 20px;
        }
        .input-container {
            padding: 20px;
            background-color: #40414f;
        }
        .chat-input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background-color: #40414f;
            color: white;
        }
        .message {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
        }
        .user-message {
            background-color: #5c5e6f;
            color: white;
        }
        .system-message {
            background-color: #2d2e38;
            color: #a9a9a9;
            font-style: italic;
        }
        .assistant-message {
            background-color: #444654;
            color: white;
        }
        .new-chat-btn {
            background-color: #202123;
            color: white;
            border: 1px solid white;
            padding: 10px;
            margin-bottom: 20px;
            cursor: pointer;
            width: 100%;
        }
        .session-list {
            list-style-type: none;
            padding: 0;
        }
        .session-item {
            border: 1px solid #444;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .session-item:hover {
            background-color: #2d2e38;
        }
        .session-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .session-info {
            font-size: 0.8em;
            color: #aaa;
        }
        .message-role {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .message-timestamp {
            font-size: 0.8em;
            color: #aaa;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <button class="new-chat-btn">+ New chat</button>
        <div>
            <h3>Chat History</h3>
            <ul class="session-list" id="sessionList">
                <!-- Sessions will be populated here -->
            </ul>
        </div>
    </div>
    <div class="main-content">
        <div class="chat-container" id="chatContainer">
            <!-- Chat messages will be populated here -->
        </div>
        <div class="input-container">
            <input type="text" class="chat-input" placeholder="Type your message here...">
        </div>
    </div>

    <script>
        const baseUrl = 'http://localhost:43210';
        const sessionList = document.getElementById('sessionList');
        const chatContainer = document.getElementById('chatContainer');

        // Fetch sessions from the server
        async function fetchSessions() {
            try {
                const response = await fetch(`${baseUrl}/sessions`);
                const sessions = await response.json();
                populateSidebar(sessions);
            } catch (error) {
                console.error('Error fetching sessions:', error);
            }
        }

        // Populate sidebar with sessions
        function populateSidebar(sessions) {
            sessionList.innerHTML = '';
            sessions.forEach(session => {
                const li = document.createElement('li');
                li.className = 'session-item';
                const firstUserMessage = session.messages.find(msg => msg.role === 'user');
                const title = firstUserMessage ? firstUserMessage.content.substring(0, 30) : 'New Chat';
                li.innerHTML = `
                    <div class="session-title">${title}${title.length >= 30 ? '...' : ''}</div>
                    <div class="session-info">
                        ID: ${session.id}<br>
                        Messages: ${session.messages.length}<br>
                        Model: ${session.model}
                    </div>
                `;
                li.addEventListener('click', () => displayChat(session));
                sessionList.appendChild(li);
            });
        }

        // Display chat messages for selected session
        function displayChat(session) {
            chatContainer.innerHTML = '';
            session.messages.forEach(message => {
                const div = document.createElement('div');
                div.className = `message ${message.role}-message`;
                const timestamp = new Date(message.timestamp).toLocaleString();
                div.innerHTML = `
                    <div class="message-role">${capitalizeFirstLetter(message.role)}:</div>
                    <div class="message-timestamp">${timestamp}</div>
                    <p>${message.content}</p>
                `;
                chatContainer.appendChild(div);
            });
        }
        function capitalizeFirstLetter(string) {
            return string.charAt(0).toUpperCase() + string.slice(1);
        }

        // Initial fetch of sessions
        fetchSessions();
    </script>
</body>
</html>
''';
