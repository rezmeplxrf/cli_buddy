// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionListControllerHash() =>
    r'f6499d7b16a18508990d322cd5a911a5652f9945';

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
    r'821fbca2793f5792be8b84abb459890365e0cfe9';

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
