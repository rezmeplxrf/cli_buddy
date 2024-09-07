import 'package:frontend/scr/model/session.dart';
import 'package:frontend/scr/service/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session.g.dart';

@riverpod
class CurrentSessionController extends _$CurrentSessionController {
  @override
  FutureOr<ChatSession?> build() async {
    if (state.value == null) {
      try {
        final session = await newSession();
        return session;
      } catch (e) {
        rethrow;
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

    final config = await ref.read(configControllerProvider.future);
    if (config?.chatPrompt == null ||
        config?.defaultModel == null ||
        config?.secretEnvPath == null) {
      throw Exception('Required config is not found');
    }
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final newSession = ChatSession(
        id: currentTime,
        model: config!.defaultModel,
        messages: [
          Message(
              role: Role.system,
              content: config.chatPrompt!,
              timestamp: currentTime)
        ]);

    return newSession;
  }
}
