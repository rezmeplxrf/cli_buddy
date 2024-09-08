import 'package:frontend/scr/model/domain.dart';
import 'package:frontend/scr/repository/endpoints.dart';
import 'package:frontend/scr/service/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

@riverpod
class SessionService extends _$SessionService {
  @override
  FutureOr<List<ChatSession>> build() async {
    if (state.value == null || state.value!.isEmpty) {
      try {
        final sessions = await getSessions();
        return sessions;
      } catch (e) {
        state = AsyncError(e, StackTrace.current);
        return [];
      }
    } else {
      return state.value!;
    }
  }

  Future<List<ChatSession>> getSessions() async {
    state = const AsyncLoading();
    final sessions = await ref.read(listSessionProvider.future);
    return sessions;
  }

  Future<void> removeSession(ChatSession session) async {
    state = const AsyncLoading();
    try {
      await ref.read(removeSessionProvider(id: session.id).future);
      final currentSession =
          await ref.read(currentSessionControllerProvider.future);
      if (currentSession?.id == session.id) {
        ref.read(currentSessionControllerProvider.notifier).setSession(null);
      }
      final newSessions =
          state.value!.where((s) => s.id != session.id).toList();
      state = AsyncData(newSessions);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> removeAllSessions() async {
    state = const AsyncLoading();
    try {
      await ref.read(removeAllSessionsProvider.future);
      ref.read(currentSessionControllerProvider.notifier).setSession(null);
      state = const AsyncData([]);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
class CurrentSessionController extends _$CurrentSessionController {
  @override
  FutureOr<ChatSession?> build() async {
    if (state.value == null) {
      try {
        final session = await newSession();
        return session;
      } catch (e) {
        state = AsyncError(e, StackTrace.current);
        return null;
      }
    } else {
      return state.value;
    }
  }

  void setSession(ChatSession? session) {
    state = const AsyncLoading();
    state = AsyncData(session);
  }

  Future<ChatSession> newSession() async {
    state = const AsyncLoading();

    final config = await ref.read(configServiceProvider.future);
    if (config?.chatPrompt == null ||
        config?.defaultModel == null ||
        config?.secretEnvPath == null) {
      throw Exception('Required config is not found');
    }
    SysPrompt? sysPrompt;
    final selectedSysPrompt = ref.read(selectedSysPromptProvider);
    if (selectedSysPrompt == null) {
      final config = await ref.read(configServiceProvider.future);
      sysPrompt = SysPrompt(name: 'Default', prompt: config!.chatPrompt!);
    } else {
      sysPrompt = selectedSysPrompt;
    }
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final newSession = ChatSession(
        id: currentTime,
        model: config!.defaultModel,
        messages: [
          Message(
              role: Role.system,
              content: sysPrompt.prompt,
              timestamp: currentTime)
        ]);

    return newSession;
  }
}
