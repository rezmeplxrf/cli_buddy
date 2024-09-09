// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_router.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ORResponse _$ORResponseFromJson(Map<String, dynamic> json) {
  return _ORResponse.fromJson(json);
}

/// @nodoc
mixin _$ORResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get object => throw _privateConstructorUsedError;
  int? get created => throw _privateConstructorUsedError;
  List<Choices>? get choices => throw _privateConstructorUsedError;
  Usage? get usage => throw _privateConstructorUsedError;
  @JsonKey(name: 'system_fingerprint')
  String? get systemFingerprint => throw _privateConstructorUsedError;

  /// Serializes this ORResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ORResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ORResponseCopyWith<ORResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ORResponseCopyWith<$Res> {
  factory $ORResponseCopyWith(
          ORResponse value, $Res Function(ORResponse) then) =
      _$ORResponseCopyWithImpl<$Res, ORResponse>;
  @useResult
  $Res call(
      {String? id,
      String? model,
      String? object,
      int? created,
      List<Choices>? choices,
      Usage? usage,
      @JsonKey(name: 'system_fingerprint') String? systemFingerprint});

  $UsageCopyWith<$Res>? get usage;
}

/// @nodoc
class _$ORResponseCopyWithImpl<$Res, $Val extends ORResponse>
    implements $ORResponseCopyWith<$Res> {
  _$ORResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ORResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? model = freezed,
    Object? object = freezed,
    Object? created = freezed,
    Object? choices = freezed,
    Object? usage = freezed,
    Object? systemFingerprint = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      object: freezed == object
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int?,
      choices: freezed == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<Choices>?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
      systemFingerprint: freezed == systemFingerprint
          ? _value.systemFingerprint
          : systemFingerprint // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ORResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsageCopyWith<$Res>? get usage {
    if (_value.usage == null) {
      return null;
    }

    return $UsageCopyWith<$Res>(_value.usage!, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ORResponseImplCopyWith<$Res>
    implements $ORResponseCopyWith<$Res> {
  factory _$$ORResponseImplCopyWith(
          _$ORResponseImpl value, $Res Function(_$ORResponseImpl) then) =
      __$$ORResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? model,
      String? object,
      int? created,
      List<Choices>? choices,
      Usage? usage,
      @JsonKey(name: 'system_fingerprint') String? systemFingerprint});

  @override
  $UsageCopyWith<$Res>? get usage;
}

