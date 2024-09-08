// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configServiceHash() => r'71a4ed4651f76e13369612aab632a3d44784e455';

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
String _$sysPromptServiceHash() => r'92e1f3d2a2d415063b7773ce24cf7d340dc2f3c5';

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
String _$selectedSysPromptHash() => r'2ff4ca73fe3ee54158b97e9a78287cc3d6bcac9e';

/// See also [SelectedSysPrompt].
@ProviderFor(SelectedSysPrompt)
final selectedSysPromptProvider =
    AutoDisposeNotifierProvider<SelectedSysPrompt, SysPrompt?>.internal(
  SelectedSysPrompt.new,
  name: r'selectedSysPromptProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSysPromptHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSysPrompt = AutoDisposeNotifier<SysPrompt?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
