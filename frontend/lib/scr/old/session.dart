// import 'dart:async';
// import 'dart:html';
// import 'dart:math';
// import 'package:buddy_gui/domain/domain.dart';
// import 'package:buddy_gui/service/global.dart';
// import 'package:collection/collection.dart';

// class SessionService {
//   static final _instance = SessionService._internal();
//   factory SessionService() => _instance;
//   SessionService._internal();
//   final sharedStates = SharedStates();
//   final List<StreamSubscription> sessionsSubscriptions = [];
//   final List<StreamSubscription> dropDownSubscriptions = [];

//   Future<void> fetchSessions() async {
//     try {
//       final response = await dio.get('$baseUrl/sessions');

//       final data = response.data as List<dynamic>;
//       final sessions = data.map((json) => ChatSession.fromJson(json)).toList();

//       if (sharedStates.sessions != sessions) {
//         populateSidebar(sessions);
//         sharedStates.sessions = sessions;
//       }
//     } catch (e) {
//       print('Error fetching sessions: $e');
//     }
//   }

//   void populateSidebar(List<ChatSession> sessions) {
//     sessionsSubscriptions.clear();

//     sessions.sort((a, b) => b.id - a.id);
//     final currentSessionIds = sessions.map((s) => s.id).toSet();
//     sharedStates.sessionList.children.removeWhere((element) {
//       final sessionId =
//           int.tryParse(element.getAttribute('data-session-id') ?? '');
//       return sessionId != null && !currentSessionIds.contains(sessionId);
//     });
//     for (var i = 0; i < sessions.length; i++) {
//       final session = sessions[i];
//       final existingElement = sharedStates.sessionList.children
//           .firstWhereOrNull((element) =>
//               element.getAttribute('data-session-id') == session.id.toString());

//       if (existingElement != null) {
//         updateSessionElement(existingElement as LIElement, session, i);
//       } else {
//         final newElement = createSessionElement(session, i);
//         if (i == 0) {
//           sharedStates.sessionList.children.insert(0, newElement);
//         } else {
//           final previousElement = sharedStates.sessionList.children
//               .firstWhereOrNull((element) =>
//                   int.parse(element.getAttribute('data-session-id') ?? '0') <
//                   session.id);
//           if (previousElement != null) {
//             sharedStates.sessionList.children.insert(
//                 sharedStates.sessionList.children.indexOf(previousElement),
//                 newElement);
//           } else {
//             sharedStates.sessionList.children.add(newElement);
//           }
//         }
//       }
//     }
//   }

//   void updateSessionElement(LIElement element, ChatSession session, int index) {
//     final firstUserMessage = session.messages.firstWhereOrNull(
//       (msg) => msg.role == Role.user,
//     );

//     final title = firstUserMessage != null
//         ? firstUserMessage.content
//             .substring(0, min(30, firstUserMessage.content.length))
//         : 'New Chat';

//     element
//       ..setInnerHtml('''
//     <div class="session-title font-semibold mb-1">$title${firstUserMessage != null && firstUserMessage.content.length > 30 ? '...' : ''}</div>
//     <div class="session-info text-xs text-gray-400"><div>ID: ${session.id}</div>
//     <div>Messages: ${session.messages.length}</div><div>Model: ${session.model}</div></div>
//     <span class="dot-icon hidden absolute top-2 right-2 cursor-pointer pr-2">•••</span>
//   ''', treeSanitizer: NodeTreeSanitizer.trusted)
//       ..style.animationDelay = '${index * 0.05}s';

//     final dotIcon = element.querySelector('.dot-icon');
//     if (dotIcon != null) {
//       sessionsSubscriptions.add(element.onMouseEnter.listen((event) {
//         event.stopPropagation();
//         dotIcon.classes.remove('hidden');
//       }));

//       sessionsSubscriptions.add(element.onMouseLeave.listen((event) {
//         event.stopPropagation();
//         dotIcon.classes.add('hidden');
//       }));

//       sessionsSubscriptions.add(dotIcon.onClick.listen((event) {
//         event.stopPropagation();
//         toggleDropdownMenu(dotIcon);
//       }));
//     }
//   }

//   void toggleDropdownMenu(Element dotIcon) {
//     closeAllDropdowns();
//     final id = dotIcon.parent?.getAttribute('data-session-id');
//     final dropdownId = 'dropdown-${id}';
//     var dropdown = document.getElementById(dropdownId);