/// @nodoc
class __$$ORResponseImplCopyWithImpl<$Res>
    extends _$ORResponseCopyWithImpl<$Res, _$ORResponseImpl>
    implements _$$ORResponseImplCopyWith<$Res> {
  __$$ORResponseImplCopyWithImpl(
      _$ORResponseImpl _value, $Res Function(_$ORResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ORResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? model = freezed,
    Object? object = freezed,
    Object? created = freezed,
    Object? choices = freezed,
    Object? usage = freezed,
    Object? systemFingerprint = freezed,
  }) {
    return _then(_$ORResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      object: freezed == object
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int?,
      choices: freezed == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<Choices>?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
      systemFingerprint: freezed == systemFingerprint
          ? _value.systemFingerprint
          : systemFingerprint // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ORResponseImpl implements _ORResponse {
  const _$ORResponseImpl(
      {this.id,
      this.model,
      this.object,
      this.created,
      final List<Choices>? choices,
      this.usage,
      @JsonKey(name: 'system_fingerprint') this.systemFingerprint})
      : _choices = choices;

  factory _$ORResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ORResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? model;
  @override
  final String? object;
  @override
  final int? created;
  final List<Choices>? _choices;
  @override
  List<Choices>? get choices {
    final value = _choices;
    if (value == null) return null;
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Usage? usage;
  @override
  @JsonKey(name: 'system_fingerprint')
  final String? systemFingerprint;

  @override
  String toString() {
    return 'ORResponse(id: $id, model: $model, object: $object, created: $created, choices: $choices, usage: $usage, systemFingerprint: $systemFingerprint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ORResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.object, object) || other.object == object) &&
            (identical(other.created, created) || other.created == created) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.systemFingerprint, systemFingerprint) ||
                other.systemFingerprint == systemFingerprint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, model, object, created,
      const DeepCollectionEquality().hash(_choices), usage, systemFingerprint);

  /// Create a copy of ORResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ORResponseImplCopyWith<_$ORResponseImpl> get copyWith =>
      __$$ORResponseImplCopyWithImpl<_$ORResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ORResponseImplToJson(
      this,
    );
  }
}

abstract class _ORResponse implements ORResponse {
  const factory _ORResponse(
      {final String? id,
      final String? model,
      final String? object,
      final int? created,
      final List<Choices>? choices,
      final Usage? usage,
      @JsonKey(name: 'system_fingerprint')
      final String? systemFingerprint}) = _$ORResponseImpl;

  factory _ORResponse.fromJson(Map<String, dynamic> json) =
      _$ORResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get model;
  @override
  String? get object;
  @override
  int? get created;
  @override
  List<Choices>? get choices;
  @override
  Usage? get usage;
  @override
  @JsonKey(name: 'system_fingerprint')
  String? get systemFingerprint;

  /// Create a copy of ORResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ORResponseImplCopyWith<_$ORResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Choices _$ChoicesFromJson(Map<String, dynamic> json) {
  return _Choices.fromJson(json);
}

/// @nodoc
mixin _$Choices {
  Delta? get delta => throw _privateConstructorUsedError;
  @JsonKey(name: 'finish_reason')
  String? get finishReason => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;
  Logprobs? get logprobs => throw _privateConstructorUsedError;

  /// Serializes this Choices to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChoicesCopyWith<Choices> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoicesCopyWith<$Res> {
  factory $ChoicesCopyWith(Choices value, $Res Function(Choices) then) =
      _$ChoicesCopyWithImpl<$Res, Choices>;
  @useResult
  $Res call(
      {Delta? delta,
      @JsonKey(name: 'finish_reason') String? finishReason,
      Error? error,
      Logprobs? logprobs});

  $DeltaCopyWith<$Res>? get delta;
  $ErrorCopyWith<$Res>? get error;
  $LogprobsCopyWith<$Res>? get logprobs;
}

/// @nodoc
class _$ChoicesCopyWithImpl<$Res, $Val extends Choices>
    implements $ChoicesCopyWith<$Res> {
  _$ChoicesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delta = freezed,
    Object? finishReason = freezed,
    Object? error = freezed,
    Object? logprobs = freezed,
  }) {
    return _then(_value.copyWith(
      delta: freezed == delta
          ? _value.delta
          : delta // ignore: cast_nullable_to_non_nullable
              as Delta?,
      finishReason: freezed == finishReason
          ? _value.finishReason
          : finishReason // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
      logprobs: freezed == logprobs
          ? _value.logprobs
          : logprobs // ignore: cast_nullable_to_non_nullable
              as Logprobs?,
    ) as $Val);
  }

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeltaCopyWith<$Res>? get delta {
    if (_value.delta == null) {
      return null;
    }

    return $DeltaCopyWith<$Res>(_value.delta!, (value) {
      return _then(_value.copyWith(delta: value) as $Val);
    });
  }

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $ErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LogprobsCopyWith<$Res>? get logprobs {
    if (_value.logprobs == null) {
      return null;
    }

    return $LogprobsCopyWith<$Res>(_value.logprobs!, (value) {
      return _then(_value.copyWith(logprobs: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChoicesImplCopyWith<$Res> implements $ChoicesCopyWith<$Res> {
  factory _$$ChoicesImplCopyWith(
          _$ChoicesImpl value, $Res Function(_$ChoicesImpl) then) =
      __$$ChoicesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Delta? delta,
      @JsonKey(name: 'finish_reason') String? finishReason,
      Error? error,
      Logprobs? logprobs});

  @override
  $DeltaCopyWith<$Res>? get delta;
  @override
  $ErrorCopyWith<$Res>? get error;
  @override
  $LogprobsCopyWith<$Res>? get logprobs;
}

/// @nodoc
class __$$ChoicesImplCopyWithImpl<$Res>
    extends _$ChoicesCopyWithImpl<$Res, _$ChoicesImpl>
    implements _$$ChoicesImplCopyWith<$Res> {
  __$$ChoicesImplCopyWithImpl(
      _$ChoicesImpl _value, $Res Function(_$ChoicesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? delta = freezed,
    Object? finishReason = freezed,
    Object? error = freezed,
    Object? logprobs = freezed,
  }) {
    return _then(_$ChoicesImpl(
      delta: freezed == delta
          ? _value.delta
          : delta // ignore: cast_nullable_to_non_nullable
              as Delta?,
      finishReason: freezed == finishReason
          ? _value.finishReason
          : finishReason // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
      logprobs: freezed == logprobs
          ? _value.logprobs
          : logprobs // ignore: cast_nullable_to_non_nullable
              as Logprobs?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ChoicesImpl implements _Choices {
  const _$ChoicesImpl(
      {this.delta,
      @JsonKey(name: 'finish_reason') this.finishReason,
      this.error,
      this.logprobs});

  factory _$ChoicesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoicesImplFromJson(json);

  @override
  final Delta? delta;
  @override
  @JsonKey(name: 'finish_reason')
  final String? finishReason;
  @override
  final Error? error;
  @override
  final Logprobs? logprobs;

  @override
  String toString() {
    return 'Choices(delta: $delta, finishReason: $finishReason, error: $error, logprobs: $logprobs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoicesImpl &&
            (identical(other.delta, delta) || other.delta == delta) &&
            (identical(other.finishReason, finishReason) ||
                other.finishReason == finishReason) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.logprobs, logprobs) ||
                other.logprobs == logprobs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, delta, finishReason, error, logprobs);

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoicesImplCopyWith<_$ChoicesImpl> get copyWith =>
      __$$ChoicesImplCopyWithImpl<_$ChoicesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChoicesImplToJson(
      this,
    );
  }
}

abstract class _Choices implements Choices {
  const factory _Choices(
      {final Delta? delta,
      @JsonKey(name: 'finish_reason') final String? finishReason,
      final Error? error,
      final Logprobs? logprobs}) = _$ChoicesImpl;

  factory _Choices.fromJson(Map<String, dynamic> json) = _$ChoicesImpl.fromJson;

  @override
  Delta? get delta;
  @override
  @JsonKey(name: 'finish_reason')
  String? get finishReason;
  @override
  Error? get error;
  @override
  Logprobs? get logprobs;

  /// Create a copy of Choices
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChoicesImplCopyWith<_$ChoicesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Delta _$DeltaFromJson(Map<String, dynamic> json) {
  return _Delta.fromJson(json);
}

/// @nodoc
mixin _$Delta {
  String? get role => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'tool_calls')
  List<ToolCall>? get toolCalls => throw _privateConstructorUsedError;

  /// Serializes this Delta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Delta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeltaCopyWith<Delta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeltaCopyWith<$Res> {
  factory $DeltaCopyWith(Delta value, $Res Function(Delta) then) =
      _$DeltaCopyWithImpl<$Res, Delta>;
  @useResult
  $Res call(
      {String? role,
      String? content,
      @JsonKey(name: 'tool_calls') List<ToolCall>? toolCalls});
}

/// @nodoc
class _$DeltaCopyWithImpl<$Res, $Val extends Delta>
    implements $DeltaCopyWith<$Res> {
  _$DeltaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Delta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = freezed,
    Object? content = freezed,
    Object? toolCalls = freezed,
  }) {
    return _then(_value.copyWith(
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      toolCalls: freezed == toolCalls
          ? _value.toolCalls
          : toolCalls // ignore: cast_nullable_to_non_nullable
              as List<ToolCall>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeltaImplCopyWith<$Res> implements $DeltaCopyWith<$Res> {
  factory _$$DeltaImplCopyWith(
          _$DeltaImpl value, $Res Function(_$DeltaImpl) then) =
      __$$DeltaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? role,
      String? content,
      @JsonKey(name: 'tool_calls') List<ToolCall>? toolCalls});
}

/// @nodoc
class __$$DeltaImplCopyWithImpl<$Res>
    extends _$DeltaCopyWithImpl<$Res, _$DeltaImpl>
    implements _$$DeltaImplCopyWith<$Res> {
  __$$DeltaImplCopyWithImpl(
      _$DeltaImpl _value, $Res Function(_$DeltaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Delta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = freezed,
    Object? content = freezed,
    Object? toolCalls = freezed,
  }) {
    return _then(_$DeltaImpl(
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      toolCalls: freezed == toolCalls
          ? _value._toolCalls
          : toolCalls // ignore: cast_nullable_to_non_nullable
              as List<ToolCall>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$DeltaImpl implements _Delta {
  const _$DeltaImpl(
      {this.role,
      this.content,
      @JsonKey(name: 'tool_calls') final List<ToolCall>? toolCalls})
      : _toolCalls = toolCalls;

  factory _$DeltaImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeltaImplFromJson(json);

  @override
  final String? role;
  @override
  final String? content;
  final List<ToolCall>? _toolCalls;
  @override
  @JsonKey(name: 'tool_calls')
  List<ToolCall>? get toolCalls {
    final value = _toolCalls;
    if (value == null) return null;
    if (_toolCalls is EqualUnmodifiableListView) return _toolCalls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Delta(role: $role, content: $content, toolCalls: $toolCalls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeltaImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._toolCalls, _toolCalls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, content,
      const DeepCollectionEquality().hash(_toolCalls));

  /// Create a copy of Delta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeltaImplCopyWith<_$DeltaImpl> get copyWith =>
      __$$DeltaImplCopyWithImpl<_$DeltaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeltaImplToJson(
      this,
    );
  }
}

abstract class _Delta implements Delta {
  const factory _Delta(
          {final String? role,
          final String? content,
          @JsonKey(name: 'tool_calls') final List<ToolCall>? toolCalls}) =
      _$DeltaImpl;

  factory _Delta.fromJson(Map<String, dynamic> json) = _$DeltaImpl.fromJson;

  @override
  String? get role;
  @override
  String? get content;
  @override
  @JsonKey(name: 'tool_calls')
  List<ToolCall>? get toolCalls;

  /// Create a copy of Delta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeltaImplCopyWith<_$DeltaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Logprobs _$LogprobsFromJson(Map<String, dynamic> json) {
  return _Logprobs.fromJson(json);
}

/// @nodoc
mixin _$Logprobs {
  @JsonKey(name: 'content')
  List<Content>? get content => throw _privateConstructorUsedError;
  String? get refusal => throw _privateConstructorUsedError;

  /// Serializes this Logprobs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Logprobs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogprobsCopyWith<Logprobs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogprobsCopyWith<$Res> {
  factory $LogprobsCopyWith(Logprobs value, $Res Function(Logprobs) then) =
      _$LogprobsCopyWithImpl<$Res, Logprobs>;
  @useResult
  $Res call(
      {@JsonKey(name: 'content') List<Content>? content, String? refusal});
}

/// @nodoc
class _$LogprobsCopyWithImpl<$Res, $Val extends Logprobs>
    implements $LogprobsCopyWith<$Res> {
  _$LogprobsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Logprobs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? refusal = freezed,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Content>?,
      refusal: freezed == refusal
          ? _value.refusal
          : refusal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogprobsImplCopyWith<$Res>
    implements $LogprobsCopyWith<$Res> {
  factory _$$LogprobsImplCopyWith(
          _$LogprobsImpl value, $Res Function(_$LogprobsImpl) then) =
      __$$LogprobsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'content') List<Content>? content, String? refusal});
}

/// @nodoc
class __$$LogprobsImplCopyWithImpl<$Res>
    extends _$LogprobsCopyWithImpl<$Res, _$LogprobsImpl>
    implements _$$LogprobsImplCopyWith<$Res> {
  __$$LogprobsImplCopyWithImpl(
      _$LogprobsImpl _value, $Res Function(_$LogprobsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Logprobs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? refusal = freezed,
  }) {
    return _then(_$LogprobsImpl(
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Content>?,
      refusal: freezed == refusal
          ? _value.refusal
          : refusal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogprobsImpl implements _Logprobs {
  const _$LogprobsImpl(
      {@JsonKey(name: 'content') final List<Content>? content, this.refusal})
      : _content = content;

  factory _$LogprobsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogprobsImplFromJson(json);

  final List<Content>? _content;
  @override
  @JsonKey(name: 'content')
  List<Content>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? refusal;

  @override
  String toString() {
    return 'Logprobs(content: $content, refusal: $refusal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogprobsImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.refusal, refusal) || other.refusal == refusal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_content), refusal);

  /// Create a copy of Logprobs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogprobsImplCopyWith<_$LogprobsImpl> get copyWith =>
      __$$LogprobsImplCopyWithImpl<_$LogprobsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogprobsImplToJson(
      this,
    );
  }
}

abstract class _Logprobs implements Logprobs {
  const factory _Logprobs(
      {@JsonKey(name: 'content') final List<Content>? content,
      final String? refusal}) = _$LogprobsImpl;

  factory _Logprobs.fromJson(Map<String, dynamic> json) =
      _$LogprobsImpl.fromJson;

  @override
  @JsonKey(name: 'content')
  List<Content>? get content;
  @override
  String? get refusal;

  /// Create a copy of Logprobs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogprobsImplCopyWith<_$LogprobsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Content _$ContentFromJson(Map<String, dynamic> json) {
  return _Content.fromJson(json);
}

/// @nodoc
mixin _$Content {
  @JsonKey(name: 'token')
  String? get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'logprob')
  double? get logprob => throw _privateConstructorUsedError;
  @JsonKey(name: 'bytes')
  List<int>? get bytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_logprobs')
  List<TopLogprobs>? get topLogprobs => throw _privateConstructorUsedError;

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentCopyWith<Content> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) then) =
      _$ContentCopyWithImpl<$Res, Content>;
  @useResult
  $Res call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'logprob') double? logprob,
      @JsonKey(name: 'bytes') List<int>? bytes,
      @JsonKey(name: 'top_logprobs') List<TopLogprobs>? topLogprobs});
}

/// @nodoc
class _$ContentCopyWithImpl<$Res, $Val extends Content>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? logprob = freezed,
    Object? bytes = freezed,
    Object? topLogprobs = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      logprob: freezed == logprob
          ? _value.logprob
          : logprob // ignore: cast_nullable_to_non_nullable
              as double?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      topLogprobs: freezed == topLogprobs
          ? _value.topLogprobs
          : topLogprobs // ignore: cast_nullable_to_non_nullable
              as List<TopLogprobs>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentImplCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$$ContentImplCopyWith(
          _$ContentImpl value, $Res Function(_$ContentImpl) then) =
      __$$ContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'logprob') double? logprob,
      @JsonKey(name: 'bytes') List<int>? bytes,
      @JsonKey(name: 'top_logprobs') List<TopLogprobs>? topLogprobs});
}

/// @nodoc
class __$$ContentImplCopyWithImpl<$Res>
    extends _$ContentCopyWithImpl<$Res, _$ContentImpl>
    implements _$$ContentImplCopyWith<$Res> {
  __$$ContentImplCopyWithImpl(
      _$ContentImpl _value, $Res Function(_$ContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? logprob = freezed,
    Object? bytes = freezed,
    Object? topLogprobs = freezed,
  }) {
    return _then(_$ContentImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      logprob: freezed == logprob
          ? _value.logprob
          : logprob // ignore: cast_nullable_to_non_nullable
              as double?,
      bytes: freezed == bytes
          ? _value._bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      topLogprobs: freezed == topLogprobs
          ? _value._topLogprobs
          : topLogprobs // ignore: cast_nullable_to_non_nullable
              as List<TopLogprobs>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentImpl implements _Content {
  const _$ContentImpl(
      {@JsonKey(name: 'token') this.token,
      @JsonKey(name: 'logprob') this.logprob,
      @JsonKey(name: 'bytes') final List<int>? bytes,
      @JsonKey(name: 'top_logprobs') final List<TopLogprobs>? topLogprobs})
      : _bytes = bytes,
        _topLogprobs = topLogprobs;

  factory _$ContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentImplFromJson(json);

  @override
  @JsonKey(name: 'token')
  final String? token;
  @override
  @JsonKey(name: 'logprob')
  final double? logprob;
  final List<int>? _bytes;
  @override
  @JsonKey(name: 'bytes')
  List<int>? get bytes {
    final value = _bytes;
    if (value == null) return null;
    if (_bytes is EqualUnmodifiableListView) return _bytes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TopLogprobs>? _topLogprobs;
  @override
  @JsonKey(name: 'top_logprobs')
  List<TopLogprobs>? get topLogprobs {
    final value = _topLogprobs;
    if (value == null) return null;
    if (_topLogprobs is EqualUnmodifiableListView) return _topLogprobs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Content(token: $token, logprob: $logprob, bytes: $bytes, topLogprobs: $topLogprobs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.logprob, logprob) || other.logprob == logprob) &&
            const DeepCollectionEquality().equals(other._bytes, _bytes) &&
            const DeepCollectionEquality()
                .equals(other._topLogprobs, _topLogprobs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      token,
      logprob,
      const DeepCollectionEquality().hash(_bytes),
      const DeepCollectionEquality().hash(_topLogprobs));

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      __$$ContentImplCopyWithImpl<_$ContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentImplToJson(
      this,
    );
  }
}

abstract class _Content implements Content {
  const factory _Content(
      {@JsonKey(name: 'token') final String? token,
      @JsonKey(name: 'logprob') final double? logprob,
      @JsonKey(name: 'bytes') final List<int>? bytes,
      @JsonKey(name: 'top_logprobs')
      final List<TopLogprobs>? topLogprobs}) = _$ContentImpl;

  factory _Content.fromJson(Map<String, dynamic> json) = _$ContentImpl.fromJson;

  @override
  @JsonKey(name: 'token')
  String? get token;
  @override
  @JsonKey(name: 'logprob')
  double? get logprob;
  @override
  @JsonKey(name: 'bytes')
  List<int>? get bytes;
  @override
  @JsonKey(name: 'top_logprobs')
  List<TopLogprobs>? get topLogprobs;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentImplCopyWith<_$ContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopLogprobs _$TopLogprobsFromJson(Map<String, dynamic> json) {
  return _TopLogprobs.fromJson(json);
}

/// @nodoc
mixin _$TopLogprobs {
  @JsonKey(name: 'token')
  String? get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'logprob')
  double? get logprob => throw _privateConstructorUsedError;
  @JsonKey(name: 'bytes')
  List<int>? get bytes => throw _privateConstructorUsedError;

  /// Serializes this TopLogprobs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopLogprobs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopLogprobsCopyWith<TopLogprobs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopLogprobsCopyWith<$Res> {
  factory $TopLogprobsCopyWith(
          TopLogprobs value, $Res Function(TopLogprobs) then) =
      _$TopLogprobsCopyWithImpl<$Res, TopLogprobs>;
  @useResult
  $Res call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'logprob') double? logprob,
      @JsonKey(name: 'bytes') List<int>? bytes});
}

/// @nodoc
class _$TopLogprobsCopyWithImpl<$Res, $Val extends TopLogprobs>
    implements $TopLogprobsCopyWith<$Res> {
  _$TopLogprobsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopLogprobs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? logprob = freezed,
    Object? bytes = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      logprob: freezed == logprob
          ? _value.logprob
          : logprob // ignore: cast_nullable_to_non_nullable
              as double?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopLogprobsImplCopyWith<$Res>
    implements $TopLogprobsCopyWith<$Res> {
  factory _$$TopLogprobsImplCopyWith(
          _$TopLogprobsImpl value, $Res Function(_$TopLogprobsImpl) then) =
      __$$TopLogprobsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'logprob') double? logprob,
      @JsonKey(name: 'bytes') List<int>? bytes});
}

