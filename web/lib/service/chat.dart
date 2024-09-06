import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'dart:math';
import 'package:buddy_gui/assets.dart';
import 'package:buddy_gui/domain/domain.dart';
import 'package:buddy_gui/service/global.dart';
import 'package:markdown/markdown.dart' as md;

class ChatService {
  static final _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();
  final List<StreamSubscription?> subscriptons = [];

  void displayChat(ChatSession session) {
    subscriptons.clear();
    sharedStates.chatContainer.children.clear();

    for (final message in session.messages) {
      addMessageToChat(message);
    }
  }

  void updateSendButtonState() {
    if (sharedStates.isDone) {
      sharedStates.sendButton.removeAttribute('disabled');
      sharedStates.sendButton.classes
          .removeAll(['opacity-50', 'cursor-not-allowed']);
    } else {
      sharedStates.sendButton.setAttribute('disabled', 'true');
      sharedStates.sendButton.classes
          .addAll(['opacity-50', 'cursor-not-allowed']);
    }
  }

  void addMessageToChat(Message message) {
    final div = DivElement()
      ..className =
          'message ${message.role.name}-message bg-white rounded-lg shadow-md p-4 mb-4 fade-in, relative';

    final timestamp = DateTime.fromMillisecondsSinceEpoch(message.timestamp)
        .toLocal()
        .toString();

    div.setInnerHtml('''
    <div class="font-bold text-blue-600 mb-1">${Helper.capitalizeFirstLetter(message.role.name)}</div>
    <button class="edit-button absolute top-2 right-2 bg-gray-500 hover:bg-gray-600 text-white font-bold py-1 px-2 rounded">Edit</button>
    <div class="text-sm text-gray-500 mb-2">$timestamp</div>
    <div class="prose">${md.markdownToHtml(message.content)}</div>''',
        treeSanitizer: NodeTreeSanitizer.trusted);
    sharedStates.chatContainer
      ..children.add(div)
      ..scrollTop = sharedStates.chatContainer.scrollHeight;
    addCodeBlockButtons(div);
    subscriptons.add(div.querySelector('.edit-button')?.onClick.listen((_) {
      enableEditMode(div, message);
    }));
  }

  void startNewMessage() {
    sharedStates.currentMessageElement = DivElement()
      ..className =
          'message assistant-message bg-white rounded-lg shadow-md p-4 mb-4'
      ..setInnerHtml('''
        <div class="font-bold text-blue-600 mb-1">Assistant</div>
        <div class="text-sm text-gray-500 mb-2">${DateTime.now().toLocal()}</div>
        <div class="flex items-center">
            <div class="loading-indicator mr-2"></div>
            <div>Thinking...</div>
        </div>
        <div class="prose"></div>
      ''', treeSanitizer: NodeTreeSanitizer.trusted);
    if (sharedStates.currentMessageElement != null) {
      sharedStates.chatContainer.children
          .add(sharedStates.currentMessageElement!);
      sharedStates.chatContainer.scrollTop =
          sharedStates.chatContainer.scrollHeight;
    }
  }

  void appendChunk(String content) {
    if (sharedStates.currentMessageElement != null) {
      sharedStates.chunkBuffer.write(content);

      final proseDiv = sharedStates.currentMessageElement
          ?.querySelector('.prose') as DivElement?;
      proseDiv?.setInnerHtml(
          md.markdownToHtml(sharedStates.chunkBuffer.toString()),
          validator: NodeValidatorBuilder?.common()..allowHtml5());
      sharedStates.chatContainer.scrollTop =
          sharedStates.chatContainer.scrollHeight;
    }
  }

  void finalizeMessage(Usage? usage) {
    if (sharedStates.currentMessageElement != null) {
      // Update the content with the final message
      final proseDiv = sharedStates.currentMessageElement
          ?.querySelector('.prose') as DivElement?;
      proseDiv?.setInnerHtml(
          md.markdownToHtml(sharedStates.chunkBuffer.toString()),
          validator: NodeValidatorBuilder?.common()..allowHtml5());

      if (usage != null) {
        final usageDiv = DivElement()
          ..className = 'text-sm text-gray-500 mt-2 pt-2 border-t'
          ..setInnerHtml('''
          Prompt Tokens: ${usage.promptTokens ?? 0}, 
          Completion Tokens: ${usage.completionTokens ?? 0}, 
          Total Tokens: ${usage.totalTokens ?? 0},
          Response Time: ${usage.responseTime ?? 0}s
        ''', treeSanitizer: NodeTreeSanitizer.trusted);
        sharedStates.currentMessageElement?.children.add(usageDiv);
      }
      sharedStates.chatContainer.scrollTop =
          sharedStates.chatContainer.scrollHeight;
      if (sharedStates.currentMessageElement != null) {
        addCodeBlockButtons(sharedStates.currentMessageElement!);
      }
    }
    sharedStates.lastMessage = sharedStates.lastMessage!
        .copyWith(content: sharedStates.chunkBuffer.toString(), usage: usage);

    sharedStates.currentSession =
        sharedStates.currentSession?.copyWith(messages: [
      ...sharedStates.currentSession!.messages,
      sharedStates.lastMessage!,
    ]);

    _clearUp();
    sessionService.updateLocalSessions(sharedStates.currentSession!.id);
  }

