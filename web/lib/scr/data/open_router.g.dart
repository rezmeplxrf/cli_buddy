// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$openRouterRepositoryHash() =>
    r'8874c564ece3a950da40f0dc73fe53674f670355';

/// See also [openRouterRepository].
@ProviderFor(openRouterRepository)
final openRouterRepositoryProvider =
    AutoDisposeProvider<OpenRouterRepository>.internal(
  openRouterRepository,
  name: r'openRouterRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$openRouterRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OpenRouterRepositoryRef = AutoDisposeProviderRef<OpenRouterRepository>;
String _$openRouterAutoCompleteHash() =>
    r'3b8e54400089c439420bea8b6cab45f173ddabcd';

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

/// See also [openRouterAutoComplete].
@ProviderFor(openRouterAutoComplete)
const openRouterAutoCompleteProvider = OpenRouterAutoCompleteFamily();

/// See also [openRouterAutoComplete].
class OpenRouterAutoCompleteFamily extends Family<AsyncValue<AutoComplete?>> {
  /// See also [openRouterAutoComplete].
  const OpenRouterAutoCompleteFamily();

  /// See also [openRouterAutoComplete].
  OpenRouterAutoCompleteProvider call({
    required String context,
  }) {
    return OpenRouterAutoCompleteProvider(
      context: context,
    );
  }

  @override
  OpenRouterAutoCompleteProvider getProviderOverride(
    covariant OpenRouterAutoCompleteProvider provider,
  ) {
    return call(
      context: provider.context,
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
  String? get name => r'openRouterAutoCompleteProvider';
}

/// See also [openRouterAutoComplete].
class OpenRouterAutoCompleteProvider
    extends AutoDisposeFutureProvider<AutoComplete?> {
  /// See also [openRouterAutoComplete].
  OpenRouterAutoCompleteProvider({
    required String context,
  }) : this._internal(
          (ref) => openRouterAutoComplete(
            ref as OpenRouterAutoCompleteRef,
            context: context,
          ),
          from: openRouterAutoCompleteProvider,
          name: r'openRouterAutoCompleteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$openRouterAutoCompleteHash,
          dependencies: OpenRouterAutoCompleteFamily._dependencies,
          allTransitiveDependencies:
              OpenRouterAutoCompleteFamily._allTransitiveDependencies,
          context: context,
        );

  OpenRouterAutoCompleteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final String context;

  @override
  Override overrideWith(
    FutureOr<AutoComplete?> Function(OpenRouterAutoCompleteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OpenRouterAutoCompleteProvider._internal(
        (ref) => create(ref as OpenRouterAutoCompleteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AutoComplete?> createElement() {
    return _OpenRouterAutoCompleteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenRouterAutoCompleteProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OpenRouterAutoCompleteRef on AutoDisposeFutureProviderRef<AutoComplete?> {
  /// The parameter `context` of this provider.
  String get context;
}

class _OpenRouterAutoCompleteProviderElement
    extends AutoDisposeFutureProviderElement<AutoComplete?>
    with OpenRouterAutoCompleteRef {
  _OpenRouterAutoCompleteProviderElement(super.provider);

  @override
  String get context => (origin as OpenRouterAutoCompleteProvider).context;
}

String _$openrouterRequestValidationHash() =>
    r'56d545c0c42250927b6a3877cd25732b9773b38d';

/// See also [openrouterRequestValidation].
@ProviderFor(openrouterRequestValidation)
const openrouterRequestValidationProvider = OpenrouterRequestValidationFamily();

/// See also [openrouterRequestValidation].
class OpenrouterRequestValidationFamily
    extends Family<AsyncValue<ChatSession?>> {
  /// See also [openrouterRequestValidation].
  const OpenrouterRequestValidationFamily();

  /// See also [openrouterRequestValidation].
  OpenrouterRequestValidationProvider call({
    required InvalidType request,
  }) {
    return OpenrouterRequestValidationProvider(
      request: request,
    );
  }

  @override
  OpenrouterRequestValidationProvider getProviderOverride(
    covariant OpenrouterRequestValidationProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'openrouterRequestValidationProvider';
}

/// See also [openrouterRequestValidation].
class OpenrouterRequestValidationProvider
    extends AutoDisposeFutureProvider<ChatSession?> {
  /// See also [openrouterRequestValidation].
  OpenrouterRequestValidationProvider({
    required InvalidType request,
  }) : this._internal(
          (ref) => openrouterRequestValidation(
            ref as OpenrouterRequestValidationRef,
            request: request,
          ),
          from: openrouterRequestValidationProvider,
          name: r'openrouterRequestValidationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$openrouterRequestValidationHash,
          dependencies: OpenrouterRequestValidationFamily._dependencies,
          allTransitiveDependencies:
              OpenrouterRequestValidationFamily._allTransitiveDependencies,
          request: request,
        );

  OpenrouterRequestValidationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final InvalidType request;

  @override
  Override overrideWith(
    FutureOr<ChatSession?> Function(OpenrouterRequestValidationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OpenrouterRequestValidationProvider._internal(
        (ref) => create(ref as OpenrouterRequestValidationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChatSession?> createElement() {
    return _OpenrouterRequestValidationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenrouterRequestValidationProvider &&
        other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OpenrouterRequestValidationRef
    on AutoDisposeFutureProviderRef<ChatSession?> {
  /// The parameter `request` of this provider.
  InvalidType get request;
}

class _OpenrouterRequestValidationProviderElement
    extends AutoDisposeFutureProviderElement<ChatSession?>
    with OpenrouterRequestValidationRef {
  _OpenrouterRequestValidationProviderElement(super.provider);

  @override
  InvalidType get request =>
      (origin as OpenrouterRequestValidationProvider).request;
}

String _$listOpenRouterModelsHash() =>
    r'160f33a851374fe49b534c5d2ccff336e8e765fa';

/// See also [listOpenRouterModels].
@ProviderFor(listOpenRouterModels)
final listOpenRouterModelsProvider =
    AutoDisposeFutureProvider<List<ORModel>>.internal(
  listOpenRouterModels,
  name: r'listOpenRouterModelsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listOpenRouterModelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ListOpenRouterModelsRef = AutoDisposeFutureProviderRef<List<ORModel>>;
String _$queryParametersHash() => r'557b37a276bf872c6fae1b1c4ccdb67946e18e38';

/// See also [queryParameters].
@ProviderFor(queryParameters)
const queryParametersProvider = QueryParametersFamily();

/// See also [queryParameters].
class QueryParametersFamily extends Family<AsyncValue<ParameterInfo?>> {
  /// See also [queryParameters].
  const QueryParametersFamily();

  /// See also [queryParameters].
  QueryParametersProvider call({
    required String model,
  }) {
    return QueryParametersProvider(
      model: model,
    );
  }

  @override
  QueryParametersProvider getProviderOverride(
    covariant QueryParametersProvider provider,
  ) {
    return call(
      model: provider.model,
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
  String? get name => r'queryParametersProvider';
}

/// See also [queryParameters].
class QueryParametersProvider
    extends AutoDisposeFutureProvider<ParameterInfo?> {
  /// See also [queryParameters].
  QueryParametersProvider({
    required String model,
  }) : this._internal(
          (ref) => queryParameters(
            ref as QueryParametersRef,
            model: model,
          ),
          from: queryParametersProvider,
          name: r'queryParametersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$queryParametersHash,
          dependencies: QueryParametersFamily._dependencies,
          allTransitiveDependencies:
              QueryParametersFamily._allTransitiveDependencies,
          model: model,
        );

  QueryParametersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
  }) : super.internal();

  final String model;

  @override
  Override overrideWith(
    FutureOr<ParameterInfo?> Function(QueryParametersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QueryParametersProvider._internal(
        (ref) => create(ref as QueryParametersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        model: model,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ParameterInfo?> createElement() {
    return _QueryParametersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QueryParametersProvider && other.model == model;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QueryParametersRef on AutoDisposeFutureProviderRef<ParameterInfo?> {
  /// The parameter `model` of this provider.
  String get model;
}

class _QueryParametersProviderElement
    extends AutoDisposeFutureProviderElement<ParameterInfo?>
    with QueryParametersRef {
  _QueryParametersProviderElement(super.provider);

  @override
  String get model => (origin as QueryParametersProvider).model;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