//     if (dropdown == null) {
//       dropdown = DivElement()
//         ..id = dropdownId
//         ..className = 'fixed bg-white rounded-md shadow-lg z-50'
//         ..setInnerHtml('''
//           <ul>
//             <li class="px-4 py-2 hover:bg-gray-200 cursor-pointer">Locate</li>
//             <li class="px-4 py-2 hover:bg-gray-200 cursor-pointer">Delete</li>
//           </ul>
//         ''', treeSanitizer: NodeTreeSanitizer.trusted);
//       document.body?.append(dropdown);
//       final dropdownList = dropdown.querySelector('ul');
//       if (dropdownList != null) {
//         dropDownSubscriptions.add(dropdownList.onClick.listen((event) {
//           event.stopPropagation();

//           if (event.target is LIElement) {
//             final option = event.target as LIElement;
//             if (option.text == 'Locate') {
//               print('Locate');
//             } else if (option.text == 'Delete') {
//               removeSession(int.parse(id!));
//             }
//             closeAllDropdowns();
//           }
//         }));
//       }
//     }
//     final rect = dotIcon.getBoundingClientRect();
//     dropdown.style
//       ..left = '${rect.right}px'
//       ..top = '${rect.bottom}px'
//       ..display = dropdown.style.display == 'none' ? 'block' : 'none';

//     dropDownSubscriptions.add(window.onClick.listen((event) {
//       event.stopPropagation();
//       if (!dotIcon.contains(event.target as Node) &&
//           !dropdown!.contains(event.target as Node)) {
//         closeAllDropdowns();
//       }
//     }));
//   }

//   void closeAllDropdowns() {
//     document.querySelectorAll('[id^="dropdown-"]').forEach((dropdown) {
//       (dropdown).style.display = 'none';
//     });
//     dropDownSubscriptions.clear();
//     print('cleared');
//   }

//   LIElement createSessionElement(ChatSession session, int index) {
//     final li = LIElement()
//       ..className =
//           'session-item bg-gray-800 hover:bg-gray-700 rounded p-2 cursor-pointer transition-colors duration-200 fade-in relative'
//       ..setAttribute('data-session-id', session.id.toString());

//     updateSessionElement(li, session, index);
//     sessionsSubscriptions.add(li.onClick.listen((event) {
//       event.stopPropagation();
//       selectSession(session.id);
//     }));

//     return li;
//   }

//   Future<void> removeSession(int sessionId) async {
//     try {
//       final response = await dio.post(
//         '$baseUrl/remove-session',
//         data: {'sessionId': sessionId},
//       );
//       if (response.statusCode != 200) {
//         throw Exception(response.statusCode);
//       } else {
//         sharedStates.sessions.removeWhere((s) => s.id == sessionId);

//         populateSidebar(sharedStates.sessions);
//         await createNewSession();
//       }
//     } catch (e) {
//       print('Error removing session $sessionId: $e');
//       window.alert('Error removing session $sessionId: $e');
//     }
//   }

//   Future<void> selectSession(int sessionId) async {
//     try {
//       final response = await dio.post(
//         '$baseUrl/select-session',
//         data: {'sessionId': sessionId},
//       );
//       sharedStates.currentSession = ChatSession.fromJson(response.data);
//       updateLocalSessions(sessionId);

//       chatService.displayChat(sharedStates.currentSession!);

//       closeAllDropdowns();
//     } catch (e) {
//       print('Error selecting session: $e');
//     }
//   }

//   void updateLocalSessions(int sessionId) {
//     final sameSession = sharedStates.sessions
//         .firstWhereOrNull((s) => s.id == sharedStates.currentSession?.id);
//     final updatedSession = sameSession?.copyWith(
//         messages:
//             sharedStates.currentSession?.messages ?? sameSession.messages);
//     sharedStates.sessions = sameSession == null
//         ? sharedStates.sessions
//         : sharedStates.sessions
//             .map((s) => s.id == sessionId ? updatedSession! : s)
//             .toList();
//     populateSidebar(sharedStates.sessions);
//   }

//   Future<void> removeAllSessions() async {
//     final confirm =
//         window.confirm('Are you sure you want to remove all sessions?');
//     if (!confirm) return;
//     try {
//       final response = await dio.post(
//         '$baseUrl/remove-all',
//       );
//       if (response.statusCode == 200) {
//         sharedStates.sessionList.children.clear();
//         sharedStates.chatContainer.children.clear();
//         sharedStates.currentSession = null;
//         await createNewSession();
//       }
//     } catch (e) {
//       print('Error removing all sessions: $e');
//       window.alert('Error removing all sessions: $e');
//     }
//   }

//   Future<void> createNewSession() async {
//     try {
//       final response = await dio.post(
//         '$baseUrl/new-session',
//       );
//       sharedStates.currentSession = ChatSession.fromJson(response.data);
//       chatService.displayChat(sharedStates.currentSession!);
//       sharedStates.isFirstResponse = false;
//       fetchSessions();
//     } catch (error) {
//       print('Error creating new session: $error');
//     }
//   }
// }