/// @nodoc
class __$$TopLogprobsImplCopyWithImpl<$Res>
    extends _$TopLogprobsCopyWithImpl<$Res, _$TopLogprobsImpl>
    implements _$$TopLogprobsImplCopyWith<$Res> {
  __$$TopLogprobsImplCopyWithImpl(
      _$TopLogprobsImpl _value, $Res Function(_$TopLogprobsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopLogprobs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? logprob = freezed,
    Object? bytes = freezed,
  }) {
    return _then(_$TopLogprobsImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      logprob: freezed == logprob
          ? _value.logprob
          : logprob // ignore: cast_nullable_to_non_nullable
              as double?,
      bytes: freezed == bytes
          ? _value._bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopLogprobsImpl implements _TopLogprobs {
  const _$TopLogprobsImpl(
      {@JsonKey(name: 'token') this.token,
      @JsonKey(name: 'logprob') this.logprob,
      @JsonKey(name: 'bytes') final List<int>? bytes})
      : _bytes = bytes;

  factory _$TopLogprobsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopLogprobsImplFromJson(json);

  @override
  @JsonKey(name: 'token')
  final String? token;
  @override
  @JsonKey(name: 'logprob')
  final double? logprob;
  final List<int>? _bytes;
  @override
  @JsonKey(name: 'bytes')
  List<int>? get bytes {
    final value = _bytes;
    if (value == null) return null;
    if (_bytes is EqualUnmodifiableListView) return _bytes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TopLogprobs(token: $token, logprob: $logprob, bytes: $bytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopLogprobsImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.logprob, logprob) || other.logprob == logprob) &&
            const DeepCollectionEquality().equals(other._bytes, _bytes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, token, logprob, const DeepCollectionEquality().hash(_bytes));

  /// Create a copy of TopLogprobs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopLogprobsImplCopyWith<_$TopLogprobsImpl> get copyWith =>
      __$$TopLogprobsImplCopyWithImpl<_$TopLogprobsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopLogprobsImplToJson(
      this,
    );
  }
}

abstract class _TopLogprobs implements TopLogprobs {
  const factory _TopLogprobs(
      {@JsonKey(name: 'token') final String? token,
      @JsonKey(name: 'logprob') final double? logprob,
      @JsonKey(name: 'bytes') final List<int>? bytes}) = _$TopLogprobsImpl;

  factory _TopLogprobs.fromJson(Map<String, dynamic> json) =
      _$TopLogprobsImpl.fromJson;

  @override
  @JsonKey(name: 'token')
  String? get token;
  @override
  @JsonKey(name: 'logprob')
  double? get logprob;
  @override
  @JsonKey(name: 'bytes')
  List<int>? get bytes;

  /// Create a copy of TopLogprobs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopLogprobsImplCopyWith<_$TopLogprobsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ToolCall _$ToolCallFromJson(Map<String, dynamic> json) {
  return _ToolCall.fromJson(json);
}

/// @nodoc
mixin _$ToolCall {
  String? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  FunctionCall? get function => throw _privateConstructorUsedError;

  /// Serializes this ToolCall to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ToolCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToolCallCopyWith<ToolCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolCallCopyWith<$Res> {
  factory $ToolCallCopyWith(ToolCall value, $Res Function(ToolCall) then) =
      _$ToolCallCopyWithImpl<$Res, ToolCall>;
  @useResult
  $Res call({String? id, String? type, FunctionCall? function});

  $FunctionCallCopyWith<$Res>? get function;
}

/// @nodoc
class _$ToolCallCopyWithImpl<$Res, $Val extends ToolCall>
    implements $ToolCallCopyWith<$Res> {
  _$ToolCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToolCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? function = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      function: freezed == function
          ? _value.function
          : function // ignore: cast_nullable_to_non_nullable
              as FunctionCall?,
    ) as $Val);
  }

  /// Create a copy of ToolCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FunctionCallCopyWith<$Res>? get function {
    if (_value.function == null) {
      return null;
    }

    return $FunctionCallCopyWith<$Res>(_value.function!, (value) {
      return _then(_value.copyWith(function: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ToolCallImplCopyWith<$Res>
    implements $ToolCallCopyWith<$Res> {
  factory _$$ToolCallImplCopyWith(
          _$ToolCallImpl value, $Res Function(_$ToolCallImpl) then) =
      __$$ToolCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? type, FunctionCall? function});

  @override
  $FunctionCallCopyWith<$Res>? get function;
}

/// @nodoc
class __$$ToolCallImplCopyWithImpl<$Res>
    extends _$ToolCallCopyWithImpl<$Res, _$ToolCallImpl>
    implements _$$ToolCallImplCopyWith<$Res> {
  __$$ToolCallImplCopyWithImpl(
      _$ToolCallImpl _value, $Res Function(_$ToolCallImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? function = freezed,
  }) {
    return _then(_$ToolCallImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      function: freezed == function
          ? _value.function
          : function // ignore: cast_nullable_to_non_nullable
              as FunctionCall?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ToolCallImpl implements _ToolCall {
  const _$ToolCallImpl({this.id, this.type, this.function});

  factory _$ToolCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$ToolCallImplFromJson(json);

  @override
  final String? id;
  @override
  final String? type;
  @override
  final FunctionCall? function;

  @override
  String toString() {
    return 'ToolCall(id: $id, type: $type, function: $function)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolCallImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.function, function) ||
                other.function == function));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, function);

  /// Create a copy of ToolCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolCallImplCopyWith<_$ToolCallImpl> get copyWith =>
      __$$ToolCallImplCopyWithImpl<_$ToolCallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolCallImplToJson(
      this,
    );
  }
}

abstract class _ToolCall implements ToolCall {
  const factory _ToolCall(
      {final String? id,
      final String? type,
      final FunctionCall? function}) = _$ToolCallImpl;

  factory _ToolCall.fromJson(Map<String, dynamic> json) =
      _$ToolCallImpl.fromJson;

  @override
  String? get id;
  @override
  String? get type;
  @override
  FunctionCall? get function;

  /// Create a copy of ToolCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToolCallImplCopyWith<_$ToolCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FunctionCall _$FunctionCallFromJson(Map<String, dynamic> json) {
  return _FunctionCall.fromJson(json);
}

/// @nodoc
mixin _$FunctionCall {
  String get name => throw _privateConstructorUsedError;
  String get arguments => throw _privateConstructorUsedError;

  /// Serializes this FunctionCall to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FunctionCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FunctionCallCopyWith<FunctionCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunctionCallCopyWith<$Res> {
  factory $FunctionCallCopyWith(
          FunctionCall value, $Res Function(FunctionCall) then) =
      _$FunctionCallCopyWithImpl<$Res, FunctionCall>;
  @useResult
  $Res call({String name, String arguments});
}

/// @nodoc
class _$FunctionCallCopyWithImpl<$Res, $Val extends FunctionCall>
    implements $FunctionCallCopyWith<$Res> {
  _$FunctionCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FunctionCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? arguments = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      arguments: null == arguments
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FunctionCallImplCopyWith<$Res>
    implements $FunctionCallCopyWith<$Res> {
  factory _$$FunctionCallImplCopyWith(
          _$FunctionCallImpl value, $Res Function(_$FunctionCallImpl) then) =
      __$$FunctionCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String arguments});
}

/// @nodoc
class __$$FunctionCallImplCopyWithImpl<$Res>
    extends _$FunctionCallCopyWithImpl<$Res, _$FunctionCallImpl>
    implements _$$FunctionCallImplCopyWith<$Res> {
  __$$FunctionCallImplCopyWithImpl(
      _$FunctionCallImpl _value, $Res Function(_$FunctionCallImpl) _then)
      : super(_value, _then);

  /// Create a copy of FunctionCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? arguments = null,
  }) {
    return _then(_$FunctionCallImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      arguments: null == arguments
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$FunctionCallImpl implements _FunctionCall {
  const _$FunctionCallImpl({required this.name, required this.arguments});

  factory _$FunctionCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$FunctionCallImplFromJson(json);

  @override
  final String name;
  @override
  final String arguments;

  @override
  String toString() {
    return 'FunctionCall(name: $name, arguments: $arguments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FunctionCallImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arguments, arguments) ||
                other.arguments == arguments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, arguments);

  /// Create a copy of FunctionCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FunctionCallImplCopyWith<_$FunctionCallImpl> get copyWith =>
      __$$FunctionCallImplCopyWithImpl<_$FunctionCallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FunctionCallImplToJson(
      this,
    );
  }
}

abstract class _FunctionCall implements FunctionCall {
  const factory _FunctionCall(
      {required final String name,
      required final String arguments}) = _$FunctionCallImpl;

  factory _FunctionCall.fromJson(Map<String, dynamic> json) =
      _$FunctionCallImpl.fromJson;

  @override
  String get name;
  @override
  String get arguments;

  /// Create a copy of FunctionCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FunctionCallImplCopyWith<_$FunctionCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return _Error.fromJson(json);
}

/// @nodoc
mixin _$Error {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this Error to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Error
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res, Error>;
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res, $Val extends Error>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Error
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> implements $ErrorCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ErrorCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Error
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.code, required this.message});

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @override
  String toString() {
    return 'Error(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  /// Create a copy of Error
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class _Error implements Error {
  const factory _Error(
      {required final int code, required final String message}) = _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  @override
  int get code;
  @override
  String get message;

  /// Create a copy of Error
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Usage _$UsageFromJson(Map<String, dynamic> json) {
  return _Usage.fromJson(json);
}

/// @nodoc
mixin _$Usage {
  @JsonKey(name: 'prompt_tokens')
  int? get promptTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_tokens')
  int? get completionTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_tokens')
  int? get totalTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_time')
  double? get responseTime => throw _privateConstructorUsedError;

  /// Serializes this Usage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageCopyWith<Usage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageCopyWith<$Res> {
  factory $UsageCopyWith(Usage value, $Res Function(Usage) then) =
      _$UsageCopyWithImpl<$Res, Usage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'prompt_tokens') int? promptTokens,
      @JsonKey(name: 'completion_tokens') int? completionTokens,
      @JsonKey(name: 'total_tokens') int? totalTokens,
      @JsonKey(name: 'response_time') double? responseTime});
}

/// @nodoc
class _$UsageCopyWithImpl<$Res, $Val extends Usage>
    implements $UsageCopyWith<$Res> {
  _$UsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promptTokens = freezed,
    Object? completionTokens = freezed,
    Object? totalTokens = freezed,
    Object? responseTime = freezed,
  }) {
    return _then(_value.copyWith(
      promptTokens: freezed == promptTokens
          ? _value.promptTokens
          : promptTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      completionTokens: freezed == completionTokens
          ? _value.completionTokens
          : completionTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      totalTokens: freezed == totalTokens
          ? _value.totalTokens
          : totalTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsageImplCopyWith<$Res> implements $UsageCopyWith<$Res> {
  factory _$$UsageImplCopyWith(
          _$UsageImpl value, $Res Function(_$UsageImpl) then) =
      __$$UsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'prompt_tokens') int? promptTokens,
      @JsonKey(name: 'completion_tokens') int? completionTokens,
      @JsonKey(name: 'total_tokens') int? totalTokens,
      @JsonKey(name: 'response_time') double? responseTime});
}

