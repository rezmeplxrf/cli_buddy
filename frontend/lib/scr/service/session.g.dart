// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionServiceHash() => r'd2fde3c77028468d60df23ce1cceed14c23bf55f';

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
    r'75271d81bcb3a6bf0b7513c41b7408e222830263';

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
