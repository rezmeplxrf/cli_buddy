// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$modelInfoServiceHash() => r'35d5e6f14c43e88d9a1b82e3ab6448dc8c3c7204';

/// See also [ModelInfoService].
@ProviderFor(ModelInfoService)
final modelInfoServiceProvider =
    AutoDisposeAsyncNotifierProvider<ModelInfoService, List<ORModel>>.internal(
  ModelInfoService.new,
  name: r'modelInfoServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$modelInfoServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ModelInfoService = AutoDisposeAsyncNotifier<List<ORModel>>;
String _$parameterQueryServiceHash() =>
    r'0b95d54d352081067ea7db62d383f98dbbdbf5aa';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ParameterQueryService
    extends BuildlessAutoDisposeAsyncNotifier<ParameterInfo?> {
  late final String modelId;

  FutureOr<ParameterInfo?> build({
    required String modelId,
  });
}

/// See also [ParameterQueryService].
@ProviderFor(ParameterQueryService)
const parameterQueryServiceProvider = ParameterQueryServiceFamily();

/// See also [ParameterQueryService].
class ParameterQueryServiceFamily extends Family<AsyncValue<ParameterInfo?>> {
  /// See also [ParameterQueryService].
  const ParameterQueryServiceFamily();

  /// See also [ParameterQueryService].
  ParameterQueryServiceProvider call({
    required String modelId,
  }) {
    return ParameterQueryServiceProvider(
      modelId: modelId,
    );
  }

  @override
  ParameterQueryServiceProvider getProviderOverride(
    covariant ParameterQueryServiceProvider provider,
  ) {
    return call(
      modelId: provider.modelId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'parameterQueryServiceProvider';
}

/// See also [ParameterQueryService].
class ParameterQueryServiceProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ParameterQueryService,
        ParameterInfo?> {
  /// See also [ParameterQueryService].
  ParameterQueryServiceProvider({
    required String modelId,
  }) : this._internal(
          () => ParameterQueryService()..modelId = modelId,
          from: parameterQueryServiceProvider,
          name: r'parameterQueryServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$parameterQueryServiceHash,
          dependencies: ParameterQueryServiceFamily._dependencies,
          allTransitiveDependencies:
              ParameterQueryServiceFamily._allTransitiveDependencies,
          modelId: modelId,
        );

  ParameterQueryServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.modelId,
  }) : super.internal();

  final String modelId;

  @override
  FutureOr<ParameterInfo?> runNotifierBuild(
    covariant ParameterQueryService notifier,
  ) {
    return notifier.build(
      modelId: modelId,
    );
  }

  @override
  Override overrideWith(ParameterQueryService Function() create) {
    return ProviderOverride(
      origin: this,
      override: ParameterQueryServiceProvider._internal(
        () => create()..modelId = modelId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        modelId: modelId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ParameterQueryService, ParameterInfo?>
      createElement() {
    return _ParameterQueryServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParameterQueryServiceProvider && other.modelId == modelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, modelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ParameterQueryServiceRef
    on AutoDisposeAsyncNotifierProviderRef<ParameterInfo?> {
  /// The parameter `modelId` of this provider.
  String get modelId;
}

class _ParameterQueryServiceProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ParameterQueryService,
        ParameterInfo?> with ParameterQueryServiceRef {
  _ParameterQueryServiceProviderElement(super.provider);

  @override
  String get modelId => (origin as ParameterQueryServiceProvider).modelId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
