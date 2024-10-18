// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionListControllerHash() =>
    r'29a33d65b7ecd4858c8b7bd9f7005bc97c4135c4';

/// See also [SessionListController].
@ProviderFor(SessionListController)
final sessionListControllerProvider = AutoDisposeAsyncNotifierProvider<
    SessionListController, List<ChatSession>>.internal(
  SessionListController.new,
  name: r'sessionListControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionListControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionListController = AutoDisposeAsyncNotifier<List<ChatSession>>;
String _$currentSessionControllerHash() =>
    r'217da21f6cfc1b364637e095fa99854b5d4ca998';

/// See also [CurrentSessionController].
@ProviderFor(CurrentSessionController)
final currentSessionControllerProvider = AutoDisposeAsyncNotifierProvider<
    CurrentSessionController, ChatSession?>.internal(
  CurrentSessionController.new,
  name: r'currentSessionControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSessionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSessionController = AutoDisposeAsyncNotifier<ChatSession?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
