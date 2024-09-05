import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/cli_buddy.dart';
import 'package:cli_buddy/src/common/service/config.dart';
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
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
      /* Custom styles */
      .chat-input {
        min-height: 44px;
        max-height: 200px;
      }

      .loading-indicator {
        display: inline-block;
        width: 20px;
        height: 20px;
        border: 3px solid #a0aec0;
        border-radius: 50%;
        border-top-color: #4299e1;
        animation: spin 1s ease-in-out infinite;
      }
      .sidebar {
        display: flex;
        flex-direction: column;
      }

      .session-item {
        transition: background-color 0.2s ease;
      }

      .session-item:hover {
        background-color: rgba(255, 255, 255, 0.1);
      }

      /* Scrollbar styles */
      #sessionList::-webkit-scrollbar {
        width: 6px;
      }

      #sessionList::-webkit-scrollbar-track {
        background: transparent;
      }

      #sessionList::-webkit-scrollbar-thumb {
        background-color: rgba(255, 255, 255, 0.2);
        border-radius: 3px;
      }

      #sessionList::-webkit-scrollbar-thumb:hover {
        background-color: rgba(255, 255, 255, 0.3);
      }
      @keyframes spin {
        to {
          transform: rotate(360deg);
        }
      }
    </style>
  </head>
  <body class="bg-gray-100 text-gray-900 flex h-screen">
    <div class="sidebar bg-gray-900 text-white w-64 p-4 flex flex-col">
      <button
        id="newChatBtn"
        class="bg-gray-700 hover:bg-gray-600 text-white font-semibold py-2 px-4 rounded mb-4 flex items-center"
      >
        <svg
          class="w-5 h-5 mr-2"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M12 6v6m0 0v6m0-6h6m-6 0H6"
          ></path>
        </svg>
        New chat
      </button>
      <h3 class="text-sm font-semibold uppercase mb-2 text-gray-400">
        Chat History
      </h3>
      <ul id="sessionList" class="overflow-y-auto flex-grow space-y-2"></ul>
      <button
        id="removeAllSessionsBtn"
        class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-4 rounded mt-4"
      >
        Remove All Sessions
      </button>
    </div>

    <div class="main-content flex-1 flex flex-col">
      <div id="chatContainer" class="flex-grow overflow-y-auto p-4"></div>
      <div class="input-container bg-white p-4 border-t flex">
        <textarea
          id="chatInput"
          class="chat-input w-full p-2 border rounded-l resize-none"
          placeholder="Type your message here..."
          rows="1"
        ></textarea>
        <button
          id="sendButton"
          class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-r"
        >
          Send
        </button>
      </div>
    </div>
    <div
      id="connectionStatus"
      class="fixed top-0 right-0 m-4 p-2 rounded text-white"
    ></div>
    <script>
      const baseUrl = "http://localhost:43210";
      const wsUrl = "ws://localhost:43210/ws";
      const sessionList = document.getElementById("sessionList");
      const chatContainer = document.getElementById("chatContainer");
      const chatInput = document.getElementById("chatInput");
      const newChatBtn = document.getElementById("newChatBtn");
      const removeAllSessionsBtn = document.getElementById(
        "removeAllSessionsBtn"
      );
      let socket;
      let isFirstResponse = false;
      let currentMessageElement;
      let isWebSocketConnected = false;
      let messageQueue = [];
      let chunkBuffer = "";
      let throttleTimeout;

      async function fetchSessions() {
        try {
          const response = await fetch(`${baseUrl}/sessions`);
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          const sessions = await response.json();
          isFirstResponse = false;
          populateSidebar(sessions);
        } catch (error) {
          console.error("Error fetching sessions:", error);
        }
      }

      function populateSidebar(sessions) {
        sessionList.innerHTML = "";
        sessions.sort((a, b) => b.id - a.id);
        sessions.forEach((session) => {
          const li = document.createElement("li");
          li.className =
            "session-item bg-gray-800 hover:bg-gray-700 rounded p-2 cursor-pointer transition-colors duration-200";
          const firstUserMessage = session.messages.find(
            (msg) => msg.role === "user"
          );
          const title = firstUserMessage
            ? firstUserMessage.content.substring(0, 30)
            : "New Chat";
          li.innerHTML = `
      <div class="session-title font-semibold mb-1">${title}${
            title.length >= 30 ? "..." : ""
          }</div>
      <div class="session-info text-xs text-gray-400">
        <div>ID: ${session.id}</div>
        <div>Messages: ${session.messages.length}</div>
        <div>Model: ${session.model}</div>
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
          isWebSocketConnected = true;
          updateConnectionStatus();
          processMessageQueue();
        };

        socket.onclose = function (event) {
          console.log("WebSocket connection closed");
          isWebSocketConnected = false;
          updateConnectionStatus();
          setTimeout(connectWebSocket, 1000);
        };

        socket.onerror = function (error) {
          console.error("WebSocket error:", error);
        };

        socket.onmessage = function (event) {
          try {
            const data = JSON.parse(event.data);
            switch (data.type) {
              case "start":
                startNewMessage();
                break;
              case "chunk":
                appendChunk(data.content);
                break;
              case "end":
                finalizeMessage(data.usage);
                if (!isFirstResponse) {
                  isFirstResponse = true;
                  fetchSessions();
                }
                break;
              default:
                console.error("Unknown message type:", data.type);
            }
          } catch (error) {
            console.error("Error parsing WebSocket message:", error);
          }
        };
      }

      function processMessageQueue() {
        while (messageQueue.length > 0 && isWebSocketConnected) {
          const message = messageQueue.shift();
          socket.send(JSON.stringify(message));
        }
      }

      function addMessageToChat(message) {
        const div = document.createElement("div");
        div.className = `message ${message.role}-message bg-white rounded-lg shadow-md p-4 mb-4`;
        const timestamp = new Date(message.timestamp).toLocaleString();
        div.innerHTML = `
          <div class="font-bold text-blue-600 mb-1">${capitalizeFirstLetter(
            message.role
          )}</div>
          <div class="text-sm text-gray-500 mb-2">${timestamp}</div>
          <div class="prose">${marked.parse(message.content)}</div>
        `;
        if (message.usage) {
          div.innerHTML += `
            <div class="text-sm text-gray-500 mt-2 pt-2 border-t">
              Prompt Tokens: ${message.usage.prompt_tokens || 0}, 
              Completion Tokens: ${message.usage.completion_tokens || 0}, 
              Total Tokens: ${message.usage.total_tokens || 0},
              Response Time: ${message.usage.response_time || 0}s
            </div>
          `;
        }
        chatContainer.appendChild(div);
        chatContainer.scrollTop = chatContainer.scrollHeight;
      }

      function startNewMessage() {
        currentMessageElement = document.createElement("div");
        currentMessageElement.className =
          "message assistant-message bg-white rounded-lg shadow-md p-4 mb-4";
        currentMessageElement.innerHTML = `
          <div class="font-bold text-blue-600 mb-1">Assistant</div>
          <div class="text-sm text-gray-500 mb-2">${new Date().toLocaleString()}</div>
          <div class="flex items-center">
            <div class="loading-indicator mr-2"></div>
            <div>Thinking...</div>
          </div>
          <div class="prose"></div>
        `;
        chatContainer.appendChild(currentMessageElement);
        chatContainer.scrollTop = chatContainer.scrollHeight;
      }

  function appendChunk(content) {
        if (currentMessageElement) {
          chunkBuffer += content;
          if (!throttleTimeout) {
            throttleTimeout = setTimeout(() => {
              const proseDiv = currentMessageElement.querySelector(".prose");
              proseDiv.innerHTML = marked.parse(chunkBuffer);
              
              chatContainer.scrollTop = chatContainer.scrollHeight;
              throttleTimeout = null;
            }, 50);
          }
        }
      }

      function finalizeMessage(usage) {
        if (currentMessageElement) {
          const loadingDiv =
            currentMessageElement.querySelector(".flex.items-center");
          if (loadingDiv) {
            loadingDiv.remove();
          }

          if (usage) {
            const usageDiv = document.createElement("div");
            usageDiv.className = "text-sm text-gray-500 mt-2 pt-2 border-t";
            usageDiv.innerHTML = `
              Prompt Tokens: ${usage.prompt_tokens || 0}, 
              Completion Tokens: ${usage.completion_tokens || 0}, 
              Total Tokens: ${usage.total_tokens || 0},
              Response Time: ${usage.response_time || 0}s
            `;
            currentMessageElement.appendChild(usageDiv);
          }
          chatContainer.scrollTop = chatContainer.scrollHeight;
        }
        chunkBuffer = "";
        currentMessageElement = null;
      }

      function sendMessage() {
        const content = chatInput.value.trim();
        if (content) {
          const message = {
            role: "user",
            content: content,
            timestamp: Date.now(),
          };

          if (isWebSocketConnected) {
            socket.send(JSON.stringify(message));
          } else {
            messageQueue.push(message);
          }

          addMessageToChat(message);
          chatInput.value = "";
          adjustTextareaHeight();
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

      async function removeAllSessions() {
        try {
          const response = await fetch(`${baseUrl}/remove-all-sessions`, {
            method: "PUT",
            headers: {
              "Content-Type": "application/json",
            },
          });

          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }

          sessionList.innerHTML = "";
          chatContainer.innerHTML = "";
          await createNewSession();
        } catch (error) {
          console.error("Error removing all sessions:", error);
        }
      }
      function updateConnectionStatus() {
        const statusElement = document.getElementById("connectionStatus");
        if (isWebSocketConnected) {
          statusElement.textContent = "Connected";
          statusElement.classList.add("bg-green-500");
          statusElement.classList.remove("bg-red-500");
        } else {
          statusElement.textContent = "Disconnected";
          statusElement.classList.add("bg-red-500");
          statusElement.classList.remove("bg-green-500");
        }
      }
      newChatBtn.addEventListener("click", createNewSession);
      removeAllSessionsBtn.addEventListener("click", removeAllSessions);

      chatInput.addEventListener("input", adjustTextareaHeight);

      const sendButton = document.getElementById("sendButton");

      sendButton.addEventListener("click", sendMessage);

      chatInput.addEventListener("keydown", function (event) {
        if (event.key === "Enter" && !event.shiftKey) {
          event.preventDefault();
          sendMessage();
        }
      });

      function adjustTextareaHeight() {
        chatInput.style.height = "auto";
        chatInput.style.height = `${Math.min(chatInput.scrollHeight, 200)}px`;
      }

      connectWebSocket();
      fetchSessions();
      createNewSession();
    </script>
  </body>
</html>
''';
