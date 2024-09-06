import 'package:buddy_gui/domain/session.dart';
import 'package:buddy_gui/service/chat.dart';
import 'package:buddy_gui/service/config.dart';
import 'package:buddy_gui/service/session.dart';
import 'package:buddy_gui/service/websocket.dart';
import 'package:dio/dio.dart';
import 'dart:html';

const String baseUrl = 'http://127.0.0.1:43210';
const String wsUrl = 'ws://127.0.0.1:43210/ws';
final dio = Dio();
final sharedStates = SharedStates();
final sessionService = SessionService();
final configService = ConfigService();
final websocketService = WebSocketService();
final chatService = ChatService();

class SharedStates {
  static final _instance = SharedStates._internal();
  factory SharedStates() => _instance;
  SharedStates._internal();
  final chatContainer = document.querySelector('#chatContainer') as DivElement;
  final chatInput = document.querySelector('#chatInput') as TextAreaElement;
  final newChatBtn = document.querySelector('#newChatBtn') as ButtonElement;
  final removeAllSessionsBtn =
      document.querySelector('#removeAllSessionsBtn') as ButtonElement;
  final sendButton = document.querySelector('#sendButton') as ButtonElement;
  final connectionStatus =
      document.querySelector('#connectionStatus') as DivElement;
  final configBtn = document.querySelector('#configBtn') as ButtonElement;
  final sessionList = document.querySelector('#sessionList') as UListElement;
  ChatSession? currentSession;
  List<ChatSession> sessions = [];
  Message? lastMessage;
  var isFirstResponse = false;
  DivElement? currentMessageElement;
  var chunkBuffer = StringBuffer();
  var isFirstChunk = true;
  var isDone = true;
}

void init() {
  sharedStates.newChatBtn.onClick
      .listen((_) => sessionService.createNewSession());
  sharedStates.removeAllSessionsBtn.onClick
      .listen((_) => sessionService.removeAllSessions());
  sharedStates.chatInput.onInput
      .listen((_) => chatService.adjustTextareaHeight());
  sharedStates.sendButton.onClick.listen((_) => chatService.sendMessage());
  sharedStates.configBtn.onClick.listen((_) => configService.showConfigPopup());
  sharedStates.chatInput.onKeyDown.listen((event) {
    if (event.keyCode == KeyCode.ENTER && !event.shiftKey) {
      event.preventDefault();
      if (sharedStates.isDone) {
        chatService.sendMessage();
      }
    }
  });

  websocketService.connectWebSocket();
  sessionService.fetchSessions();
  sessionService.createNewSession();
}

class Helper {
  static String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

  static Element createSvgIcon(String svgString) {
    final svgElement =
        Element.html(svgString, treeSanitizer: NodeTreeSanitizer.trusted);
    return svgElement;
  }
}
