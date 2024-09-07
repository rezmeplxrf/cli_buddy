
// import 'package:dio/dio.dart';
// import 'package:frontend/scr/service/chat.dart';
// import 'package:frontend/scr/service/config.dart';

// import 'package:frontend/scr/service/session.dart';



// final configService = ConfigService();

// final chatService = ChatService();

// class SharedStates {
//   static final _instance = SharedStates._internal();
//   factory SharedStates() => _instance;
//   SharedStates._internal();
//   final chatContainer = document.querySelector('#chatContainer') as DivElement;
//   final chatInput = document.querySelector('#chatInput') as TextAreaElement;
//   final newChatBtn = document.querySelector('#newChatBtn') as ButtonElement;
//   final removeAllSessionsBtn =
//       document.querySelector('#removeAllSessionsBtn') as ButtonElement;
//   final sendButton = document.querySelector('#sendButton') as ButtonElement;
//   final connectionStatus =
//       document.querySelector('#connectionStatus') as DivElement;
//   final configBtn = document.querySelector('#configBtn') as ButtonElement;
//   final sessionList = document.querySelector('#sessionList') as UListElement;
//   ChatSession? currentSession;
//   List<ChatSession> sessions = [];
//   Message? lastMessage;
//   var isFirstResponse = false;
//   DivElement? currentMessageElement;
//   var chunkBuffer = StringBuffer();
//   var isFirstChunk = true;
//   var isDone = true;
// }

// void init() {
//   final List<StreamSubscription> subscriptions = [];

//   subscriptions.addAll([
//     sharedStates.newChatBtn.onClick.listen((event) {
//       event.stopPropagation();
//       sessionService.createNewSession();
//     }),
//     sharedStates.removeAllSessionsBtn.onClick.listen((event) {
//       event.stopPropagation();
//       sessionService.removeAllSessions();
//     }),
//     sharedStates.chatInput.onInput.listen((event) {
//       event.stopPropagation();
//       chatService.adjustTextareaHeight();
//     }),
//     sharedStates.sendButton.onClick.listen((event) {
//       event.stopPropagation();
//       chatService.sendMessage();
//     }),
//     sharedStates.configBtn.onClick.listen((event) {
//       event.stopPropagation();
//       configService.showConfigPopup();
//     }),
//     sharedStates.chatInput.onKeyDown.listen((event) {
//       if (event.keyCode == KeyCode.ENTER && !event.shiftKey) {
//         event.preventDefault();
//         if (sharedStates.isDone) {
//           chatService.sendMessage();
//         }
//       }
//     })
//   ]);
//   window.onBeforeUnload.listen((event) {
//     sessionService.sessionsSubscriptions.clear();
//     sessionService.dropDownSubscriptions.clear();
//     websocketService.subscriptions.clear();
//     websocketService.socket?.close();
//     websocketService.socket = null;
//     configService.subscriptions.clear();
//     chatService.subscriptons.clear();
//     subscriptions.clear();
//   });

//   websocketService.connectWebSocket();
//   sessionService.fetchSessions();
//   sessionService.createNewSession();
// }

class Helper {
  static String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }


}
