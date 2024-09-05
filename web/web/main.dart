import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math';
import 'package:buddy_gui/open_router.dart';
import 'package:buddy_gui/session.dart';
import 'package:collection/collection.dart';
import 'package:web/web.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:dio/dio.dart';

const String baseUrl = 'http://127.0.0.1:43210';
const String wsUrl = 'ws://127.0.0.1:43210/ws';

class WebSocketManager {
  static WebSocket? socket;
  static bool isWebSocketConnected = false;
  static List<Message> messageQueue = [];

  void connectWebSocket(
      Function onOpen, Function onClose, Function onError, Function onMessage) {
    socket = WebSocket(wsUrl);

    socket?.onOpen.listen((event) {
      print('WebSocket connection established');
      isWebSocketConnected = true;
      onOpen();
      processMessageQueue();
    });

    socket?.onClose.listen((event) {
      print('WebSocket connection closed');
      isWebSocketConnected = false;
      onClose();
      Future.delayed(Duration(seconds: 1),
          () => connectWebSocket(onOpen, onClose, onError, onMessage));
    });

    socket?.onError.listen((error) {
      print('WebSocket error: $error');
      onError(error);
    });

    socket?.onMessage.listen((MessageEvent event) {
      try {
        final data = jsonDecode(event.data as String);
        onMessage(data);
      } catch (error) {
        print('Error parsing WebSocket message: $error');
      }
    });
  }

  void processMessageQueue() {
    while (messageQueue.isNotEmpty && isWebSocketConnected) {
      final message = messageQueue.removeAt(0);
      socket?.send(jsonEncode(message).toJS);
    }
  }

  void sendMessage(Message message) {
    if (isWebSocketConnected) {
      socket?.send(jsonEncode(message).toJS);
    } else {
      messageQueue.add(message);
    }
  }
}

class ChatApp {
  final dio = Dio();
  final sessionList = document.querySelector('#sessionList') as UListElement;
  final chatContainer = document.querySelector('#chatContainer') as DivElement;
  final chatInput = document.querySelector('#chatInput') as TextAreaElement;
  final newChatBtn = document.querySelector('#newChatBtn') as ButtonElement;
  final removeAllSessionsBtn =
      document.querySelector('#removeAllSessionsBtn') as ButtonElement;
  final sendButton = document.querySelector('#sendButton') as ButtonElement;
  final connectionStatus =
      document.querySelector('#connectionStatus') as DivElement;

  var isFirstResponse = false;
  DivElement? currentMessageElement;
  var chunkBuffer = StringBuffer();
  var isFirstChunk = true;

  final WebSocketManager webSocketManager = WebSocketManager();

  ChatApp() {
    newChatBtn.onClick.listen((_) => createNewSession());
    removeAllSessionsBtn.onClick.listen((_) => removeAllSessions());
    chatInput.onInput.listen((_) => adjustTextareaHeight());
    sendButton.onClick.listen((_) => sendMessage());
    chatInput.onKeyDown.listen((event) {
      if (event.keyCode == KeyCode.ENTER && !event.shiftKey) {
        event.preventDefault();
        sendMessage();
      }
    });

    webSocketManager.connectWebSocket(
      updateConnectionStatus,
      updateConnectionStatus,
      (error) => print('WebSocket error: $error'),
      handleWebSocketMessage,
    );

    fetchSessions();
    createNewSession();
  }

  Future<void> fetchSessions() async {
    try {
      final response = await dio.get('$baseUrl/sessions');
      final data = response.data as List<dynamic>;
      final sessions = data.map((json) => ChatSession.fromJson(json)).toList();
      isFirstResponse = false;
      populateSidebar(sessions);
    } catch (error) {
      print('Error fetching sessions: $error');
    }
  }

