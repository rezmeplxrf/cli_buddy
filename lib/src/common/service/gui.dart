import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/cli_buddy.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GUIService {
  factory GUIService() => _instance;
  GUIService._internal();
  static final GUIService _instance = GUIService._internal();

  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;
  static HttpServer? _server;
  static WebSocketChannel? webSocket;
  static List<ChatSession>? _sessions = [];
  static ChatSession? _currentSession;
  static String? msg;
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
      ..get('/sessions', _sessionsHandler)
      ..put('/remove-all-sessions', _removeAllSessionsHandler)
      ..post('/select-session', _selectSessionHandler)
      ..post('/new-session', _newSessionHandler)
      ..get('/ws', webSocketHandler(_handleWebSocket));
    return router.call;
  }

  Future<Response> _newSessionHandler(Request request) async {
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
      return Response.ok({'message': 'All sessions are removed'},
          headers: {'content-type': 'application/json'});
    } else {
      return Response.internalServerError(
          body: 'Failed to remove all sessions');
    }
  }

  Future<Response> _sessionsHandler(Request request) async {
    _sessions = await SessionService.listSessions(_logger!);
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
      //  const message = {
      //         role: "user",
      //         content: content,
      //         timestamp: Date.now(),
      //       };
      // parse message
      final clientMsg = UserMessage.fromJson(
          jsonDecode(message as String) as Map<String, dynamic>);
      if (_currentSession != null && clientMsg.content != null) {
        final userMsg = Message(
            role: Role.user,
            content: clientMsg.content!,
            timestamp: DateTime.now().millisecondsSinceEpoch);
        final tempSession = _currentSession!
            .copyWith(messages: [..._currentSession!.messages, userMsg]);

        // Start a new response
        webSocket?.sink.add(jsonEncode({'type': 'start'}));

        _currentSession = await openRouter
            .invoke(session: tempSession, markdown: false)
            .getOrThrow();

        // Send usage information at the end
        final lastResponse = _currentSession?.messages.last;
        webSocket?.sink.add(jsonEncode({
          'type': 'end',
          'usage': lastResponse?.usage?.toJson(),
        }));
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
    return Response.ok(_htmlContent, headers: {'content-type': 'text/html'});
  }
}

