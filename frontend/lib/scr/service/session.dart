import 'package:frontend/scr/controller/session.dart';
import 'package:frontend/scr/model/domain.dart';
import 'package:frontend/scr/repository/endpoints.dart';
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
        rethrow;
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