  void populateSidebar(List<ChatSession> sessions) {
    print("populateSidebar: ${sessions.length}");
    sessionList.children.clear();
    sessions.sort((a, b) => b.id - a.id);
    for (var i = 0; i < sessions.length; i++) {
      final session = sessions[i];
      final li = LIElement()
        ..className =
            'session-item bg-gray-800 hover:bg-gray-700 rounded p-2 cursor-pointer transition-colors duration-200 fade-in'
        ..style.animationDelay = '${i * 0.05}s';

      final firstUserMessage = session.messages.firstWhereOrNull(
        (msg) => msg.role == Role.user,
      );

      final title = firstUserMessage != null
          ? firstUserMessage.content
              .substring(0, min(30, firstUserMessage.content.length))
          : 'New Chat';

      li.innerHtml = '''
      <div class="session-title font-semibold mb-1">$title${firstUserMessage != null && firstUserMessage.content.length > 30 ? '...' : ''}</div>
      <div class="session-info text-xs text-gray-400"><div>ID: ${session.id}</div>
      <div>Messages: ${session.messages.length}</div><div>Model: ${session.model}</div></div>''';

      li.onClick.listen((_) => selectSession(session.id));
      sessionList.children.add(li);
    }
  }

  Future<void> selectSession(int sessionId) async {
    try {
      final response = await dio.post(
        '$baseUrl/select-session',
        data: {'sessionId': sessionId},
      );
      final session = ChatSession.fromJson(response.data);
      displayChat(session);
    } catch (error) {
      print('Error selecting session: $error');
    }
  }

  void displayChat(ChatSession session) {
    chatContainer.children.clear();
    for (final message in session.messages) {
      addMessageToChat(message);
    }
  }

  String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

  void addMessageToChat(Message message) {
    final div = DivElement()
      ..className =
          'message ${message.role.name}-message bg-white rounded-lg shadow-md p-4 mb-4 fade-in';

    final timestamp = DateTime.fromMillisecondsSinceEpoch(message.timestamp)
        .toLocal()
        .toString();

    div.innerHtml = '''
    <div class="font-bold text-blue-600 mb-1">${capitalizeFirstLetter(message.role.name)}</div>
    <div class="text-sm text-gray-500 mb-2">$timestamp</div>
    <div class="prose">${md.markdownToHtml(message.content)}</div>''';

    if (message.usage != null) {
      div.innerHtml = '''
    ${div.innerHtml}  
    <div class="text-sm text-gray-500 mt-2 pt-2 border-t">
    Prompt Tokens: ${message.usage?.promptTokens ?? 0}, 
    Completion Tokens: ${message.usage?.completionTokens ?? 0}, 
    Total Tokens: ${message.usage?.totalTokens ?? 0},
    Response Time: ${message.usage?.responseTime ?? 0}s</div>''';
    }

    chatContainer.children.add(div);
    chatContainer.scrollTop = chatContainer.scrollHeight;
    addCodeBlockButtons(div);
  }

  void startNewMessage() {
    currentMessageElement = DivElement()
      ..className =
          'message assistant-message bg-white rounded-lg shadow-md p-4 mb-4'
      ..innerHtml = '''
        <div class="font-bold text-blue-600 mb-1">Assistant</div>
        <div class="text-sm text-gray-500 mb-2">${DateTime.now().toLocal()}</div>
        <div class="flex items-center">
            <div class="loading-indicator mr-2"></div>
            <div>Thinking...</div>
        </div>
        <div class="prose"></div>
      ''';
    if (currentMessageElement != null) {
      chatContainer.children.add(currentMessageElement!);
      chatContainer.scrollTop = chatContainer.scrollHeight;
    }
  }

  void appendChunk(String content) {
    if (currentMessageElement != null) {
      chunkBuffer.write(content);

      final proseDiv =
          currentMessageElement?.querySelector('.prose') as DivElement?;
      proseDiv?.setInnerHtml(md.markdownToHtml(chunkBuffer.toString()),
          validator: NodeValidatorBuilder?.common()..allowHtml5());
      chatContainer.scrollTop = chatContainer.scrollHeight;
    }
  }