  void _clearUp() {
    sharedStates.chunkBuffer = StringBuffer();
    sharedStates.currentMessageElement = null;
    sharedStates.lastMessage = null;
    sharedStates.isDone = true;
    updateSendButtonState();
  }

  void sendMessage() {
    final content = sharedStates.chatInput.value?.trim();
    if (content != null && content.trim().isNotEmpty) {
      final message = Message(
        content: content,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        role: Role.user,
      );

      websocketService.sendMessage(message);
      addMessageToChat(message);
      sharedStates.chatInput.value = '';
      adjustTextareaHeight();
      sharedStates.isDone = false;
      updateSendButtonState();
    }
  }

  void adjustTextareaHeight() {
    sharedStates.chatInput.style.height = 'auto';
    sharedStates.chatInput.style.height =
        '${min(sharedStates.chatInput.scrollHeight, 200)}px';
  }

  void addCodeBlockButtons(DivElement div) {
    final codeBlocks = div.querySelectorAll('pre code');
    for (var block in codeBlocks) {
      final buttonsDiv = DivElement()
        ..className = 'absolute top-2 right-2 flex gap-1';

      final copyButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.copyIcon));

      subscriptons.add(copyButton.onClick.listen((_) {
        window.navigator.clipboard?.writeText(block.text ?? '');
        showSnackBar('Copied to clipboard');
      }));

      final fileButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.fileIcon));

      subscriptons.add(fileButton.onClick.listen((_) async {
        try {
          if (block.text == null || block.text!.trim().isEmpty) {
            showSnackBar('Content is empty');
            return;
          }

          final path = await showPathInputDialog();
          if (path == null) return;
          final response = await HttpRequest.postFormData(
            '$baseUrl/make-file',
            {'code': block.text!, 'path': path},
          );
          if (response.status == 200) {
            final result = jsonDecode(response.responseText ?? '');
            print('$result');

            showSnackBar('$result');
          }
        } catch (e) {
          print('Error: $e');
          window.alert('Error making request: $e');
        }
      }));

      final runButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.runIcon));

      subscriptons.add(runButton.onClick.listen((_) async {
        try {
          final response = await HttpRequest.postFormData(
            '$baseUrl/run-code',
            {'code': block.text ?? ''},
          );
          if (response.status == 200) {
            final result = jsonDecode(response.responseText ?? '');
            print('run: $result');

            showSnackBar('$result');
          }
        } catch (e) {
          print('Error: $e');
          window.alert('Error: $e');
        }
      }));

      buttonsDiv.children.addAll([copyButton, fileButton, runButton]);
      (block.parent as Element).children.add(buttonsDiv);
    }
  }
