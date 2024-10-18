import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/data/local_endpoints.dart';
import 'package:buddy_chat/scr/domain/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.g.dart';

@riverpod
class ConfigService extends _$ConfigService {
  @override
  FutureOr<Configuration?> build() async {
    try {
      final config = await getConfig();
      return config;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return state.value;
    }
  }

  Future<Configuration> getConfig() async {
    state = const AsyncLoading();
    final config = await ref.read(getConfigProvider.future);
    return config;
  }

  Future<void> setConfig(Configuration config) async {
    if (state.value != null && state.value == config) {
      return;
    }

    try {
      await ref.read(setConfigProvider(newConfig: config).future);
      state = AsyncData(config);
    } catch (e) {
      Global.talker.error(e.toString());
    }
  }
}

@riverpod
class SysPromptService extends _$SysPromptService {
  @override
  FutureOr<List<SysPrompt>> build() async {
    try {
      final prompts = await getPrompts();
      return prompts;
    } catch (e) {
      Global.talker.error(e.toString());

      return [];
    }
  }

  FutureOr<List<SysPrompt>> getPrompts() async {
    state = const AsyncLoading();
    final prompts = await ref.read(getSysPromptsProvider.future);
    return prompts;
  }

  Future<void> setPrompts(List<SysPrompt> prompts) async {
    try {
      await ref.read(setSysPromptsProvider(sysPrompts: prompts).future);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      state = AsyncData(prompts);
    }
  }
}
