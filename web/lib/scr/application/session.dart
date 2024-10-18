import 'dart:async';

import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/data/local_endpoints.dart';
import 'package:buddy_chat/scr/data/open_router.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

@riverpod
class SessionListController extends _$SessionListController {
  @override
  FutureOr<List<ChatSession>> build() async {
    try {
      final sessions = await getSessions();
      return sessions;
    } catch (e) {
      Global.talker.error(e.toString());
      return [];
    }
  }

  Future<List<ChatSession>> getSessions() async {
    state = const AsyncLoading();
    final sessions = await ref.read(listSessionProvider.future);
    if (sessions.isEmpty) {
      return sessions;
    }
    // list the sessions ordered by id where id is largest first
    sessions.sort((a, b) => b.id.compareTo(a.id));
    return sessions;
  }

  Future<void> updateSession(ChatSession newSession) async {
    state = const AsyncLoading();
    try {
      var currentSessions = <ChatSession>[];
      currentSessions = state.value ?? [];
      final sessionIndex = currentSessions.indexWhere((session) =>
          session.id == newSession.id && session.modelId == newSession.modelId);

      if (sessionIndex != -1) {
        // Update existing session
        currentSessions[sessionIndex] = newSession;
      } else {
        // Add new session
        currentSessions.add(newSession);
      }
      currentSessions.sort((a, b) => b.id.compareTo(a.id));
      state = AsyncData(currentSessions);
      // await ref.read(saveSessionToLocalProvider(newSession: newSession).future);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> removeSession(ChatSession session) async {
    state = const AsyncLoading();
    try {
      final currentSession =
          await ref.read(currentSessionControllerProvider.future);
      if (currentSession?.id == session.id) {
        ref.read(currentSessionControllerProvider.notifier).setSession(null);
      }
      final newSessions =
          state.value!.where((s) => s.id != session.id).toList();

      state = AsyncData(newSessions);
      await ref.read(removeSessionProvider(id: session.id).future);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> removeAllSessions() async {
    state = const AsyncLoading();
    try {
      ref.invalidate(currentSessionControllerProvider);

      state = const AsyncData([]);
      await ref.read(removeAllSessionsProvider.future);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

@riverpod
class CurrentSessionController extends _$CurrentSessionController {
  @override
  FutureOr<ChatSession?> build() async {
    try {
      final session = await newSession();
      return session;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    }
  }

  void setSession(ChatSession? session) {
    state = const AsyncLoading();
    state = AsyncData(session);
  }

  ChatSession? updateMessage(Message newMessage, {bool isFinished = false}) {
    // Find the index of the message with the same timestamp
    final index = state.value!.messages.indexWhere((message) =>
        message.timestamp == newMessage.timestamp &&
        message.role == newMessage.role);

    if (index != -1) {
      // If the message exists, update its content and usage
      final updatedMessages = List<Message>.from(state.value!.messages);
      updatedMessages[index] = state.value!.messages[index].copyWith(
        content: newMessage.content,
        usage: newMessage.usage ?? state.value!.messages[index].usage,
        validation:
            newMessage.validation ?? state.value!.messages[index].validation,
      );
      state = AsyncData(state.value!.copyWith(messages: updatedMessages));
    } else {
      // If the message does not exist, add it to the list
      state = AsyncData(state.value!
          .copyWith(messages: [...state.value!.messages, newMessage]));
    }
    if (isFinished && state.value != null) {
      ref
          .read(sessionListControllerProvider.notifier)
          .updateSession(state.value!);
    }

    return state.value;
  }

  void removeMessagesAfterIndex(int index) {
    final updatedMessages = List<Message>.from(state.value!.messages)
      ..removeRange(index, state.value!.messages.length);
    state = AsyncData(state.value!.copyWith(messages: updatedMessages));
  }

  Future<ChatSession> newSession() async {
    state = const AsyncLoading();

    final config = await ref.read(configServiceProvider.future);
    final defaultModel = (config!.apiProvider == APIProvider.openrouter)
        ? config.openrouterDefaultModel
        : config.ollamaDefaultModel;

    SysPrompt? sysPrompt;
    final selectedSysPrompt = ref.read(selectedSysPromptProvider);
    if (selectedSysPrompt == null) {
      final config = await ref.read(configServiceProvider.future);
      sysPrompt = SysPrompt(name: 'Default', prompt: config!.chatPrompt!);
    } else {
      sysPrompt = selectedSysPrompt;
    }
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final selectedModelOverride =
        await ref.read(selectedOverridingModelProvider.future);
    if (defaultModel == null && selectedModelOverride == null) {
      throw Exception(
          '''Required config is not found - check apiProvider, and if selected apiprovider's default model is set''');
    }
    final newSession = ChatSession(
        id: currentTime,
        modelId:
            sysPrompt.modelId ?? selectedModelOverride?.id ?? defaultModel!,
        messages: [
          Message(
              role: Role.system,
              content: sysPrompt.prompt,
              timestamp: currentTime)
        ]);

    return newSession;
  }

  Future<void> requestValidation({required ValidateRequest request}) async {
    unawaited(EasyLoading.show(indicator: const DefaultLoadingWidget(30)));
    final result = await ref
        .read(openrouterRequestValidationProvider(request: request).future);
    // check if currentSession.id is the same as state.value'id
    if (result != null && request.currentSession.id == state.value?.id) {
      state = AsyncData(result);
      await ref
          .read(sessionListControllerProvider.notifier)
          .updateSession(result);

      if (EasyLoading.isShow) {
        unawaited(EasyLoading.dismiss());
      }
    }
  }
}
