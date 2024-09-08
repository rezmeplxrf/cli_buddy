// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configServiceHash() => r'e017c89dd15b8bbfaa8aaeec9edb350cdca20b3c';

/// See also [ConfigService].
@ProviderFor(ConfigService)
final configServiceProvider =
    AutoDisposeAsyncNotifierProvider<ConfigService, Configuration?>.internal(
  ConfigService.new,
  name: r'configServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConfigService = AutoDisposeAsyncNotifier<Configuration?>;
String _$sysPromptServiceHash() => r'00f5cc0c458492761dffe14e428d1f32e25b916c';

/// See also [SysPromptService].
@ProviderFor(SysPromptService)
final sysPromptServiceProvider = AutoDisposeAsyncNotifierProvider<
    SysPromptService, List<SysPrompt>>.internal(
  SysPromptService.new,
  name: r'sysPromptServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sysPromptServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SysPromptService = AutoDisposeAsyncNotifier<List<SysPrompt>>;
String _$selectedSysPromptHash() => r'c997a56556b9351ef97fa21ffdab23942bd681d0';

/// See also [SelectedSysPrompt].
@ProviderFor(SelectedSysPrompt)
final selectedSysPromptProvider =
    NotifierProvider<SelectedSysPrompt, SysPrompt?>.internal(
  SelectedSysPrompt.new,
  name: r'selectedSysPromptProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSysPromptHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSysPrompt = Notifier<SysPrompt?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
