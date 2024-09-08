import 'package:frontend/scr/model/config.dart';
import 'package:frontend/scr/repository/endpoints.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.g.dart';

@riverpod
class ConfigController extends _$ConfigController {
  @override
  FutureOr<Configuration?> build() async {
    if (state.value == null) {
      try {
        final config = await getConfig();
        return config;
      } catch (e) {
        rethrow;
      }
    } else {
      return state.value;
    }
  }

  Future<Configuration> getConfig() async {
    state = const AsyncLoading();
    final config = await ref.read(getConfigProvider.future);
    return config;
  }

  Future<void> setConfig(Configuration config) async {
    state = const AsyncLoading();
    try {
      await ref.read(setConfigProvider(newConfig: config).future);
      state = AsyncData(config);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

@riverpod
class SysPromptController extends _$SysPromptController {
  @override
  FutureOr<List<SysPrompt>?> build() async {
    if (state.value == null) {
      try {
        final prompts = await getPrompts();
        return prompts;
      } catch (e) {
        return [];
      }
    } else {
      return state.value;
    }
  }

  Future<List<SysPrompt>> getPrompts() async {
    state = const AsyncLoading();
    final prompts = await ref.read(getSysPromptsProvider.future);
    return prompts;
  }

  Future<void> setgetPrompts(List<SysPrompt> prompts) async {
    state = const AsyncLoading();
    try {
      await ref.read(setSysPromptsProvider(sysPrompts: prompts).future);
      state = AsyncData(prompts);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
