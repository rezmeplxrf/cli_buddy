// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionServiceHash() => r'ec166327ba5dd5e939ee9205e86eff0c1f02ec9c';

/// See also [SessionService].
@ProviderFor(SessionService)
final sessionServiceProvider = AutoDisposeAsyncNotifierProvider<SessionService,
    List<ChatSession>>.internal(
  SessionService.new,
  name: r'sessionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionService = AutoDisposeAsyncNotifier<List<ChatSession>>;
String _$currentSessionControllerHash() =>
    r'aebb32ca9524ee9a97627b4ff17b05ad8cc9ea4e';

/// See also [CurrentSessionController].
@ProviderFor(CurrentSessionController)
final currentSessionControllerProvider =
    AsyncNotifierProvider<CurrentSessionController, ChatSession?>.internal(
  CurrentSessionController.new,
  name: r'currentSessionControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSessionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSessionController = AsyncNotifier<ChatSession?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