  void finalizeMessage(Usage? usage) {
    if (currentMessageElement != null) {
      // Update the content with the final message
      final proseDiv =
          currentMessageElement?.querySelector('.prose') as DivElement?;
      proseDiv?.setInnerHtml(md.markdownToHtml(chunkBuffer.toString()),
          validator: NodeValidatorBuilder?.common()..allowHtml5());

      if (usage != null) {
        final usageDiv = DivElement()
          ..className = 'text-sm text-gray-500 mt-2 pt-2 border-t'
          ..innerHtml = '''
          Prompt Tokens: ${usage.promptTokens ?? 0}, 
          Completion Tokens: ${usage.completionTokens ?? 0}, 
          Total Tokens: ${usage.totalTokens ?? 0},
          Response Time: ${usage.responseTime ?? 0}s
        ''';
        currentMessageElement?.children.add(usageDiv);
      }
      chatContainer.scrollTop = chatContainer.scrollHeight;
      if (currentMessageElement != null) {
        addCodeBlockButtons(currentMessageElement!);
      }
    }
    chunkBuffer = StringBuffer();
    currentMessageElement = null;
  }

  void sendMessage() {
    final content = chatInput.value?.trim();
    if (content != null && content.trim().isNotEmpty) {
      final message = Message(
        content: content,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        role: Role.user,
      );

      webSocketManager.sendMessage(message);
      addMessageToChat(message);
      chatInput.value = '';
      adjustTextareaHeight();
    }
  }

  Future<void> createNewSession() async {
    try {
      final response = await dio.post(
        '$baseUrl/new-session',
      );
      final session = ChatSession.fromJson(response.data);
      displayChat(session);
      await fetchSessions();
    } catch (error) {
      print('Error creating new session: $error');
    }
  }

  Future<void> removeAllSessions() async {
    try {
      final response = await dio.put(
        '$baseUrl/remove-all-sessions',
      );
      if (response.statusCode == 200) {
        sessionList.children.clear();
        chatContainer.children.clear();
        await createNewSession();
      }
    } catch (error) {
      print('Error removing all sessions: $error');
    }
  }

  void updateConnectionStatus() {
    if (WebSocketManager.isWebSocketConnected) {
      connectionStatus.text = 'Connected';
      connectionStatus.classes.add('bg-green-500');
      connectionStatus.classes.remove('bg-red-500');
    } else {
      connectionStatus.text = 'Disconnected';
      connectionStatus.classes.add('bg-red-500');
      connectionStatus.classes.remove('bg-green-500');
    }
  }

  void adjustTextareaHeight() {
    chatInput.style.height = 'auto';
    chatInput.style.height = '${min(chatInput.scrollHeight, 200)}px';
  }

  void addCodeBlockButtons(DivElement div) {
    final codeBlocks = div.querySelectorAll('pre code');
    for (var block in codeBlocks) {
      final buttonsDiv = DivElement()
        ..className = 'absolute top-2 right-2 flex gap-1';

      final copyButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded'
        ..text = 'Copy'
        ..onClick.listen((_) {
          window.navigator.clipboard.writeText(block.text ?? '');
        });

      final postButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded'
        ..text = 'POST'
        ..onClick.listen((_) async {
          try {
            final response = await dio.post(
              '$baseUrl/post-code',
              data: jsonEncode({'code': block.text}),
            );
            if (response.statusCode == 200) {
              final result = jsonDecode(response.data);
              print('POST response: $result');
            }
          } catch (error) {
            print('Error making POST request: $error');
          }
        });

      buttonsDiv.children.addAll([copyButton, postButton]);
      (block.parent as Element).children.add(buttonsDiv.jsify());
    }
  }

  void handleWebSocketMessage(Map<String, dynamic> data) {
    final msgChunk = MessageChunk.fromJson(data);
    switch (msgChunk.type) {
      case ChunkType.start:
        startNewMessage();
        isFirstChunk = true;
        break;
      case ChunkType.chunk:
        appendChunk(msgChunk.content ?? '');
        if (isFirstChunk) {
          isFirstChunk = false;
          // Remove the loading indicator
          final loadingDiv =
              currentMessageElement?.querySelector('.flex.items-center');
          if (loadingDiv != null) {
            loadingDiv.remove();
          }
        }

        break;
      case ChunkType.end:
        finalizeMessage(msgChunk.usage);
        if (!isFirstResponse) {
          isFirstResponse = true;
          fetchSessions();
        }
        break;
      default:
        print('Unknown message type: ${data['type']}');
    }
  }
}

void main() {
  ChatApp();
}