const _htmlContent = r'''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Buddy Chat</title>
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
        min-width: 300px;
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
      <button class="new-chat-btn" id="newChatBtn">+ New chat</button>
      <div>
        <h3>Chat History</h3>
        <ul class="session-list" id="sessionList"></ul>
      </div>
    </div>
    <div class="main-content">
      <div class="chat-container" id="chatContainer"></div>
      <div class="input-container">
        <input
          type="text"
          class="chat-input"
          id="chatInput"
          placeholder="Type your message here..."
        />
      </div>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", () => {
        const baseUrl = "http://localhost:43210";
        const wsUrl = "ws://localhost:43210/ws";
        const sessionList = document.getElementById("sessionList");
        const chatContainer = document.getElementById("chatContainer");
        const chatInput = document.getElementById("chatInput");
        const newChatBtn = document.getElementById("newChatBtn");
        let socket;

        async function fetchSessions() {
          try {
            const response = await fetch(`${baseUrl}/sessions`);
            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }
            const sessions = await response.json();
            populateSidebar(sessions);
          } catch (error) {
            console.error("Error fetching sessions:", error);
          }
        }

        function populateSidebar(sessions) {
          sessionList.innerHTML = "";
          // Sort sessions by id in descending order
          sessions.sort((a, b) => b.id - a.id);
          sessions.forEach((session) => {
            const li = document.createElement("li");
            li.className = "session-item";
            const firstUserMessage = session.messages.find(
              (msg) => msg.role === "user"
            );
            const title = firstUserMessage
              ? firstUserMessage.content.substring(0, 30)
              : "New Chat";
            li.innerHTML = `
      <div class="session-title">${title}${
              title.length >= 30 ? "..." : ""
            }</div>
      <div class="session-info">
        ID: ${session.id}<br>
        Messages: ${session.messages.length}<br>
        Model: ${session.model}
      </div>
    `;
            li.addEventListener("click", () => selectSession(session.id));
            sessionList.appendChild(li);
          });
        }

        async function selectSession(sessionId) {
          try {
            const response = await fetch(`${baseUrl}/select-session`, {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
              body: JSON.stringify({ sessionId: sessionId }),
            });

            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }

            const session = await response.json();
            displayChat(session);
          } catch (error) {
            console.error("Error selecting session:", error);
          }
        }

        function displayChat(session) {
          chatContainer.innerHTML = "";
          session.messages.forEach((message) => {
            addMessageToChat(message);
          });
        }

        function capitalizeFirstLetter(string) {
          return string.charAt(0).toUpperCase() + string.slice(1);
        }

        function connectWebSocket() {
          socket = new WebSocket(wsUrl);

          socket.onopen = function (event) {
            console.log("WebSocket connection established");
          };

          socket.onmessage = function (event) {
            try {
              const data = JSON.parse(event.data);
              switch (data.type) {
                case "start":
                  // Start a new message
                  startNewMessage();
                  break;
                case "chunk":
                  // Append chunk to the current message
                  appendChunk(data.content);
                  break;
                case "end":
                  // Finalize the message and add usage information
                  finalizeMessage(data.usage);
                  break;
                default:
                  console.error("Unknown message type:", data.type);
              }
            } catch (error) {
              console.error("Error parsing WebSocket message:", error);
            }
          };

          socket.onclose = function (event) {
            console.log("WebSocket connection closed");
            setTimeout(connectWebSocket, 1000);
          };

          socket.onerror = function (error) {
            console.error("WebSocket error:", error);
          };
        }

        function addMessageToChat(message) {
          const div = document.createElement("div");
          div.className = `message ${message.role}-message`;
          const timestamp = new Date(message.timestamp).toLocaleString();
          div.innerHTML = `
                <div class="message-role">${capitalizeFirstLetter(
                  message.role
                )}</div>
                <div class="message-timestamp">${timestamp}</div>
                <p>${message.content}</p>
            `;
          if (message.usage) {
            div.innerHTML += `
                    <div class="message-usage">
                        Prompt Tokens: ${message.usage.prompt_tokens || 0}, 
                        Completion Tokens: ${
                          message.usage.completion_tokens || 0
                        }, 
                        Total Tokens: ${message.usage.total_tokens || 0},
                        Response Time: ${message.usage.response_time || 0}s
                    </div>
                `;
          }
          chatContainer.appendChild(div);
          chatContainer.scrollTop = chatContainer.scrollHeight;
        }

        let currentMessageElement;

        function startNewMessage() {
          currentMessageElement = document.createElement("div");
          currentMessageElement.className = "message assistant-message";
          currentMessageElement.innerHTML = `
    <div class="message-role">Assistant</div>
    <div class="message-timestamp">${new Date().toLocaleString()}</div>
    <p></p>
  `;
          chatContainer.appendChild(currentMessageElement);
        }

        function appendChunk(content) {
          if (currentMessageElement) {
            const p = currentMessageElement.querySelector("p");
            p.innerHTML += content;
            chatContainer.scrollTop = chatContainer.scrollHeight;
          }
        }

        function finalizeMessage(usage) {
          if (currentMessageElement && usage) {
            const usageDiv = document.createElement("div");
            usageDiv.className = "message-usage";
            usageDiv.innerHTML = `
      Prompt Tokens: ${usage.prompt_tokens || 0}, 
      Completion Tokens: ${usage.completion_tokens || 0}, 
      Total Tokens: ${usage.total_tokens || 0},
      Response Time: ${usage.response_time || 0}s
    `;
            currentMessageElement.appendChild(usageDiv);
            chatContainer.scrollTop = chatContainer.scrollHeight;
          }
          currentMessageElement = null;
        }

        function sendMessage() {
          const content = chatInput.value.trim();
          if (content && socket && socket.readyState === WebSocket.OPEN) {
            const message = {
              role: "user",
              content: content,
              timestamp: Date.now(),
            };
            socket.send(JSON.stringify(message));
            addMessageToChat(message);
            chatInput.value = "";
          }
        }

        async function createNewSession() {
          try {
            const response = await fetch(`${baseUrl}/new-session`, {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
              },
            });

            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }

            const session = await response.json();
            displayChat(session);
            await fetchSessions();
          } catch (error) {
            console.error("Error creating new session:", error);
          }
        }

        newChatBtn.addEventListener("click", createNewSession);

        chatInput.addEventListener("keypress", function (event) {
          if (event.key === "Enter") {
            sendMessage();
          }
        });
        fetchSessions();
        connectWebSocket();
        createNewSession();
      });
    </script>
  </body>
</html>
''';
