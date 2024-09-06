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

  void displayChat(ChatSession session) {
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
          'message ${message.role.name}-message bg-white rounded-lg shadow-md p-4 mb-4 fade-in';

    final timestamp = DateTime.fromMillisecondsSinceEpoch(message.timestamp)
        .toLocal()
        .toString();

    div.setInnerHtml('''
    <div class="font-bold text-blue-600 mb-1">${Helper.capitalizeFirstLetter(message.role.name)}</div>
    <div class="text-sm text-gray-500 mb-2">$timestamp</div>
    <div class="prose">${md.markdownToHtml(message.content)}</div>''',
        treeSanitizer: NodeTreeSanitizer.trusted);
    sharedStates.chatContainer
      ..children.add(div)
      ..scrollTop = sharedStates.chatContainer.scrollHeight;
    addCodeBlockButtons(div);
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

    sharedStates.chunkBuffer = StringBuffer();
    sharedStates.currentMessageElement = null;
    sharedStates.lastMessage = null;
    sharedStates.isDone = true;
    updateSendButtonState();
    sessionService.updateLocalSessions(sharedStates.currentSession!.id);
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
        ..append(Helper.createSvgIcon(Svc.copyIcon))
        ..onClick.listen((_) {
          window.navigator.clipboard?.writeText(block.text ?? '');
          showSnackBar('Copied to clipboard');
        });

      final fileButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.fileIcon))
        ..onClick.listen((_) async {
          try {
            final response = await HttpRequest.postFormData(
              '$baseUrl/make-file',
              {'code': block.text ?? ''},
            );
            if (response.status == 200) {
              final result = jsonDecode(response.responseText ?? '');
              print('make-file: $result');

              showSnackBar('$result');
            }
          } catch (e) {
            print('Error: $e');
            window.alert('Error making request: $e');
          }
        });

      final runButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.runIcon))
        ..onClick.listen((_) async {
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
        });

      buttonsDiv.children.addAll([copyButton, fileButton, runButton]);
      (block.parent as Element).children.add(buttonsDiv);
    }
  }

  void showSnackBar(String message) {
    final snackbar = DivElement()
      ..text = message
      ..className = 'snackbar';

    document.body?.append(snackbar);

    // Add the "show" class to display the snackbar
    Future.delayed(Duration(milliseconds: 100), () {
      snackbar.className = 'snackbar show';
    });

    // Remove the snackbar after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
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
      default:
        print('Unknown message type: ${data['type']}');
    }
  }
}
