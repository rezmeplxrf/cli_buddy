import 'dart:convert';

import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/constant/pref.dart';
import 'package:buddy_chat/scr/domain/config.dart';
import 'package:buddy_chat/scr/domain/open_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@riverpod
class SelectedSysPrompt extends _$SelectedSysPrompt {
  @override
  SysPrompt? build() {
    return null;
  }

  void set(SysPrompt sysPrompt) {
    state = sysPrompt;
    prefs.setString('selectedSysPrompt', jsonEncode(sysPrompt));
  }

  Future<void> load() async {
    final savedSysPrompt = await prefs.getString('selectedSysPrompt');
    if (savedSysPrompt == null) {
      return;
    }
    state =
        SysPrompt.fromJson(jsonDecode(savedSysPrompt) as Map<String, dynamic>);
  }
}

@riverpod
class SelectedOverridingModel extends _$SelectedOverridingModel {
  @override
  Future<ORModel?> build() async {
    final saved = await load();
    return saved;
  }

  void set(ORModel? model) {
    state = const AsyncLoading();
    state = AsyncData(model);
    if (model == null) {
      prefs.remove('selectedModel');
    } else {
      prefs.setString('selectedModel', jsonEncode(model));
    }
  }

  Future<ORModel?> load() async {
    final savedModel = await prefs.getString('selectedModel');
    if (savedModel == null) {
      return null;
    }
    final model =
        ORModel.fromJson(jsonDecode(savedModel) as Map<String, dynamic>);
    return model;
  }
}

@riverpod
class CustomValidationPrompt extends _$CustomValidationPrompt {
  @override
  String? build() {
    load();
    return null;
  }

  Future<void> set(String newPrompt) async {
    await prefs.setString('customValidationPrompt', newPrompt);
    state = newPrompt;
  }

  Future<void> load() async {
    final savedPrompt = await prefs.getString('customValidationPrompt');
    state = savedPrompt;
  }
}

@riverpod
class IsAIResponding extends _$IsAIResponding {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class AutoCompleteController extends _$AutoCompleteController {
  @override
  Future<AutoComplete?> build() async {
    final savedConfig = await load();
    return savedConfig;
  }

  Future<void> set(AutoComplete? data) async {
    state = const AsyncLoading();
    if (data == null) {
      final config = await ref.read(configServiceProvider.future);
      final overridingModel =
          await ref.read(selectedOverridingModelProvider.future);
      final defaultData = AutoComplete(
          modelId: config?.openrouterDefaultModel ??
              overridingModel?.id ??
              fallbackModel,
          apiProvider: config?.apiProvider ?? APIProvider.openrouter,
          sysSrompt: defaultAutoCompletePrompt,
          enabled: true);

      await prefs.setString('autoComplete', jsonEncode(defaultData));
    } else {
      await prefs.setString('autoComplete', jsonEncode(data));
    }
    state = AsyncData(data);
  }

  Future<void> saveUsage(AutoComplete? newData) async {
    if (newData == null || newData.usage == null) return;
    final newUsage = newData.usage;

    final usageListJsonStr = await prefs.getString('autoCompleteUsageList');

    if (usageListJsonStr == null) {
      await prefs.setString('autoCompleteUsageList', jsonEncode([newUsage]));
    } else {
      final usageListJson =
          jsonDecode(usageListJsonStr) as List<dynamic>;
      final usageList = usageListJson.map(( e) => Usage.fromJson(e as Map<String, dynamic>)).toList();

      final newUsageList = [...usageList, newUsage];
      await prefs.setString('autoCompleteUsageList', jsonEncode(newUsageList));
    }
  }
// TODO: display it somewhere along with all Sessions usages.
  Future<List<Usage>?> loadUsageList() async {
    final usageListJsonStr = await prefs.getString('autoCompleteUsageList');
    if (usageListJsonStr == null) {
      return null;
    }
    final usageListJson =
        jsonDecode(usageListJsonStr) as List<Map<String, dynamic>>;
    final usageList = usageListJson.map(Usage.fromJson).toList();
    return usageList;
  }

  Future<AutoComplete?> load() async {
    final savedConfig = await prefs.getString('autoComplete');
    if (savedConfig != null) {
      final data = AutoComplete.fromJson(
          jsonDecode(savedConfig) as Map<String, dynamic>);
      return data;
    } else {
      await set(null);
      final newData = await load();
      return newData;
    }
  }
}
