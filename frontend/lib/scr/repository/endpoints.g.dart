// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoints.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listSessionHash() => r'0fe423ea9f71ab6c4b9daf27801ed3d7d3149b7a';

/// See also [listSession].
@ProviderFor(listSession)
final listSessionProvider =
    AutoDisposeFutureProvider<List<ChatSession>>.internal(
  listSession,
  name: r'listSessionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ListSessionRef = AutoDisposeFutureProviderRef<List<ChatSession>>;
String _$getSysPromptsHash() => r'9f6570ee9071c4dd224903aa86abc4246b0973ed';

/// See also [getSysPrompts].
@ProviderFor(getSysPrompts)
final getSysPromptsProvider =
    AutoDisposeFutureProvider<List<SysPrompt>>.internal(
  getSysPrompts,
  name: r'getSysPromptsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSysPromptsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSysPromptsRef = AutoDisposeFutureProviderRef<List<SysPrompt>>;
String _$setSysPromptsHash() => r'35ab24eaa552603ce31c97290dd323730e1d911b';

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

/// See also [setSysPrompts].
@ProviderFor(setSysPrompts)
const setSysPromptsProvider = SetSysPromptsFamily();

/// See also [setSysPrompts].
class SetSysPromptsFamily extends Family<AsyncValue<bool>> {
  /// See also [setSysPrompts].
  const SetSysPromptsFamily();

  /// See also [setSysPrompts].
  SetSysPromptsProvider call({
    required List<SysPrompt> sysPrompts,
  }) {
    return SetSysPromptsProvider(
      sysPrompts: sysPrompts,
    );
  }

  @override
  SetSysPromptsProvider getProviderOverride(
    covariant SetSysPromptsProvider provider,
  ) {
    return call(
      sysPrompts: provider.sysPrompts,
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
  String? get name => r'setSysPromptsProvider';
}

/// See also [setSysPrompts].
class SetSysPromptsProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [setSysPrompts].
  SetSysPromptsProvider({
    required List<SysPrompt> sysPrompts,
  }) : this._internal(
          (ref) => setSysPrompts(
            ref as SetSysPromptsRef,
            sysPrompts: sysPrompts,
          ),
          from: setSysPromptsProvider,
          name: r'setSysPromptsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setSysPromptsHash,
          dependencies: SetSysPromptsFamily._dependencies,
          allTransitiveDependencies:
              SetSysPromptsFamily._allTransitiveDependencies,
          sysPrompts: sysPrompts,
        );

  SetSysPromptsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sysPrompts,
  }) : super.internal();

  final List<SysPrompt> sysPrompts;

  @override
  Override overrideWith(
    FutureOr<bool> Function(SetSysPromptsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetSysPromptsProvider._internal(
        (ref) => create(ref as SetSysPromptsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sysPrompts: sysPrompts,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SetSysPromptsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetSysPromptsProvider && other.sysPrompts == sysPrompts;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sysPrompts.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SetSysPromptsRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `sysPrompts` of this provider.
  List<SysPrompt> get sysPrompts;
}

class _SetSysPromptsProviderElement
    extends AutoDisposeFutureProviderElement<bool> with SetSysPromptsRef {
  _SetSysPromptsProviderElement(super.provider);

  @override
  List<SysPrompt> get sysPrompts =>
      (origin as SetSysPromptsProvider).sysPrompts;
}

String _$removeSessionHash() => r'71d1cf0c453812696c76e59e0103509b98101654';

/// See also [removeSession].
@ProviderFor(removeSession)
const removeSessionProvider = RemoveSessionFamily();

/// See also [removeSession].
class RemoveSessionFamily extends Family<AsyncValue<int>> {
  /// See also [removeSession].
  const RemoveSessionFamily();

  /// See also [removeSession].
  RemoveSessionProvider call({
    required int id,
  }) {
    return RemoveSessionProvider(
      id: id,
    );
  }

  @override
  RemoveSessionProvider getProviderOverride(
    covariant RemoveSessionProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'removeSessionProvider';
}

/// See also [removeSession].
class RemoveSessionProvider extends AutoDisposeFutureProvider<int> {
  /// See also [removeSession].
  RemoveSessionProvider({
    required int id,
  }) : this._internal(
          (ref) => removeSession(
            ref as RemoveSessionRef,
            id: id,
          ),
          from: removeSessionProvider,
          name: r'removeSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeSessionHash,
          dependencies: RemoveSessionFamily._dependencies,
          allTransitiveDependencies:
              RemoveSessionFamily._allTransitiveDependencies,
          id: id,
        );

  RemoveSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<int> Function(RemoveSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveSessionProvider._internal(
        (ref) => create(ref as RemoveSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _RemoveSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveSessionProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RemoveSessionRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `id` of this provider.
  int get id;
}

class _RemoveSessionProviderElement
    extends AutoDisposeFutureProviderElement<int> with RemoveSessionRef {
  _RemoveSessionProviderElement(super.provider);

  @override
  int get id => (origin as RemoveSessionProvider).id;
}

String _$removeAllSessionsHash() => r'fc3dc8fbe2403fef82358ad1a4273cfe99dceed2';

/// See also [removeAllSessions].
@ProviderFor(removeAllSessions)
final removeAllSessionsProvider = AutoDisposeFutureProvider<void>.internal(
  removeAllSessions,
  name: r'removeAllSessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$removeAllSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RemoveAllSessionsRef = AutoDisposeFutureProviderRef<void>;
String _$makeFileHash() => r'18808e36d96659231f8b9d8e801170dfea39be00';

/// See also [makeFile].
@ProviderFor(makeFile)
const makeFileProvider = MakeFileFamily();

/// See also [makeFile].
class MakeFileFamily extends Family<AsyncValue<String>> {
  /// See also [makeFile].
  const MakeFileFamily();

  /// See also [makeFile].
  MakeFileProvider call({
    required String path,
    required String code,
  }) {
    return MakeFileProvider(
      path: path,
      code: code,
    );
  }

  @override
  MakeFileProvider getProviderOverride(
    covariant MakeFileProvider provider,
  ) {
    return call(
      path: provider.path,
      code: provider.code,
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
  String? get name => r'makeFileProvider';
}

/// See also [makeFile].
class MakeFileProvider extends AutoDisposeFutureProvider<String> {
  /// See also [makeFile].
  MakeFileProvider({
    required String path,
    required String code,
  }) : this._internal(
          (ref) => makeFile(
            ref as MakeFileRef,
            path: path,
            code: code,
          ),
          from: makeFileProvider,
          name: r'makeFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$makeFileHash,
          dependencies: MakeFileFamily._dependencies,
          allTransitiveDependencies: MakeFileFamily._allTransitiveDependencies,
          path: path,
          code: code,
        );

  MakeFileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
    required this.code,
  }) : super.internal();

  final String path;
  final String code;

  @override
  Override overrideWith(
    FutureOr<String> Function(MakeFileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MakeFileProvider._internal(
        (ref) => create(ref as MakeFileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _MakeFileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MakeFileProvider &&
        other.path == path &&
        other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MakeFileRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `path` of this provider.
  String get path;

  /// The parameter `code` of this provider.
  String get code;
}

class _MakeFileProviderElement extends AutoDisposeFutureProviderElement<String>
    with MakeFileRef {
  _MakeFileProviderElement(super.provider);

  @override
  String get path => (origin as MakeFileProvider).path;
  @override
  String get code => (origin as MakeFileProvider).code;
}

String _$getConfigHash() => r'2c7364498e16717df9ac073a90c7560dcc0acef0';

/// See also [getConfig].
@ProviderFor(getConfig)
final getConfigProvider = AutoDisposeFutureProvider<Configuration>.internal(
  getConfig,
  name: r'getConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetConfigRef = AutoDisposeFutureProviderRef<Configuration>;
String _$setConfigHash() => r'98b160236485387afcfabcca2671b35a4ee66446';

/// See also [setConfig].
@ProviderFor(setConfig)
const setConfigProvider = SetConfigFamily();

/// See also [setConfig].
class SetConfigFamily extends Family<AsyncValue<Configuration>> {
  /// See also [setConfig].
  const SetConfigFamily();

  /// See also [setConfig].
  SetConfigProvider call({
    required Configuration newConfig,
  }) {
    return SetConfigProvider(
      newConfig: newConfig,
    );
  }

  @override
  SetConfigProvider getProviderOverride(
    covariant SetConfigProvider provider,
  ) {
    return call(
      newConfig: provider.newConfig,
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
  String? get name => r'setConfigProvider';
}

/// See also [setConfig].
class SetConfigProvider extends AutoDisposeFutureProvider<Configuration> {
  /// See also [setConfig].
  SetConfigProvider({
    required Configuration newConfig,
  }) : this._internal(
          (ref) => setConfig(
            ref as SetConfigRef,
            newConfig: newConfig,
          ),
          from: setConfigProvider,
          name: r'setConfigProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setConfigHash,
          dependencies: SetConfigFamily._dependencies,
          allTransitiveDependencies: SetConfigFamily._allTransitiveDependencies,
          newConfig: newConfig,
        );

  SetConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.newConfig,
  }) : super.internal();

  final Configuration newConfig;

  @override
  Override overrideWith(
    FutureOr<Configuration> Function(SetConfigRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetConfigProvider._internal(
        (ref) => create(ref as SetConfigRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        newConfig: newConfig,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Configuration> createElement() {
    return _SetConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetConfigProvider && other.newConfig == newConfig;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, newConfig.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SetConfigRef on AutoDisposeFutureProviderRef<Configuration> {
  /// The parameter `newConfig` of this provider.
  Configuration get newConfig;
}

class _SetConfigProviderElement
    extends AutoDisposeFutureProviderElement<Configuration> with SetConfigRef {
  _SetConfigProviderElement(super.provider);

  @override
  Configuration get newConfig => (origin as SetConfigProvider).newConfig;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