/// @nodoc
class __$$UsageImplCopyWithImpl<$Res>
    extends _$UsageCopyWithImpl<$Res, _$UsageImpl>
    implements _$$UsageImplCopyWith<$Res> {
  __$$UsageImplCopyWithImpl(
      _$UsageImpl _value, $Res Function(_$UsageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promptTokens = freezed,
    Object? completionTokens = freezed,
    Object? totalTokens = freezed,
    Object? responseTime = freezed,
  }) {
    return _then(_$UsageImpl(
      promptTokens: freezed == promptTokens
          ? _value.promptTokens
          : promptTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      completionTokens: freezed == completionTokens
          ? _value.completionTokens
          : completionTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      totalTokens: freezed == totalTokens
          ? _value.totalTokens
          : totalTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      responseTime: freezed == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageImpl implements _Usage {
  const _$UsageImpl(
      {@JsonKey(name: 'prompt_tokens') this.promptTokens,
      @JsonKey(name: 'completion_tokens') this.completionTokens,
      @JsonKey(name: 'total_tokens') this.totalTokens,
      @JsonKey(name: 'response_time') this.responseTime});

  factory _$UsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageImplFromJson(json);

  @override
  @JsonKey(name: 'prompt_tokens')
  final int? promptTokens;
  @override
  @JsonKey(name: 'completion_tokens')
  final int? completionTokens;
  @override
  @JsonKey(name: 'total_tokens')
  final int? totalTokens;
  @override
  @JsonKey(name: 'response_time')
  final double? responseTime;

  @override
  String toString() {
    return 'Usage(promptTokens: $promptTokens, completionTokens: $completionTokens, totalTokens: $totalTokens, responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageImpl &&
            (identical(other.promptTokens, promptTokens) ||
                other.promptTokens == promptTokens) &&
            (identical(other.completionTokens, completionTokens) ||
                other.completionTokens == completionTokens) &&
            (identical(other.totalTokens, totalTokens) ||
                other.totalTokens == totalTokens) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, promptTokens, completionTokens, totalTokens, responseTime);

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageImplCopyWith<_$UsageImpl> get copyWith =>
      __$$UsageImplCopyWithImpl<_$UsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageImplToJson(
      this,
    );
  }
}

abstract class _Usage implements Usage {
  const factory _Usage(
          {@JsonKey(name: 'prompt_tokens') final int? promptTokens,
          @JsonKey(name: 'completion_tokens') final int? completionTokens,
          @JsonKey(name: 'total_tokens') final int? totalTokens,
          @JsonKey(name: 'response_time') final double? responseTime}) =
      _$UsageImpl;

  factory _Usage.fromJson(Map<String, dynamic> json) = _$UsageImpl.fromJson;

  @override
  @JsonKey(name: 'prompt_tokens')
  int? get promptTokens;
  @override
  @JsonKey(name: 'completion_tokens')
  int? get completionTokens;
  @override
  @JsonKey(name: 'total_tokens')
  int? get totalTokens;
  @override
  @JsonKey(name: 'response_time')
  double? get responseTime;

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageImplCopyWith<_$UsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ORModel _$ORModelFromJson(Map<String, dynamic> json) {
  return _ORModel.fromJson(json);
}

/// @nodoc
mixin _$ORModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Pricing? get pricing => throw _privateConstructorUsedError;
  @JsonKey(name: 'context_length')
  int? get contextLength => throw _privateConstructorUsedError;
  Architecture? get architecture => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_provider')
  TopProvider? get topProvider => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_request_limits')
  PerRequestLimits? get perRequestLimits => throw _privateConstructorUsedError;

  /// Serializes this ORModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ORModelCopyWith<ORModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ORModelCopyWith<$Res> {
  factory $ORModelCopyWith(ORModel value, $Res Function(ORModel) then) =
      _$ORModelCopyWithImpl<$Res, ORModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Pricing? pricing,
      @JsonKey(name: 'context_length') int? contextLength,
      Architecture? architecture,
      @JsonKey(name: 'top_provider') TopProvider? topProvider,
      @JsonKey(name: 'per_request_limits') PerRequestLimits? perRequestLimits});

  $PricingCopyWith<$Res>? get pricing;
  $ArchitectureCopyWith<$Res>? get architecture;
  $TopProviderCopyWith<$Res>? get topProvider;
  $PerRequestLimitsCopyWith<$Res>? get perRequestLimits;
}

/// @nodoc
class _$ORModelCopyWithImpl<$Res, $Val extends ORModel>
    implements $ORModelCopyWith<$Res> {
  _$ORModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? pricing = freezed,
    Object? contextLength = freezed,
    Object? architecture = freezed,
    Object? topProvider = freezed,
    Object? perRequestLimits = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pricing: freezed == pricing
          ? _value.pricing
          : pricing // ignore: cast_nullable_to_non_nullable
              as Pricing?,
      contextLength: freezed == contextLength
          ? _value.contextLength
          : contextLength // ignore: cast_nullable_to_non_nullable
              as int?,
      architecture: freezed == architecture
          ? _value.architecture
          : architecture // ignore: cast_nullable_to_non_nullable
              as Architecture?,
      topProvider: freezed == topProvider
          ? _value.topProvider
          : topProvider // ignore: cast_nullable_to_non_nullable
              as TopProvider?,
      perRequestLimits: freezed == perRequestLimits
          ? _value.perRequestLimits
          : perRequestLimits // ignore: cast_nullable_to_non_nullable
              as PerRequestLimits?,
    ) as $Val);
  }

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingCopyWith<$Res>? get pricing {
    if (_value.pricing == null) {
      return null;
    }

    return $PricingCopyWith<$Res>(_value.pricing!, (value) {
      return _then(_value.copyWith(pricing: value) as $Val);
    });
  }

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArchitectureCopyWith<$Res>? get architecture {
    if (_value.architecture == null) {
      return null;
    }

    return $ArchitectureCopyWith<$Res>(_value.architecture!, (value) {
      return _then(_value.copyWith(architecture: value) as $Val);
    });
  }

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TopProviderCopyWith<$Res>? get topProvider {
    if (_value.topProvider == null) {
      return null;
    }

    return $TopProviderCopyWith<$Res>(_value.topProvider!, (value) {
      return _then(_value.copyWith(topProvider: value) as $Val);
    });
  }

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PerRequestLimitsCopyWith<$Res>? get perRequestLimits {
    if (_value.perRequestLimits == null) {
      return null;
    }

    return $PerRequestLimitsCopyWith<$Res>(_value.perRequestLimits!, (value) {
      return _then(_value.copyWith(perRequestLimits: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ORModelImplCopyWith<$Res> implements $ORModelCopyWith<$Res> {
  factory _$$ORModelImplCopyWith(
          _$ORModelImpl value, $Res Function(_$ORModelImpl) then) =
      __$$ORModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Pricing? pricing,
      @JsonKey(name: 'context_length') int? contextLength,
      Architecture? architecture,
      @JsonKey(name: 'top_provider') TopProvider? topProvider,
      @JsonKey(name: 'per_request_limits') PerRequestLimits? perRequestLimits});

  @override
  $PricingCopyWith<$Res>? get pricing;
  @override
  $ArchitectureCopyWith<$Res>? get architecture;
  @override
  $TopProviderCopyWith<$Res>? get topProvider;
  @override
  $PerRequestLimitsCopyWith<$Res>? get perRequestLimits;
}

/// @nodoc
class __$$ORModelImplCopyWithImpl<$Res>
    extends _$ORModelCopyWithImpl<$Res, _$ORModelImpl>
    implements _$$ORModelImplCopyWith<$Res> {
  __$$ORModelImplCopyWithImpl(
      _$ORModelImpl _value, $Res Function(_$ORModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? pricing = freezed,
    Object? contextLength = freezed,
    Object? architecture = freezed,
    Object? topProvider = freezed,
    Object? perRequestLimits = freezed,
  }) {
    return _then(_$ORModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      pricing: freezed == pricing
          ? _value.pricing
          : pricing // ignore: cast_nullable_to_non_nullable
              as Pricing?,
      contextLength: freezed == contextLength
          ? _value.contextLength
          : contextLength // ignore: cast_nullable_to_non_nullable
              as int?,
      architecture: freezed == architecture
          ? _value.architecture
          : architecture // ignore: cast_nullable_to_non_nullable
              as Architecture?,
      topProvider: freezed == topProvider
          ? _value.topProvider
          : topProvider // ignore: cast_nullable_to_non_nullable
              as TopProvider?,
      perRequestLimits: freezed == perRequestLimits
          ? _value.perRequestLimits
          : perRequestLimits // ignore: cast_nullable_to_non_nullable
              as PerRequestLimits?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class _$ORModelImpl implements _ORModel {
  const _$ORModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.pricing,
      @JsonKey(name: 'context_length') required this.contextLength,
      required this.architecture,
      @JsonKey(name: 'top_provider') required this.topProvider,
      @JsonKey(name: 'per_request_limits') required this.perRequestLimits});

  factory _$ORModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ORModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final Pricing? pricing;
  @override
  @JsonKey(name: 'context_length')
  final int? contextLength;
  @override
  final Architecture? architecture;
  @override
  @JsonKey(name: 'top_provider')
  final TopProvider? topProvider;
  @override
  @JsonKey(name: 'per_request_limits')
  final PerRequestLimits? perRequestLimits;

  @override
  String toString() {
    return 'ORModel(id: $id, name: $name, description: $description, pricing: $pricing, contextLength: $contextLength, architecture: $architecture, topProvider: $topProvider, perRequestLimits: $perRequestLimits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ORModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pricing, pricing) || other.pricing == pricing) &&
            (identical(other.contextLength, contextLength) ||
                other.contextLength == contextLength) &&
            (identical(other.architecture, architecture) ||
                other.architecture == architecture) &&
            (identical(other.topProvider, topProvider) ||
                other.topProvider == topProvider) &&
            (identical(other.perRequestLimits, perRequestLimits) ||
                other.perRequestLimits == perRequestLimits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, pricing,
      contextLength, architecture, topProvider, perRequestLimits);

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ORModelImplCopyWith<_$ORModelImpl> get copyWith =>
      __$$ORModelImplCopyWithImpl<_$ORModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ORModelImplToJson(
      this,
    );
  }
}

abstract class _ORModel implements ORModel {
  const factory _ORModel(
      {required final String id,
      required final String name,
      required final String description,
      required final Pricing? pricing,
      @JsonKey(name: 'context_length') required final int? contextLength,
      required final Architecture? architecture,
      @JsonKey(name: 'top_provider') required final TopProvider? topProvider,
      @JsonKey(name: 'per_request_limits')
      required final PerRequestLimits? perRequestLimits}) = _$ORModelImpl;

  factory _ORModel.fromJson(Map<String, dynamic> json) = _$ORModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Pricing? get pricing;
  @override
  @JsonKey(name: 'context_length')
  int? get contextLength;
  @override
  Architecture? get architecture;
  @override
  @JsonKey(name: 'top_provider')
  TopProvider? get topProvider;
  @override
  @JsonKey(name: 'per_request_limits')
  PerRequestLimits? get perRequestLimits;

  /// Create a copy of ORModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ORModelImplCopyWith<_$ORModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pricing _$PricingFromJson(Map<String, dynamic> json) {
  return _Pricing.fromJson(json);
}

/// @nodoc
mixin _$Pricing {
  String? get prompt => throw _privateConstructorUsedError;
  String? get completion => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get request => throw _privateConstructorUsedError;

  /// Serializes this Pricing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PricingCopyWith<Pricing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingCopyWith<$Res> {
  factory $PricingCopyWith(Pricing value, $Res Function(Pricing) then) =
      _$PricingCopyWithImpl<$Res, Pricing>;
  @useResult
  $Res call(
      {String? prompt, String? completion, String? image, String? request});
}

/// @nodoc
class _$PricingCopyWithImpl<$Res, $Val extends Pricing>
    implements $PricingCopyWith<$Res> {
  _$PricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = freezed,
    Object? completion = freezed,
    Object? image = freezed,
    Object? request = freezed,
  }) {
    return _then(_value.copyWith(
      prompt: freezed == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String?,
      completion: freezed == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PricingImplCopyWith<$Res> implements $PricingCopyWith<$Res> {
  factory _$$PricingImplCopyWith(
          _$PricingImpl value, $Res Function(_$PricingImpl) then) =
      __$$PricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? prompt, String? completion, String? image, String? request});
}

/// @nodoc
class __$$PricingImplCopyWithImpl<$Res>
    extends _$PricingCopyWithImpl<$Res, _$PricingImpl>
    implements _$$PricingImplCopyWith<$Res> {
  __$$PricingImplCopyWithImpl(
      _$PricingImpl _value, $Res Function(_$PricingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = freezed,
    Object? completion = freezed,
    Object? image = freezed,
    Object? request = freezed,
  }) {
    return _then(_$PricingImpl(
      prompt: freezed == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String?,
      completion: freezed == completion
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PricingImpl implements _Pricing {
  const _$PricingImpl(
      {required this.prompt,
      required this.completion,
      required this.image,
      required this.request});

  factory _$PricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingImplFromJson(json);

  @override
  final String? prompt;
  @override
  final String? completion;
  @override
  final String? image;
  @override
  final String? request;

  @override
  String toString() {
    return 'Pricing(prompt: $prompt, completion: $completion, image: $image, request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingImpl &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.request, request) || other.request == request));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, prompt, completion, image, request);

  /// Create a copy of Pricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingImplCopyWith<_$PricingImpl> get copyWith =>
      __$$PricingImplCopyWithImpl<_$PricingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingImplToJson(
      this,
    );
  }
}

abstract class _Pricing implements Pricing {
  const factory _Pricing(
      {required final String? prompt,
      required final String? completion,
      required final String? image,
      required final String? request}) = _$PricingImpl;

  factory _Pricing.fromJson(Map<String, dynamic> json) = _$PricingImpl.fromJson;

  @override
  String? get prompt;
  @override
  String? get completion;
  @override
  String? get image;
  @override
  String? get request;

  /// Create a copy of Pricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PricingImplCopyWith<_$PricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Architecture _$ArchitectureFromJson(Map<String, dynamic> json) {
  return _Architecture.fromJson(json);
}

/// @nodoc
mixin _$Architecture {
  String? get modality => throw _privateConstructorUsedError;
  String? get tokenizer => throw _privateConstructorUsedError;
  @JsonKey(name: 'instruct_type')
  String? get instructType => throw _privateConstructorUsedError;

  /// Serializes this Architecture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Architecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArchitectureCopyWith<Architecture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArchitectureCopyWith<$Res> {
  factory $ArchitectureCopyWith(
          Architecture value, $Res Function(Architecture) then) =
      _$ArchitectureCopyWithImpl<$Res, Architecture>;
  @useResult
  $Res call(
      {String? modality,
      String? tokenizer,
      @JsonKey(name: 'instruct_type') String? instructType});
}

/// @nodoc
class _$ArchitectureCopyWithImpl<$Res, $Val extends Architecture>
    implements $ArchitectureCopyWith<$Res> {
  _$ArchitectureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Architecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modality = freezed,
    Object? tokenizer = freezed,
    Object? instructType = freezed,
  }) {
    return _then(_value.copyWith(
      modality: freezed == modality
          ? _value.modality
          : modality // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenizer: freezed == tokenizer
          ? _value.tokenizer
          : tokenizer // ignore: cast_nullable_to_non_nullable
              as String?,
      instructType: freezed == instructType
          ? _value.instructType
          : instructType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArchitectureImplCopyWith<$Res>
    implements $ArchitectureCopyWith<$Res> {
  factory _$$ArchitectureImplCopyWith(
          _$ArchitectureImpl value, $Res Function(_$ArchitectureImpl) then) =
      __$$ArchitectureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? modality,
      String? tokenizer,
      @JsonKey(name: 'instruct_type') String? instructType});
}

/// @nodoc
class __$$ArchitectureImplCopyWithImpl<$Res>
    extends _$ArchitectureCopyWithImpl<$Res, _$ArchitectureImpl>
    implements _$$ArchitectureImplCopyWith<$Res> {
  __$$ArchitectureImplCopyWithImpl(
      _$ArchitectureImpl _value, $Res Function(_$ArchitectureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Architecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modality = freezed,
    Object? tokenizer = freezed,
    Object? instructType = freezed,
  }) {
    return _then(_$ArchitectureImpl(
      modality: freezed == modality
          ? _value.modality
          : modality // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenizer: freezed == tokenizer
          ? _value.tokenizer
          : tokenizer // ignore: cast_nullable_to_non_nullable
              as String?,
      instructType: freezed == instructType
          ? _value.instructType
          : instructType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArchitectureImpl implements _Architecture {
  const _$ArchitectureImpl(
      {required this.modality,
      required this.tokenizer,
      @JsonKey(name: 'instruct_type') required this.instructType});

  factory _$ArchitectureImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArchitectureImplFromJson(json);

  @override
  final String? modality;
  @override
  final String? tokenizer;
  @override
  @JsonKey(name: 'instruct_type')
  final String? instructType;

  @override
  String toString() {
    return 'Architecture(modality: $modality, tokenizer: $tokenizer, instructType: $instructType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArchitectureImpl &&
            (identical(other.modality, modality) ||
                other.modality == modality) &&
            (identical(other.tokenizer, tokenizer) ||
                other.tokenizer == tokenizer) &&
            (identical(other.instructType, instructType) ||
                other.instructType == instructType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, modality, tokenizer, instructType);

  /// Create a copy of Architecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArchitectureImplCopyWith<_$ArchitectureImpl> get copyWith =>
      __$$ArchitectureImplCopyWithImpl<_$ArchitectureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArchitectureImplToJson(
      this,
    );
  }
}

abstract class _Architecture implements Architecture {
  const factory _Architecture(
      {required final String? modality,
      required final String? tokenizer,
      @JsonKey(name: 'instruct_type')
      required final String? instructType}) = _$ArchitectureImpl;

  factory _Architecture.fromJson(Map<String, dynamic> json) =
      _$ArchitectureImpl.fromJson;

  @override
  String? get modality;
  @override
  String? get tokenizer;
  @override
  @JsonKey(name: 'instruct_type')
  String? get instructType;

  /// Create a copy of Architecture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArchitectureImplCopyWith<_$ArchitectureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopProvider _$TopProviderFromJson(Map<String, dynamic> json) {
  return _TopProvider.fromJson(json);
}

/// @nodoc
mixin _$TopProvider {
  @JsonKey(name: 'context_length')
  int? get contextLength => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_completion_tokens')
  int? get maxCompletionTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_moderated')
  bool? get isModerated => throw _privateConstructorUsedError;

  /// Serializes this TopProvider to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopProviderCopyWith<TopProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopProviderCopyWith<$Res> {
  factory $TopProviderCopyWith(
          TopProvider value, $Res Function(TopProvider) then) =
      _$TopProviderCopyWithImpl<$Res, TopProvider>;
  @useResult
  $Res call(
      {@JsonKey(name: 'context_length') int? contextLength,
      @JsonKey(name: 'max_completion_tokens') int? maxCompletionTokens,
      @JsonKey(name: 'is_moderated') bool? isModerated});
}

/// @nodoc
class _$TopProviderCopyWithImpl<$Res, $Val extends TopProvider>
    implements $TopProviderCopyWith<$Res> {
  _$TopProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contextLength = freezed,
    Object? maxCompletionTokens = freezed,
    Object? isModerated = freezed,
  }) {
    return _then(_value.copyWith(
      contextLength: freezed == contextLength
          ? _value.contextLength
          : contextLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxCompletionTokens: freezed == maxCompletionTokens
          ? _value.maxCompletionTokens
          : maxCompletionTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      isModerated: freezed == isModerated
          ? _value.isModerated
          : isModerated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopProviderImplCopyWith<$Res>
    implements $TopProviderCopyWith<$Res> {
  factory _$$TopProviderImplCopyWith(
          _$TopProviderImpl value, $Res Function(_$TopProviderImpl) then) =
      __$$TopProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'context_length') int? contextLength,
      @JsonKey(name: 'max_completion_tokens') int? maxCompletionTokens,
      @JsonKey(name: 'is_moderated') bool? isModerated});
}

/// @nodoc
class __$$TopProviderImplCopyWithImpl<$Res>
    extends _$TopProviderCopyWithImpl<$Res, _$TopProviderImpl>
    implements _$$TopProviderImplCopyWith<$Res> {
  __$$TopProviderImplCopyWithImpl(
      _$TopProviderImpl _value, $Res Function(_$TopProviderImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contextLength = freezed,
    Object? maxCompletionTokens = freezed,
    Object? isModerated = freezed,
  }) {
    return _then(_$TopProviderImpl(
      contextLength: freezed == contextLength
          ? _value.contextLength
          : contextLength // ignore: cast_nullable_to_non_nullable
              as int?,
      maxCompletionTokens: freezed == maxCompletionTokens
          ? _value.maxCompletionTokens
          : maxCompletionTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      isModerated: freezed == isModerated
          ? _value.isModerated
          : isModerated // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopProviderImpl implements _TopProvider {
  const _$TopProviderImpl(
      {@JsonKey(name: 'context_length') required this.contextLength,
      @JsonKey(name: 'max_completion_tokens') required this.maxCompletionTokens,
      @JsonKey(name: 'is_moderated') required this.isModerated});

  factory _$TopProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopProviderImplFromJson(json);

  @override
  @JsonKey(name: 'context_length')
  final int? contextLength;
  @override
  @JsonKey(name: 'max_completion_tokens')
  final int? maxCompletionTokens;
  @override
  @JsonKey(name: 'is_moderated')
  final bool? isModerated;

  @override
  String toString() {
    return 'TopProvider(contextLength: $contextLength, maxCompletionTokens: $maxCompletionTokens, isModerated: $isModerated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopProviderImpl &&
            (identical(other.contextLength, contextLength) ||
                other.contextLength == contextLength) &&
            (identical(other.maxCompletionTokens, maxCompletionTokens) ||
                other.maxCompletionTokens == maxCompletionTokens) &&
            (identical(other.isModerated, isModerated) ||
                other.isModerated == isModerated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, contextLength, maxCompletionTokens, isModerated);

  /// Create a copy of TopProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopProviderImplCopyWith<_$TopProviderImpl> get copyWith =>
      __$$TopProviderImplCopyWithImpl<_$TopProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopProviderImplToJson(
      this,
    );
  }
}

abstract class _TopProvider implements TopProvider {
  const factory _TopProvider(
          {@JsonKey(name: 'context_length') required final int? contextLength,
          @JsonKey(name: 'max_completion_tokens')
          required final int? maxCompletionTokens,
          @JsonKey(name: 'is_moderated') required final bool? isModerated}) =
      _$TopProviderImpl;

  factory _TopProvider.fromJson(Map<String, dynamic> json) =
      _$TopProviderImpl.fromJson;

  @override
  @JsonKey(name: 'context_length')
  int? get contextLength;
  @override
  @JsonKey(name: 'max_completion_tokens')
  int? get maxCompletionTokens;
  @override
  @JsonKey(name: 'is_moderated')
  bool? get isModerated;

  /// Create a copy of TopProvider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopProviderImplCopyWith<_$TopProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerRequestLimits _$PerRequestLimitsFromJson(Map<String, dynamic> json) {
  return _PerRequestLimits.fromJson(json);
}

/// @nodoc
mixin _$PerRequestLimits {
  @JsonKey(name: 'prompt_tokens')
  String? get promptTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_tokens')
  String? get completionTokens => throw _privateConstructorUsedError;

  /// Serializes this PerRequestLimits to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PerRequestLimits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PerRequestLimitsCopyWith<PerRequestLimits> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerRequestLimitsCopyWith<$Res> {
  factory $PerRequestLimitsCopyWith(
          PerRequestLimits value, $Res Function(PerRequestLimits) then) =
      _$PerRequestLimitsCopyWithImpl<$Res, PerRequestLimits>;
  @useResult
  $Res call(
      {@JsonKey(name: 'prompt_tokens') String? promptTokens,
      @JsonKey(name: 'completion_tokens') String? completionTokens});
}

/// @nodoc
class _$PerRequestLimitsCopyWithImpl<$Res, $Val extends PerRequestLimits>
    implements $PerRequestLimitsCopyWith<$Res> {
  _$PerRequestLimitsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PerRequestLimits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promptTokens = freezed,
    Object? completionTokens = freezed,
  }) {
    return _then(_value.copyWith(
      promptTokens: freezed == promptTokens
          ? _value.promptTokens
          : promptTokens // ignore: cast_nullable_to_non_nullable
              as String?,
      completionTokens: freezed == completionTokens
          ? _value.completionTokens
          : completionTokens // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerRequestLimitsImplCopyWith<$Res>
    implements $PerRequestLimitsCopyWith<$Res> {
  factory _$$PerRequestLimitsImplCopyWith(_$PerRequestLimitsImpl value,
          $Res Function(_$PerRequestLimitsImpl) then) =
      __$$PerRequestLimitsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'prompt_tokens') String? promptTokens,
      @JsonKey(name: 'completion_tokens') String? completionTokens});
}

/// @nodoc
class __$$PerRequestLimitsImplCopyWithImpl<$Res>
    extends _$PerRequestLimitsCopyWithImpl<$Res, _$PerRequestLimitsImpl>
    implements _$$PerRequestLimitsImplCopyWith<$Res> {
  __$$PerRequestLimitsImplCopyWithImpl(_$PerRequestLimitsImpl _value,
      $Res Function(_$PerRequestLimitsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PerRequestLimits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promptTokens = freezed,
    Object? completionTokens = freezed,
  }) {
    return _then(_$PerRequestLimitsImpl(
      promptTokens: freezed == promptTokens
          ? _value.promptTokens
          : promptTokens // ignore: cast_nullable_to_non_nullable
              as String?,
      completionTokens: freezed == completionTokens
          ? _value.completionTokens
          : completionTokens // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerRequestLimitsImpl implements _PerRequestLimits {
  const _$PerRequestLimitsImpl(
      {@JsonKey(name: 'prompt_tokens') required this.promptTokens,
      @JsonKey(name: 'completion_tokens') required this.completionTokens});

  factory _$PerRequestLimitsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerRequestLimitsImplFromJson(json);

  @override
  @JsonKey(name: 'prompt_tokens')
  final String? promptTokens;
  @override
  @JsonKey(name: 'completion_tokens')
  final String? completionTokens;

  @override
  String toString() {
    return 'PerRequestLimits(promptTokens: $promptTokens, completionTokens: $completionTokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerRequestLimitsImpl &&
            (identical(other.promptTokens, promptTokens) ||
                other.promptTokens == promptTokens) &&
            (identical(other.completionTokens, completionTokens) ||
                other.completionTokens == completionTokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, promptTokens, completionTokens);

  /// Create a copy of PerRequestLimits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerRequestLimitsImplCopyWith<_$PerRequestLimitsImpl> get copyWith =>
      __$$PerRequestLimitsImplCopyWithImpl<_$PerRequestLimitsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerRequestLimitsImplToJson(
      this,
    );
  }
}

abstract class _PerRequestLimits implements PerRequestLimits {
  const factory _PerRequestLimits(
      {@JsonKey(name: 'prompt_tokens') required final String? promptTokens,
      @JsonKey(name: 'completion_tokens')
      required final String? completionTokens}) = _$PerRequestLimitsImpl;

  factory _PerRequestLimits.fromJson(Map<String, dynamic> json) =
      _$PerRequestLimitsImpl.fromJson;

  @override
  @JsonKey(name: 'prompt_tokens')
  String? get promptTokens;
  @override
  @JsonKey(name: 'completion_tokens')
  String? get completionTokens;

  /// Create a copy of PerRequestLimits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerRequestLimitsImplCopyWith<_$PerRequestLimitsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ORCredit _$ORCreditFromJson(Map<String, dynamic> json) {
  return _ORCredit.fromJson(json);
}

/// @nodoc
mixin _$ORCredit {
  @JsonKey(name: 'label')
  String? get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'limit')
  int? get limit => throw _privateConstructorUsedError;
  @JsonKey(name: 'usage')
  double? get usage => throw _privateConstructorUsedError;
  @JsonKey(name: 'limit_remaining')
  int? get limitRemaining => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_free_tier')
  bool? get isFreeTier => throw _privateConstructorUsedError;
  @JsonKey(name: 'rate_limit')
  RateLimit? get rateLimit => throw _privateConstructorUsedError;

  /// Serializes this ORCredit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ORCredit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ORCreditCopyWith<ORCredit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ORCreditCopyWith<$Res> {
  factory $ORCreditCopyWith(ORCredit value, $Res Function(ORCredit) then) =
      _$ORCreditCopyWithImpl<$Res, ORCredit>;
  @useResult
  $Res call(
      {@JsonKey(name: 'label') String? label,
      @JsonKey(name: 'limit') int? limit,
      @JsonKey(name: 'usage') double? usage,
      @JsonKey(name: 'limit_remaining') int? limitRemaining,
      @JsonKey(name: 'is_free_tier') bool? isFreeTier,
      @JsonKey(name: 'rate_limit') RateLimit? rateLimit});

  $RateLimitCopyWith<$Res>? get rateLimit;
}

/// @nodoc
class _$ORCreditCopyWithImpl<$Res, $Val extends ORCredit>
    implements $ORCreditCopyWith<$Res> {
  _$ORCreditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ORCredit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = freezed,
    Object? limit = freezed,
    Object? usage = freezed,
    Object? limitRemaining = freezed,
    Object? isFreeTier = freezed,
    Object? rateLimit = freezed,
  }) {
    return _then(_value.copyWith(
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as double?,
      limitRemaining: freezed == limitRemaining
          ? _value.limitRemaining
          : limitRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
      isFreeTier: freezed == isFreeTier
          ? _value.isFreeTier
          : isFreeTier // ignore: cast_nullable_to_non_nullable
              as bool?,
      rateLimit: freezed == rateLimit
          ? _value.rateLimit
          : rateLimit // ignore: cast_nullable_to_non_nullable
              as RateLimit?,
    ) as $Val);
  }

  /// Create a copy of ORCredit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RateLimitCopyWith<$Res>? get rateLimit {
    if (_value.rateLimit == null) {
      return null;
    }

    return $RateLimitCopyWith<$Res>(_value.rateLimit!, (value) {
      return _then(_value.copyWith(rateLimit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ORCreditImplCopyWith<$Res>
    implements $ORCreditCopyWith<$Res> {
  factory _$$ORCreditImplCopyWith(
          _$ORCreditImpl value, $Res Function(_$ORCreditImpl) then) =
      __$$ORCreditImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'label') String? label,
      @JsonKey(name: 'limit') int? limit,
      @JsonKey(name: 'usage') double? usage,
      @JsonKey(name: 'limit_remaining') int? limitRemaining,
      @JsonKey(name: 'is_free_tier') bool? isFreeTier,
      @JsonKey(name: 'rate_limit') RateLimit? rateLimit});

  @override
  $RateLimitCopyWith<$Res>? get rateLimit;
}

/// @nodoc
class __$$ORCreditImplCopyWithImpl<$Res>
    extends _$ORCreditCopyWithImpl<$Res, _$ORCreditImpl>
    implements _$$ORCreditImplCopyWith<$Res> {
  __$$ORCreditImplCopyWithImpl(
      _$ORCreditImpl _value, $Res Function(_$ORCreditImpl) _then)
      : super(_value, _then);

  /// Create a copy of ORCredit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = freezed,
    Object? limit = freezed,
    Object? usage = freezed,
    Object? limitRemaining = freezed,
    Object? isFreeTier = freezed,
    Object? rateLimit = freezed,
  }) {
    return _then(_$ORCreditImpl(
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as double?,
      limitRemaining: freezed == limitRemaining
          ? _value.limitRemaining
          : limitRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
      isFreeTier: freezed == isFreeTier
          ? _value.isFreeTier
          : isFreeTier // ignore: cast_nullable_to_non_nullable
              as bool?,
      rateLimit: freezed == rateLimit
          ? _value.rateLimit
          : rateLimit // ignore: cast_nullable_to_non_nullable
              as RateLimit?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ORCreditImpl implements _ORCredit {
  const _$ORCreditImpl(
      {@JsonKey(name: 'label') this.label,
      @JsonKey(name: 'limit') this.limit,
      @JsonKey(name: 'usage') this.usage,
      @JsonKey(name: 'limit_remaining') this.limitRemaining,
      @JsonKey(name: 'is_free_tier') this.isFreeTier,
      @JsonKey(name: 'rate_limit') this.rateLimit});

  factory _$ORCreditImpl.fromJson(Map<String, dynamic> json) =>
      _$$ORCreditImplFromJson(json);

  @override
  @JsonKey(name: 'label')
  final String? label;
  @override
  @JsonKey(name: 'limit')
  final int? limit;
  @override
  @JsonKey(name: 'usage')
  final double? usage;
  @override
  @JsonKey(name: 'limit_remaining')
  final int? limitRemaining;
  @override
  @JsonKey(name: 'is_free_tier')
  final bool? isFreeTier;
  @override
  @JsonKey(name: 'rate_limit')
  final RateLimit? rateLimit;

  @override
  String toString() {
    return 'ORCredit(label: $label, limit: $limit, usage: $usage, limitRemaining: $limitRemaining, isFreeTier: $isFreeTier, rateLimit: $rateLimit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ORCreditImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.limitRemaining, limitRemaining) ||
                other.limitRemaining == limitRemaining) &&
            (identical(other.isFreeTier, isFreeTier) ||
                other.isFreeTier == isFreeTier) &&
            (identical(other.rateLimit, rateLimit) ||
                other.rateLimit == rateLimit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, label, limit, usage, limitRemaining, isFreeTier, rateLimit);

  /// Create a copy of ORCredit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ORCreditImplCopyWith<_$ORCreditImpl> get copyWith =>
      __$$ORCreditImplCopyWithImpl<_$ORCreditImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ORCreditImplToJson(
      this,
    );
  }
}

abstract class _ORCredit implements ORCredit {
  const factory _ORCredit(
          {@JsonKey(name: 'label') final String? label,
          @JsonKey(name: 'limit') final int? limit,
          @JsonKey(name: 'usage') final double? usage,
          @JsonKey(name: 'limit_remaining') final int? limitRemaining,
          @JsonKey(name: 'is_free_tier') final bool? isFreeTier,
          @JsonKey(name: 'rate_limit') final RateLimit? rateLimit}) =
      _$ORCreditImpl;

  factory _ORCredit.fromJson(Map<String, dynamic> json) =
      _$ORCreditImpl.fromJson;

  @override
  @JsonKey(name: 'label')
  String? get label;
  @override
  @JsonKey(name: 'limit')
  int? get limit;
  @override
  @JsonKey(name: 'usage')
  double? get usage;
  @override
  @JsonKey(name: 'limit_remaining')
  int? get limitRemaining;
  @override
  @JsonKey(name: 'is_free_tier')
  bool? get isFreeTier;
  @override
  @JsonKey(name: 'rate_limit')
  RateLimit? get rateLimit;

  /// Create a copy of ORCredit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ORCreditImplCopyWith<_$ORCreditImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RateLimit _$RateLimitFromJson(Map<String, dynamic> json) {
  return _RateLimit.fromJson(json);
}

/// @nodoc
mixin _$RateLimit {
  @JsonKey(name: 'requests')
  int? get requests => throw _privateConstructorUsedError;
  @JsonKey(name: 'interval')
  String? get interval => throw _privateConstructorUsedError;

  /// Serializes this RateLimit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RateLimit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RateLimitCopyWith<RateLimit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RateLimitCopyWith<$Res> {
  factory $RateLimitCopyWith(RateLimit value, $Res Function(RateLimit) then) =
      _$RateLimitCopyWithImpl<$Res, RateLimit>;
  @useResult
  $Res call(
      {@JsonKey(name: 'requests') int? requests,
      @JsonKey(name: 'interval') String? interval});
}

/// @nodoc
class _$RateLimitCopyWithImpl<$Res, $Val extends RateLimit>
    implements $RateLimitCopyWith<$Res> {
  _$RateLimitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RateLimit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = freezed,
    Object? interval = freezed,
  }) {
    return _then(_value.copyWith(
      requests: freezed == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as int?,
      interval: freezed == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RateLimitImplCopyWith<$Res>
    implements $RateLimitCopyWith<$Res> {
  factory _$$RateLimitImplCopyWith(
          _$RateLimitImpl value, $Res Function(_$RateLimitImpl) then) =
      __$$RateLimitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'requests') int? requests,
      @JsonKey(name: 'interval') String? interval});
}

/// @nodoc
class __$$RateLimitImplCopyWithImpl<$Res>
    extends _$RateLimitCopyWithImpl<$Res, _$RateLimitImpl>
    implements _$$RateLimitImplCopyWith<$Res> {
  __$$RateLimitImplCopyWithImpl(
      _$RateLimitImpl _value, $Res Function(_$RateLimitImpl) _then)
      : super(_value, _then);

  /// Create a copy of RateLimit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = freezed,
    Object? interval = freezed,
  }) {
    return _then(_$RateLimitImpl(
      requests: freezed == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as int?,
      interval: freezed == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RateLimitImpl implements _RateLimit {
  const _$RateLimitImpl(
      {@JsonKey(name: 'requests') this.requests,
      @JsonKey(name: 'interval') this.interval});

  factory _$RateLimitImpl.fromJson(Map<String, dynamic> json) =>
      _$$RateLimitImplFromJson(json);

  @override
  @JsonKey(name: 'requests')
  final int? requests;
  @override
  @JsonKey(name: 'interval')
  final String? interval;

  @override
  String toString() {
    return 'RateLimit(requests: $requests, interval: $interval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateLimitImpl &&
            (identical(other.requests, requests) ||
                other.requests == requests) &&
            (identical(other.interval, interval) ||
                other.interval == interval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, requests, interval);

  /// Create a copy of RateLimit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RateLimitImplCopyWith<_$RateLimitImpl> get copyWith =>
      __$$RateLimitImplCopyWithImpl<_$RateLimitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RateLimitImplToJson(
      this,
    );
  }
}

abstract class _RateLimit implements RateLimit {
  const factory _RateLimit(
      {@JsonKey(name: 'requests') final int? requests,
      @JsonKey(name: 'interval') final String? interval}) = _$RateLimitImpl;

  factory _RateLimit.fromJson(Map<String, dynamic> json) =
      _$RateLimitImpl.fromJson;

  @override
  @JsonKey(name: 'requests')
  int? get requests;
  @override
  @JsonKey(name: 'interval')
  String? get interval;

  /// Create a copy of RateLimit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RateLimitImplCopyWith<_$RateLimitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParameterInfo _$ParameterInfoFromJson(Map<String, dynamic> json) {
  return _ParameterInfo.fromJson(json);
}

/// @nodoc
mixin _$ParameterInfo {
  @JsonKey(name: 'model')
  String? get model => throw _privateConstructorUsedError;
  @JsonKey(name: 'supported_parameters')
  List<String>? get supportedParameters => throw _privateConstructorUsedError;
  @JsonKey(name: 'frequency_penalty_p10')
  int? get frequencyPenaltyP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'frequency_penalty_p50')
  int? get frequencyPenaltyP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'frequency_penalty_p90')
  double? get frequencyPenaltyP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_p_p10')
  int? get minPP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_p_p50')
  int? get minPP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_p_p90')
  int? get minPP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'presence_penalty_p10')
  int? get presencePenaltyP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'presence_penalty_p50')
  int? get presencePenaltyP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'presence_penalty_p90')
  double? get presencePenaltyP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'repetition_penalty_p10')
  int? get repetitionPenaltyP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'repetition_penalty_p50')
  int? get repetitionPenaltyP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'repetition_penalty_p90')
  int? get repetitionPenaltyP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'temperature_p10')
  int? get temperatureP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'temperature_p50')
  double? get temperatureP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'temperature_p90')
  int? get temperatureP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_a_p10')
  int? get topAP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_a_p50')
  int? get topAP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_a_p90')
  int? get topAP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_k_p10')
  int? get topKP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_k_p50')
  int? get topKP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_k_p90')
  int? get topKP90 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_p_p10')
  int? get topPP10 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_p_p50')
  int? get topPP50 => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_p_p90')
  int? get topPP90 => throw _privateConstructorUsedError;

  /// Serializes this ParameterInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParameterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParameterInfoCopyWith<ParameterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParameterInfoCopyWith<$Res> {
  factory $ParameterInfoCopyWith(
          ParameterInfo value, $Res Function(ParameterInfo) then) =
      _$ParameterInfoCopyWithImpl<$Res, ParameterInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'model') String? model,
      @JsonKey(name: 'supported_parameters') List<String>? supportedParameters,
      @JsonKey(name: 'frequency_penalty_p10') int? frequencyPenaltyP10,
      @JsonKey(name: 'frequency_penalty_p50') int? frequencyPenaltyP50,
      @JsonKey(name: 'frequency_penalty_p90') double? frequencyPenaltyP90,
      @JsonKey(name: 'min_p_p10') int? minPP10,
      @JsonKey(name: 'min_p_p50') int? minPP50,
      @JsonKey(name: 'min_p_p90') int? minPP90,
      @JsonKey(name: 'presence_penalty_p10') int? presencePenaltyP10,
      @JsonKey(name: 'presence_penalty_p50') int? presencePenaltyP50,
      @JsonKey(name: 'presence_penalty_p90') double? presencePenaltyP90,
      @JsonKey(name: 'repetition_penalty_p10') int? repetitionPenaltyP10,
      @JsonKey(name: 'repetition_penalty_p50') int? repetitionPenaltyP50,
      @JsonKey(name: 'repetition_penalty_p90') int? repetitionPenaltyP90,
      @JsonKey(name: 'temperature_p10') int? temperatureP10,
      @JsonKey(name: 'temperature_p50') double? temperatureP50,
      @JsonKey(name: 'temperature_p90') int? temperatureP90,
      @JsonKey(name: 'top_a_p10') int? topAP10,
      @JsonKey(name: 'top_a_p50') int? topAP50,
      @JsonKey(name: 'top_a_p90') int? topAP90,
      @JsonKey(name: 'top_k_p10') int? topKP10,
      @JsonKey(name: 'top_k_p50') int? topKP50,
      @JsonKey(name: 'top_k_p90') int? topKP90,
      @JsonKey(name: 'top_p_p10') int? topPP10,
      @JsonKey(name: 'top_p_p50') int? topPP50,
      @JsonKey(name: 'top_p_p90') int? topPP90});
}

/// @nodoc
class _$ParameterInfoCopyWithImpl<$Res, $Val extends ParameterInfo>
    implements $ParameterInfoCopyWith<$Res> {
  _$ParameterInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParameterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = freezed,
    Object? supportedParameters = freezed,
    Object? frequencyPenaltyP10 = freezed,
    Object? frequencyPenaltyP50 = freezed,
    Object? frequencyPenaltyP90 = freezed,
    Object? minPP10 = freezed,
    Object? minPP50 = freezed,
    Object? minPP90 = freezed,
    Object? presencePenaltyP10 = freezed,
    Object? presencePenaltyP50 = freezed,
    Object? presencePenaltyP90 = freezed,
    Object? repetitionPenaltyP10 = freezed,
    Object? repetitionPenaltyP50 = freezed,
    Object? repetitionPenaltyP90 = freezed,
    Object? temperatureP10 = freezed,
    Object? temperatureP50 = freezed,
    Object? temperatureP90 = freezed,
    Object? topAP10 = freezed,
    Object? topAP50 = freezed,
    Object? topAP90 = freezed,
    Object? topKP10 = freezed,
    Object? topKP50 = freezed,
    Object? topKP90 = freezed,
    Object? topPP10 = freezed,
    Object? topPP50 = freezed,
    Object? topPP90 = freezed,
  }) {
    return _then(_value.copyWith(
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      supportedParameters: freezed == supportedParameters
          ? _value.supportedParameters
          : supportedParameters // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      frequencyPenaltyP10: freezed == frequencyPenaltyP10
          ? _value.frequencyPenaltyP10
          : frequencyPenaltyP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyPenaltyP50: freezed == frequencyPenaltyP50
          ? _value.frequencyPenaltyP50
          : frequencyPenaltyP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyPenaltyP90: freezed == frequencyPenaltyP90
          ? _value.frequencyPenaltyP90
          : frequencyPenaltyP90 // ignore: cast_nullable_to_non_nullable
              as double?,
      minPP10: freezed == minPP10
          ? _value.minPP10
          : minPP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      minPP50: freezed == minPP50
          ? _value.minPP50
          : minPP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      minPP90: freezed == minPP90
          ? _value.minPP90
          : minPP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      presencePenaltyP10: freezed == presencePenaltyP10
          ? _value.presencePenaltyP10
          : presencePenaltyP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      presencePenaltyP50: freezed == presencePenaltyP50
          ? _value.presencePenaltyP50
          : presencePenaltyP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      presencePenaltyP90: freezed == presencePenaltyP90
          ? _value.presencePenaltyP90
          : presencePenaltyP90 // ignore: cast_nullable_to_non_nullable
              as double?,
      repetitionPenaltyP10: freezed == repetitionPenaltyP10
          ? _value.repetitionPenaltyP10
          : repetitionPenaltyP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionPenaltyP50: freezed == repetitionPenaltyP50
          ? _value.repetitionPenaltyP50
          : repetitionPenaltyP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionPenaltyP90: freezed == repetitionPenaltyP90
          ? _value.repetitionPenaltyP90
          : repetitionPenaltyP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      temperatureP10: freezed == temperatureP10
          ? _value.temperatureP10
          : temperatureP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      temperatureP50: freezed == temperatureP50
          ? _value.temperatureP50
          : temperatureP50 // ignore: cast_nullable_to_non_nullable
              as double?,
      temperatureP90: freezed == temperatureP90
          ? _value.temperatureP90
          : temperatureP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      topAP10: freezed == topAP10
          ? _value.topAP10
          : topAP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      topAP50: freezed == topAP50
          ? _value.topAP50
          : topAP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      topAP90: freezed == topAP90
          ? _value.topAP90
          : topAP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      topKP10: freezed == topKP10
          ? _value.topKP10
          : topKP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      topKP50: freezed == topKP50
          ? _value.topKP50
          : topKP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      topKP90: freezed == topKP90
          ? _value.topKP90
          : topKP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      topPP10: freezed == topPP10
          ? _value.topPP10
          : topPP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      topPP50: freezed == topPP50
          ? _value.topPP50
          : topPP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      topPP90: freezed == topPP90
          ? _value.topPP90
          : topPP90 // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParameterInfoImplCopyWith<$Res>
    implements $ParameterInfoCopyWith<$Res> {
  factory _$$ParameterInfoImplCopyWith(
          _$ParameterInfoImpl value, $Res Function(_$ParameterInfoImpl) then) =
      __$$ParameterInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'model') String? model,
      @JsonKey(name: 'supported_parameters') List<String>? supportedParameters,
      @JsonKey(name: 'frequency_penalty_p10') int? frequencyPenaltyP10,
      @JsonKey(name: 'frequency_penalty_p50') int? frequencyPenaltyP50,
      @JsonKey(name: 'frequency_penalty_p90') double? frequencyPenaltyP90,
      @JsonKey(name: 'min_p_p10') int? minPP10,
      @JsonKey(name: 'min_p_p50') int? minPP50,
      @JsonKey(name: 'min_p_p90') int? minPP90,
      @JsonKey(name: 'presence_penalty_p10') int? presencePenaltyP10,
      @JsonKey(name: 'presence_penalty_p50') int? presencePenaltyP50,
      @JsonKey(name: 'presence_penalty_p90') double? presencePenaltyP90,
      @JsonKey(name: 'repetition_penalty_p10') int? repetitionPenaltyP10,
      @JsonKey(name: 'repetition_penalty_p50') int? repetitionPenaltyP50,
      @JsonKey(name: 'repetition_penalty_p90') int? repetitionPenaltyP90,
      @JsonKey(name: 'temperature_p10') int? temperatureP10,
      @JsonKey(name: 'temperature_p50') double? temperatureP50,
      @JsonKey(name: 'temperature_p90') int? temperatureP90,
      @JsonKey(name: 'top_a_p10') int? topAP10,
      @JsonKey(name: 'top_a_p50') int? topAP50,
      @JsonKey(name: 'top_a_p90') int? topAP90,
      @JsonKey(name: 'top_k_p10') int? topKP10,
      @JsonKey(name: 'top_k_p50') int? topKP50,
      @JsonKey(name: 'top_k_p90') int? topKP90,
      @JsonKey(name: 'top_p_p10') int? topPP10,
      @JsonKey(name: 'top_p_p50') int? topPP50,
      @JsonKey(name: 'top_p_p90') int? topPP90});
}

/// @nodoc
class __$$ParameterInfoImplCopyWithImpl<$Res>
    extends _$ParameterInfoCopyWithImpl<$Res, _$ParameterInfoImpl>
    implements _$$ParameterInfoImplCopyWith<$Res> {
  __$$ParameterInfoImplCopyWithImpl(
      _$ParameterInfoImpl _value, $Res Function(_$ParameterInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParameterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = freezed,
    Object? supportedParameters = freezed,
    Object? frequencyPenaltyP10 = freezed,
    Object? frequencyPenaltyP50 = freezed,
    Object? frequencyPenaltyP90 = freezed,
    Object? minPP10 = freezed,
    Object? minPP50 = freezed,
    Object? minPP90 = freezed,
    Object? presencePenaltyP10 = freezed,
    Object? presencePenaltyP50 = freezed,
    Object? presencePenaltyP90 = freezed,
    Object? repetitionPenaltyP10 = freezed,
    Object? repetitionPenaltyP50 = freezed,
    Object? repetitionPenaltyP90 = freezed,
    Object? temperatureP10 = freezed,
    Object? temperatureP50 = freezed,
    Object? temperatureP90 = freezed,
    Object? topAP10 = freezed,
    Object? topAP50 = freezed,
    Object? topAP90 = freezed,
    Object? topKP10 = freezed,
    Object? topKP50 = freezed,
    Object? topKP90 = freezed,
    Object? topPP10 = freezed,
    Object? topPP50 = freezed,
    Object? topPP90 = freezed,
  }) {
    return _then(_$ParameterInfoImpl(
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      supportedParameters: freezed == supportedParameters
          ? _value._supportedParameters
          : supportedParameters // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      frequencyPenaltyP10: freezed == frequencyPenaltyP10
          ? _value.frequencyPenaltyP10
          : frequencyPenaltyP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyPenaltyP50: freezed == frequencyPenaltyP50
          ? _value.frequencyPenaltyP50
          : frequencyPenaltyP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyPenaltyP90: freezed == frequencyPenaltyP90
          ? _value.frequencyPenaltyP90
          : frequencyPenaltyP90 // ignore: cast_nullable_to_non_nullable
              as double?,
      minPP10: freezed == minPP10
          ? _value.minPP10
          : minPP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      minPP50: freezed == minPP50
          ? _value.minPP50
          : minPP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      minPP90: freezed == minPP90
          ? _value.minPP90
          : minPP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      presencePenaltyP10: freezed == presencePenaltyP10
          ? _value.presencePenaltyP10
          : presencePenaltyP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      presencePenaltyP50: freezed == presencePenaltyP50
          ? _value.presencePenaltyP50
          : presencePenaltyP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      presencePenaltyP90: freezed == presencePenaltyP90
          ? _value.presencePenaltyP90
          : presencePenaltyP90 // ignore: cast_nullable_to_non_nullable
              as double?,
      repetitionPenaltyP10: freezed == repetitionPenaltyP10
          ? _value.repetitionPenaltyP10
          : repetitionPenaltyP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionPenaltyP50: freezed == repetitionPenaltyP50
          ? _value.repetitionPenaltyP50
          : repetitionPenaltyP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionPenaltyP90: freezed == repetitionPenaltyP90
          ? _value.repetitionPenaltyP90
          : repetitionPenaltyP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      temperatureP10: freezed == temperatureP10
          ? _value.temperatureP10
          : temperatureP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      temperatureP50: freezed == temperatureP50
          ? _value.temperatureP50
          : temperatureP50 // ignore: cast_nullable_to_non_nullable
              as double?,
      temperatureP90: freezed == temperatureP90
          ? _value.temperatureP90
          : temperatureP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      topAP10: freezed == topAP10
          ? _value.topAP10
          : topAP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      topAP50: freezed == topAP50
          ? _value.topAP50
          : topAP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      topAP90: freezed == topAP90
          ? _value.topAP90
          : topAP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      topKP10: freezed == topKP10
          ? _value.topKP10
          : topKP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      topKP50: freezed == topKP50
          ? _value.topKP50
          : topKP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      topKP90: freezed == topKP90
          ? _value.topKP90
          : topKP90 // ignore: cast_nullable_to_non_nullable
              as int?,
      topPP10: freezed == topPP10
          ? _value.topPP10
          : topPP10 // ignore: cast_nullable_to_non_nullable
              as int?,
      topPP50: freezed == topPP50
          ? _value.topPP50
          : topPP50 // ignore: cast_nullable_to_non_nullable
              as int?,
      topPP90: freezed == topPP90
          ? _value.topPP90
          : topPP90 // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParameterInfoImpl implements _ParameterInfo {
  const _$ParameterInfoImpl(
      {@JsonKey(name: 'model') this.model,
      @JsonKey(name: 'supported_parameters')
      final List<String>? supportedParameters,
      @JsonKey(name: 'frequency_penalty_p10') this.frequencyPenaltyP10,
      @JsonKey(name: 'frequency_penalty_p50') this.frequencyPenaltyP50,
      @JsonKey(name: 'frequency_penalty_p90') this.frequencyPenaltyP90,
      @JsonKey(name: 'min_p_p10') this.minPP10,
      @JsonKey(name: 'min_p_p50') this.minPP50,
      @JsonKey(name: 'min_p_p90') this.minPP90,
      @JsonKey(name: 'presence_penalty_p10') this.presencePenaltyP10,
      @JsonKey(name: 'presence_penalty_p50') this.presencePenaltyP50,
      @JsonKey(name: 'presence_penalty_p90') this.presencePenaltyP90,
      @JsonKey(name: 'repetition_penalty_p10') this.repetitionPenaltyP10,
      @JsonKey(name: 'repetition_penalty_p50') this.repetitionPenaltyP50,
      @JsonKey(name: 'repetition_penalty_p90') this.repetitionPenaltyP90,
      @JsonKey(name: 'temperature_p10') this.temperatureP10,
      @JsonKey(name: 'temperature_p50') this.temperatureP50,
      @JsonKey(name: 'temperature_p90') this.temperatureP90,
      @JsonKey(name: 'top_a_p10') this.topAP10,
      @JsonKey(name: 'top_a_p50') this.topAP50,
      @JsonKey(name: 'top_a_p90') this.topAP90,
      @JsonKey(name: 'top_k_p10') this.topKP10,
      @JsonKey(name: 'top_k_p50') this.topKP50,
      @JsonKey(name: 'top_k_p90') this.topKP90,
      @JsonKey(name: 'top_p_p10') this.topPP10,
      @JsonKey(name: 'top_p_p50') this.topPP50,
      @JsonKey(name: 'top_p_p90') this.topPP90})
      : _supportedParameters = supportedParameters;

  factory _$ParameterInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParameterInfoImplFromJson(json);

  @override
  @JsonKey(name: 'model')
  final String? model;
  final List<String>? _supportedParameters;
  @override
  @JsonKey(name: 'supported_parameters')
  List<String>? get supportedParameters {
    final value = _supportedParameters;
    if (value == null) return null;
    if (_supportedParameters is EqualUnmodifiableListView)
      return _supportedParameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'frequency_penalty_p10')
  final int? frequencyPenaltyP10;
  @override
  @JsonKey(name: 'frequency_penalty_p50')
  final int? frequencyPenaltyP50;
  @override
  @JsonKey(name: 'frequency_penalty_p90')
  final double? frequencyPenaltyP90;
  @override
  @JsonKey(name: 'min_p_p10')
  final int? minPP10;
  @override
  @JsonKey(name: 'min_p_p50')
  final int? minPP50;
  @override
  @JsonKey(name: 'min_p_p90')
  final int? minPP90;
  @override
  @JsonKey(name: 'presence_penalty_p10')
  final int? presencePenaltyP10;
  @override
  @JsonKey(name: 'presence_penalty_p50')
  final int? presencePenaltyP50;
  @override
  @JsonKey(name: 'presence_penalty_p90')
  final double? presencePenaltyP90;
  @override
  @JsonKey(name: 'repetition_penalty_p10')
  final int? repetitionPenaltyP10;
  @override
  @JsonKey(name: 'repetition_penalty_p50')
  final int? repetitionPenaltyP50;
  @override
  @JsonKey(name: 'repetition_penalty_p90')
  final int? repetitionPenaltyP90;
  @override
  @JsonKey(name: 'temperature_p10')
  final int? temperatureP10;
  @override
  @JsonKey(name: 'temperature_p50')
  final double? temperatureP50;
  @override
  @JsonKey(name: 'temperature_p90')
  final int? temperatureP90;
  @override
  @JsonKey(name: 'top_a_p10')
  final int? topAP10;
  @override
  @JsonKey(name: 'top_a_p50')
  final int? topAP50;
  @override
  @JsonKey(name: 'top_a_p90')
  final int? topAP90;
  @override
  @JsonKey(name: 'top_k_p10')
  final int? topKP10;
  @override
  @JsonKey(name: 'top_k_p50')
  final int? topKP50;
  @override
  @JsonKey(name: 'top_k_p90')
  final int? topKP90;
  @override
  @JsonKey(name: 'top_p_p10')
  final int? topPP10;
  @override
  @JsonKey(name: 'top_p_p50')
  final int? topPP50;
  @override
  @JsonKey(name: 'top_p_p90')
  final int? topPP90;

  @override
  String toString() {
    return 'ParameterInfo(model: $model, supportedParameters: $supportedParameters, frequencyPenaltyP10: $frequencyPenaltyP10, frequencyPenaltyP50: $frequencyPenaltyP50, frequencyPenaltyP90: $frequencyPenaltyP90, minPP10: $minPP10, minPP50: $minPP50, minPP90: $minPP90, presencePenaltyP10: $presencePenaltyP10, presencePenaltyP50: $presencePenaltyP50, presencePenaltyP90: $presencePenaltyP90, repetitionPenaltyP10: $repetitionPenaltyP10, repetitionPenaltyP50: $repetitionPenaltyP50, repetitionPenaltyP90: $repetitionPenaltyP90, temperatureP10: $temperatureP10, temperatureP50: $temperatureP50, temperatureP90: $temperatureP90, topAP10: $topAP10, topAP50: $topAP50, topAP90: $topAP90, topKP10: $topKP10, topKP50: $topKP50, topKP90: $topKP90, topPP10: $topPP10, topPP50: $topPP50, topPP90: $topPP90)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParameterInfoImpl &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality()
                .equals(other._supportedParameters, _supportedParameters) &&
            (identical(other.frequencyPenaltyP10, frequencyPenaltyP10) ||
                other.frequencyPenaltyP10 == frequencyPenaltyP10) &&
            (identical(other.frequencyPenaltyP50, frequencyPenaltyP50) ||
                other.frequencyPenaltyP50 == frequencyPenaltyP50) &&
            (identical(other.frequencyPenaltyP90, frequencyPenaltyP90) ||
                other.frequencyPenaltyP90 == frequencyPenaltyP90) &&
            (identical(other.minPP10, minPP10) || other.minPP10 == minPP10) &&
            (identical(other.minPP50, minPP50) || other.minPP50 == minPP50) &&
            (identical(other.minPP90, minPP90) || other.minPP90 == minPP90) &&
            (identical(other.presencePenaltyP10, presencePenaltyP10) ||
                other.presencePenaltyP10 == presencePenaltyP10) &&
            (identical(other.presencePenaltyP50, presencePenaltyP50) ||
                other.presencePenaltyP50 == presencePenaltyP50) &&
            (identical(other.presencePenaltyP90, presencePenaltyP90) ||
                other.presencePenaltyP90 == presencePenaltyP90) &&
            (identical(other.repetitionPenaltyP10, repetitionPenaltyP10) ||
                other.repetitionPenaltyP10 == repetitionPenaltyP10) &&
            (identical(other.repetitionPenaltyP50, repetitionPenaltyP50) ||
                other.repetitionPenaltyP50 == repetitionPenaltyP50) &&
            (identical(other.repetitionPenaltyP90, repetitionPenaltyP90) ||
                other.repetitionPenaltyP90 == repetitionPenaltyP90) &&
            (identical(other.temperatureP10, temperatureP10) ||
                other.temperatureP10 == temperatureP10) &&
            (identical(other.temperatureP50, temperatureP50) ||
                other.temperatureP50 == temperatureP50) &&
            (identical(other.temperatureP90, temperatureP90) ||
                other.temperatureP90 == temperatureP90) &&
            (identical(other.topAP10, topAP10) || other.topAP10 == topAP10) &&
            (identical(other.topAP50, topAP50) || other.topAP50 == topAP50) &&
            (identical(other.topAP90, topAP90) || other.topAP90 == topAP90) &&
            (identical(other.topKP10, topKP10) || other.topKP10 == topKP10) &&
            (identical(other.topKP50, topKP50) || other.topKP50 == topKP50) &&
            (identical(other.topKP90, topKP90) || other.topKP90 == topKP90) &&
            (identical(other.topPP10, topPP10) || other.topPP10 == topPP10) &&
            (identical(other.topPP50, topPP50) || other.topPP50 == topPP50) &&
            (identical(other.topPP90, topPP90) || other.topPP90 == topPP90));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
        const DeepCollectionEquality().hash(_supportedParameters),
        frequencyPenaltyP10,
        frequencyPenaltyP50,
        frequencyPenaltyP90,
        minPP10,
        minPP50,
        minPP90,
        presencePenaltyP10,
        presencePenaltyP50,
        presencePenaltyP90,
        repetitionPenaltyP10,
        repetitionPenaltyP50,
        repetitionPenaltyP90,
        temperatureP10,
        temperatureP50,
        temperatureP90,
        topAP10,
        topAP50,
        topAP90,
        topKP10,
        topKP50,
        topKP90,
        topPP10,
        topPP50,
        topPP90
      ]);

  /// Create a copy of ParameterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParameterInfoImplCopyWith<_$ParameterInfoImpl> get copyWith =>
      __$$ParameterInfoImplCopyWithImpl<_$ParameterInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParameterInfoImplToJson(
      this,
    );
  }
}

abstract class _ParameterInfo implements ParameterInfo {
  const factory _ParameterInfo(
      {@JsonKey(name: 'model') final String? model,
      @JsonKey(name: 'supported_parameters')
      final List<String>? supportedParameters,
      @JsonKey(name: 'frequency_penalty_p10') final int? frequencyPenaltyP10,
      @JsonKey(name: 'frequency_penalty_p50') final int? frequencyPenaltyP50,
      @JsonKey(name: 'frequency_penalty_p90') final double? frequencyPenaltyP90,
      @JsonKey(name: 'min_p_p10') final int? minPP10,
      @JsonKey(name: 'min_p_p50') final int? minPP50,
      @JsonKey(name: 'min_p_p90') final int? minPP90,
      @JsonKey(name: 'presence_penalty_p10') final int? presencePenaltyP10,
      @JsonKey(name: 'presence_penalty_p50') final int? presencePenaltyP50,
      @JsonKey(name: 'presence_penalty_p90') final double? presencePenaltyP90,
      @JsonKey(name: 'repetition_penalty_p10') final int? repetitionPenaltyP10,
      @JsonKey(name: 'repetition_penalty_p50') final int? repetitionPenaltyP50,
      @JsonKey(name: 'repetition_penalty_p90') final int? repetitionPenaltyP90,
      @JsonKey(name: 'temperature_p10') final int? temperatureP10,
      @JsonKey(name: 'temperature_p50') final double? temperatureP50,
      @JsonKey(name: 'temperature_p90') final int? temperatureP90,
      @JsonKey(name: 'top_a_p10') final int? topAP10,
      @JsonKey(name: 'top_a_p50') final int? topAP50,
      @JsonKey(name: 'top_a_p90') final int? topAP90,
      @JsonKey(name: 'top_k_p10') final int? topKP10,
      @JsonKey(name: 'top_k_p50') final int? topKP50,
      @JsonKey(name: 'top_k_p90') final int? topKP90,
      @JsonKey(name: 'top_p_p10') final int? topPP10,
      @JsonKey(name: 'top_p_p50') final int? topPP50,
      @JsonKey(name: 'top_p_p90') final int? topPP90}) = _$ParameterInfoImpl;

  factory _ParameterInfo.fromJson(Map<String, dynamic> json) =
      _$ParameterInfoImpl.fromJson;

  @override
  @JsonKey(name: 'model')
  String? get model;
  @override
  @JsonKey(name: 'supported_parameters')
  List<String>? get supportedParameters;
  @override
  @JsonKey(name: 'frequency_penalty_p10')
  int? get frequencyPenaltyP10;
  @override
  @JsonKey(name: 'frequency_penalty_p50')
  int? get frequencyPenaltyP50;
  @override
  @JsonKey(name: 'frequency_penalty_p90')
  double? get frequencyPenaltyP90;
  @override
  @JsonKey(name: 'min_p_p10')
  int? get minPP10;
  @override
  @JsonKey(name: 'min_p_p50')
  int? get minPP50;
  @override
  @JsonKey(name: 'min_p_p90')
  int? get minPP90;
  @override
  @JsonKey(name: 'presence_penalty_p10')
  int? get presencePenaltyP10;
  @override
  @JsonKey(name: 'presence_penalty_p50')
  int? get presencePenaltyP50;
  @override
  @JsonKey(name: 'presence_penalty_p90')
  double? get presencePenaltyP90;
  @override
  @JsonKey(name: 'repetition_penalty_p10')
  int? get repetitionPenaltyP10;
  @override
  @JsonKey(name: 'repetition_penalty_p50')
  int? get repetitionPenaltyP50;
  @override
  @JsonKey(name: 'repetition_penalty_p90')
  int? get repetitionPenaltyP90;
  @override
  @JsonKey(name: 'temperature_p10')
  int? get temperatureP10;
  @override
  @JsonKey(name: 'temperature_p50')
  double? get temperatureP50;
  @override
  @JsonKey(name: 'temperature_p90')
  int? get temperatureP90;
  @override
  @JsonKey(name: 'top_a_p10')
  int? get topAP10;
  @override
  @JsonKey(name: 'top_a_p50')
  int? get topAP50;
  @override
  @JsonKey(name: 'top_a_p90')
  int? get topAP90;
  @override
  @JsonKey(name: 'top_k_p10')
  int? get topKP10;
  @override
  @JsonKey(name: 'top_k_p50')
  int? get topKP50;
  @override
  @JsonKey(name: 'top_k_p90')
  int? get topKP90;
  @override
  @JsonKey(name: 'top_p_p10')
  int? get topPP10;
  @override
  @JsonKey(name: 'top_p_p50')
  int? get topPP50;
  @override
  @JsonKey(name: 'top_p_p90')
  int? get topPP90;

  /// Create a copy of ParameterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParameterInfoImplCopyWith<_$ParameterInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
