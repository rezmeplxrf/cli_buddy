// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configServiceHash() => r'a7b5999add6a8a64c757dad59f24931201ac9b26';

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
String _$sysPromptServiceHash() => r'ddad9186cdbfe65bf001a0440007b02dfe3841de';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
