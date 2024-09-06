import 'package:buddy_gui/domain/session.dart';
import 'package:buddy_gui/service/global.dart';
import 'dart:async';
import 'dart:html';
import 'dart:convert';

class WebSocketService {
  static final _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();
  WebSocket? socket;
  bool isWebSocketConnected = false;
  List<Message> messageQueue = [];
  List<StreamSubscription?> subscriptions = [];

  void connectWebSocket() {
    if (isWebSocketConnected) {
      return;
    }
    if (socket != null) {
      print('closing existing socket');
      socket?.close();
      socket = null;
      subscriptions.clear();
    }

    socket = WebSocket(wsUrl);

    subscriptions.addAll([
      socket?.onOpen.listen((event) {
        event.stopPropagation();
        print('WebSocket connection established');
        isWebSocketConnected = true;
        updateConnectionStatus;
        processMessageQueue();
      }),
      socket?.onClose.listen((event) {
        event.stopPropagation();
        print('WebSocket connection closed');
        isWebSocketConnected = false;
        updateConnectionStatus;
        Future.delayed(Duration(seconds: 3), () => connectWebSocket());
      }),
      socket?.onError.listen((event) {
        event.stopPropagation();
        isWebSocketConnected = false;
        print('WebSocket error: $event');
        window.alert('WebSocket error. Please reload the page.');
      }),
      socket?.onMessage.listen((MessageEvent event) {
        try {
          final data = jsonDecode(event.data as String);
          chatService.handleWebSocketMessage(data);
        } catch (error) {
          print('Error parsing WebSocket message: $error');
        }
      })
    ]);
  }

  void processMessageQueue() {
    while (messageQueue.isNotEmpty && isWebSocketConnected) {
      final message = messageQueue.removeAt(0);
      sendMessage(message);
    }
  }

  void sendMessage(Message message) {
    print("user message: $message");
    if (isWebSocketConnected) {
      sharedStates.currentSession = sharedStates.currentSession?.copyWith(
        messages: [...sharedStates.currentSession!.messages, message],
      );

      socket?.send(jsonEncode(sharedStates.currentSession));
    } else {
      messageQueue.add(message);
    }
  }

  void sendEditedSession(ChatSession editedSession) {
    print("edited session: $editedSession");
    if (isWebSocketConnected) {
      // check if editedSession has id, model,
      if (editedSession.model == null) {
        print('Error: editedSession must have model and id.');
        return;
      }
      socket?.send(jsonEncode(editedSession));
    } else {
      print('Error: WebSocket is not connected.');
    }
  }

  void updateConnectionStatus() {
    if (isWebSocketConnected) {
      sharedStates.connectionStatus.text = 'Connected';
      sharedStates.connectionStatus.classes.add('bg-green-500');
      sharedStates.connectionStatus.classes.remove('bg-red-500');
    } else {
      sharedStates.connectionStatus.text = 'Disconnected';
      sharedStates.connectionStatus.classes.add('bg-red-500');
      sharedStates.connectionStatus.classes.remove('bg-green-500');
    }
  }
}