// TODO: Add hint which should be current path where buddy open is called. We will pass the current path to the browser.

  Future<String?> showPathInputDialog() {
    final completer = Completer<String?>();

    final modal = DivElement()
      ..className =
          'fixed inset-0 flex items-center justify-center bg-gray-800 bg-opacity-50';

    final dialog = DivElement()
      ..className = 'bg-white p-4 rounded shadow-lg max-w-md w-full';

    final input = InputElement(type: 'text')
      ..className = 'w-full p-2 border border-gray-300 rounded'
      ..placeholder = 'Enter file path';

    final buttonContainer = DivElement()
      ..className = 'flex justify-end gap-2 mt-4';

    final cancelButton = ButtonElement()
      ..className = 'bg-gray-500 text-white py-1 px-4 rounded'
      ..text = 'Cancel'
      ..onClick.listen((_) {
        modal.remove();
        completer.complete(null);
      });

    final okButton = ButtonElement()
      ..className = 'bg-blue-500 text-white py-1 px-4 rounded'
      ..text = 'OK'
      ..onClick.listen((_) {
        final path = input.value;
        modal.remove();
        completer.complete(path);
      });

    buttonContainer.children.addAll([cancelButton, okButton]);
    dialog.children.addAll([input, buttonContainer]);
    modal.children.add(dialog);
    document.body?.append(modal);

    return completer.future;
  }

  void showSnackBar(String message) {
    final snackbar = DivElement()
      ..text = message
      ..className = 'snackbar';

    document.body?.append(snackbar);

    Future.delayed(Duration(milliseconds: 100), () {
      snackbar.className = 'snackbar show';
    });

    Future.delayed(Duration(seconds: 4), () {
      snackbar.remove();
    });
  }

  void handleWebSocketMessage(Map<String, dynamic> data) {
    final msgChunk = MessageChunk.fromJson(data);
    switch (msgChunk.type) {
      case ChunkType.start:
        sharedStates.lastMessage = Message(
            role: Role.assistant,
            content: '',
            timestamp: DateTime.now().millisecondsSinceEpoch);
        startNewMessage();
        sharedStates.isFirstChunk = true;
        break;
      case ChunkType.chunk:
        appendChunk(msgChunk.content ?? '');
        if (sharedStates.isFirstChunk) {
          sharedStates.isFirstChunk = false;
          // Remove the loading indicator
          final loadingDiv = sharedStates.currentMessageElement
              ?.querySelector('.flex.items-center');
          if (loadingDiv != null) {
            loadingDiv.remove();
          }
        }

        break;

      case ChunkType.end:
        finalizeMessage(msgChunk.usage);
        if (!sharedStates.isFirstResponse) {
          sharedStates.isFirstResponse = true;
          sessionService.fetchSessions();
        }
        break;
      case ChunkType.error:
        showSnackBar('${msgChunk.content}');
        _clearUp();
        break;
    }
  }

  void enableEditMode(DivElement messageElement, Message message) {
    sharedStates.currentMessageElement = messageElement;
    final messageContent = messageElement.querySelector('.prose') as DivElement;
    messageContent.contentEditable = 'true';
    messageContent.focus();

    final saveButton = ButtonElement()
      ..className =
          'save-button bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded'
      ..text = 'Save';

    subscriptons
        .add(saveButton.onClick.listen((_) => saveEditedMessage(message)));

    final cancelButton = ButtonElement()
      ..className =
          'cancel-button bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded'
      ..text = 'Cancel';

    subscriptons.add(cancelButton.onClick.listen((_) => cancelEditMode()));

    final buttonContainer = DivElement()
      ..className = 'edit-buttons flex justify-center mt-2'
      ..append(saveButton)
      ..append(cancelButton);

    messageElement.append(buttonContainer);
  }

  void saveEditedMessage(Message originalMessage) {
    final messageElement = sharedStates.currentMessageElement;
    if (messageElement == null) return;

    final messageContent = messageElement.querySelector('.prose') as DivElement;
    final newContent = messageContent.text;
    if (newContent == null ||
        newContent.isEmpty ||
        newContent == originalMessage.content) return;

    final updatedMessage = originalMessage.copyWith(content: newContent);

    // Find the index of the original message
    final messageIndex =
        sharedStates.currentSession?.messages.indexOf(originalMessage) ?? -1;
    if (messageIndex == -1) return;

    // Update the session with the edited message and remove more recent messages
    final updatedMessages = sharedStates.currentSession!.messages
        .sublist(0, messageIndex + 1)
      ..[messageIndex] = updatedMessage;

    final updatedSession =
        sharedStates.currentSession?.copyWith(messages: updatedMessages);
    if (updatedSession != null) {
      sharedStates.currentSession = updatedSession;
      sharedStates.sessions = sharedStates.sessions.map((session) {
        return session.id == updatedSession.id ? updatedSession : session;
      }).toList();

      print(sharedStates.currentSession);
      // Re-render message
      displayChat(sharedStates.currentSession!);
      cancelEditMode();
      websocketService.sendEditedSession(sharedStates.currentSession!);
    } else {
      showSnackBar('Something went wrong. Please try again.');
    }
  }

  void cancelEditMode() {
    final messageElement = sharedStates.currentMessageElement;
    if (messageElement == null) return;

    final messageContent = messageElement.querySelector('.prose') as DivElement;
    messageContent.contentEditable = 'false';

    final buttonContainer = messageElement.querySelector('.edit-buttons');
    buttonContainer?.remove();

    sharedStates.currentMessageElement = null;
  }
}
