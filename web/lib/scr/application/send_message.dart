import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/application/session.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/data/websocket.dart';
import 'package:buddy_chat/scr/domain/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_message.g.dart';

class SendMessageService {
  SendMessageService(this.ref);
  final SendMessageServiceRef ref;

  Future<void> retry({
    required ChatSession currentSession,
    required Message messageToRemove,
  }) async {
    // Find the index of the messageToRemove

    final messageIndex = currentSession.messages.indexOf(messageToRemove);

    // If the message is found, create a new list of messages up to the messageToRemove index
    if (messageIndex != -1) {
      final newMessages = currentSession.messages.sublist(0, messageIndex);

      final overriddenModel =
          await ref.read(selectedOverridingModelProvider.future);
      // update only the last message from 'newMessages' with overideModel: overideModel
      if (newMessages.isNotEmpty) {
        final updatedLastMessage =
            newMessages.last.copyWith(overriddenModelId: overriddenModel?.id);

        // Replace the last message in newMessages with the updated message
        newMessages[newMessages.length - 1] = updatedLastMessage;
      }

      // Create a new session with the updated list of messages
      final newSession = currentSession.copyWith(messages: newMessages);

      ref
          .read(currentSessionControllerProvider.notifier)
          .setSession(newSession);
      ref.read(isAIRespondingProvider.notifier).set(true);

      await ref
          .read(webSocketRespositoryProvider.notifier)
          .sendMessage(newSession);
      // ref.invalidate(openrouterSendMessageProvider);
      // final newMessage = await ref
      //     .read(openrouterSendMessageProvider(session: newSession).future);

      // if (newMessage != null) {
      //   final updatedSession = ref
      //       .read(currentSessionControllerProvider.notifier)
      //       .updateMessage(newMessage);
      //   await ref
      //       .read(sessionListControllerProvider.notifier)
      //       .updateSession(updatedSession!);
      // }
    }
  }

  Future<void> sendEditedMessage(
      {required ChatSession currentSession,
      required Message messageToEdit,
      required String editedContent}) async {
    final currentMessageIndex = currentSession.messages
        .indexWhere((e) => e.timestamp == messageToEdit.timestamp);

    ref
        .read(currentSessionControllerProvider.notifier)
        .removeMessagesAfterIndex(currentMessageIndex + 1);

    final overriddenModel =
        await ref.read(selectedOverridingModelProvider.future);
    final updatedMessage = messageToEdit.copyWith(
        content: editedContent,
        validation: null,
        overriddenModelId: overriddenModel?.id);
    final sessionAfterEditedMessage = ref
        .read(currentSessionControllerProvider.notifier)
        .updateMessage(updatedMessage);

    if (sessionAfterEditedMessage != null) {
      if (messageToEdit.role == Role.user) {
        ref.read(isAIRespondingProvider.notifier).set(true);

        await ref
            .read(webSocketRespositoryProvider.notifier)
            .sendMessage(sessionAfterEditedMessage);
        // final response = await ref.read(
        //     openrouterSendMessageProvider(session: sessionAfterEditedMessage)
        //         .future);
        // if (response != null) {
        //   ref.read(isAIRespondingProvider.notifier).set(false);
        //   final updatedSession = ref
        //       .read(currentSessionControllerProvider.notifier)
        //       .updateMessage(response);

        //   await ref
        //       .read(sessionListControllerProvider.notifier)
        //       .updateSession(updatedSession!);
        // }
      } else {
        await ref
            .read(sessionListControllerProvider.notifier)
            .updateSession(sessionAfterEditedMessage);
      }
    }
  }

  Future<void> sendMessage({required String text}) async {
    try {
      final overriddenModel =
          await ref.read(selectedOverridingModelProvider.future);
      final userMessage = Message(
          role: Role.user,
          content: text,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          overriddenModelId: overriddenModel?.id);
      final sessionAfterUserMessage = ref
          .read(currentSessionControllerProvider.notifier)
          .updateMessage(userMessage);

      if (sessionAfterUserMessage != null) {
        ref.read(isAIRespondingProvider.notifier).set(true);

        await ref
            .read(webSocketRespositoryProvider.notifier)
            .sendMessage(sessionAfterUserMessage);
        // final response = await ref.read(
        //     openrouterSendMessageProvider(session: sessionAfterUserMessage)
        //         .future);

        // if (response != null) {
        //   ref.read(isAIRespondingProvider.notifier).set(false);
        //   final updatedSession = ref
        //       .read(currentSessionControllerProvider.notifier)
        //       .updateMessage(response);

        //   await ref
        //       .read(sessionListControllerProvider.notifier)
        //       .updateSession(updatedSession!);
        // }
      }
    } catch (e) {
      Global.talker.warning(e.toString());
    }
  }
}

@riverpod
SendMessageService sendMessageService(SendMessageServiceRef ref) {
  return SendMessageService(ref);
}
