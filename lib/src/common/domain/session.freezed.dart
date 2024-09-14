// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatSession _$ChatSessionFromJson(Map<String, dynamic> json) {
  return _ChatSession.fromJson(json);
}

/// @nodoc
mixin _$ChatSession {
  int get id => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  String get modelId => throw _privateConstructorUsedError;
  Parameters? get parameters => throw _privateConstructorUsedError;

  /// Serializes this ChatSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatSessionCopyWith<ChatSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSessionCopyWith<$Res> {
  factory $ChatSessionCopyWith(
          ChatSession value, $Res Function(ChatSession) then) =
      _$ChatSessionCopyWithImpl<$Res, ChatSession>;
  @useResult
  $Res call(
      {int id, List<Message> messages, String modelId, Parameters? parameters});

  $ParametersCopyWith<$Res>? get parameters;
}

/// @nodoc
class _$ChatSessionCopyWithImpl<$Res, $Val extends ChatSession>
    implements $ChatSessionCopyWith<$Res> {
  _$ChatSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? messages = null,
    Object? modelId = null,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Parameters?,
    ) as $Val);
  }

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParametersCopyWith<$Res>? get parameters {
    if (_value.parameters == null) {
      return null;
    }

    return $ParametersCopyWith<$Res>(_value.parameters!, (value) {
      return _then(_value.copyWith(parameters: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatSessionImplCopyWith<$Res>
    implements $ChatSessionCopyWith<$Res> {
  factory _$$ChatSessionImplCopyWith(
          _$ChatSessionImpl value, $Res Function(_$ChatSessionImpl) then) =
      __$$ChatSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, List<Message> messages, String modelId, Parameters? parameters});

  @override
  $ParametersCopyWith<$Res>? get parameters;
}

/// @nodoc
class __$$ChatSessionImplCopyWithImpl<$Res>
    extends _$ChatSessionCopyWithImpl<$Res, _$ChatSessionImpl>
    implements _$$ChatSessionImplCopyWith<$Res> {
  __$$ChatSessionImplCopyWithImpl(
      _$ChatSessionImpl _value, $Res Function(_$ChatSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? messages = null,
    Object? modelId = null,
    Object? parameters = freezed,
  }) {
    return _then(_$ChatSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Parameters?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ChatSessionImpl implements _ChatSession {
  const _$ChatSessionImpl(
      {required this.id,
      required final List<Message> messages,
      required this.modelId,
      this.parameters})
      : _messages = messages;

  factory _$ChatSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatSessionImplFromJson(json);

  @override
  final int id;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final String modelId;
  @override
  final Parameters? parameters;

  @override
  String toString() {
    return 'ChatSession(id: $id, messages: $messages, modelId: $modelId, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.parameters, parameters) ||
                other.parameters == parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_messages), modelId, parameters);

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatSessionImplCopyWith<_$ChatSessionImpl> get copyWith =>
      __$$ChatSessionImplCopyWithImpl<_$ChatSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatSessionImplToJson(
      this,
    );
  }
}

abstract class _ChatSession implements ChatSession {
  const factory _ChatSession(
      {required final int id,
      required final List<Message> messages,
      required final String modelId,
      final Parameters? parameters}) = _$ChatSessionImpl;

  factory _ChatSession.fromJson(Map<String, dynamic> json) =
      _$ChatSessionImpl.fromJson;

  @override
  int get id;
  @override
  List<Message> get messages;
  @override
  String get modelId;
  @override
  Parameters? get parameters;

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatSessionImplCopyWith<_$ChatSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  Role get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  Usage? get usage => throw _privateConstructorUsedError;
  Validation? get validation => throw _privateConstructorUsedError;
  String? get overriddenModelId => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {Role role,
      String content,
      int timestamp,
      Usage? usage,
      Validation? validation,
      String? overriddenModelId});

  $UsageCopyWith<$Res>? get usage;
  $ValidationCopyWith<$Res>? get validation;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? content = null,
    Object? timestamp = null,
    Object? usage = freezed,
    Object? validation = freezed,
    Object? overriddenModelId = freezed,
  }) {
    return _then(_value.copyWith(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
      validation: freezed == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as Validation?,
      overriddenModelId: freezed == overriddenModelId
          ? _value.overriddenModelId
          : overriddenModelId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Message
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

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ValidationCopyWith<$Res>? get validation {
    if (_value.validation == null) {
      return null;
    }

    return $ValidationCopyWith<$Res>(_value.validation!, (value) {
      return _then(_value.copyWith(validation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Role role,
      String content,
      int timestamp,
      Usage? usage,
      Validation? validation,
      String? overriddenModelId});

  @override
  $UsageCopyWith<$Res>? get usage;
  @override
  $ValidationCopyWith<$Res>? get validation;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? content = null,
    Object? timestamp = null,
    Object? usage = freezed,
    Object? validation = freezed,
    Object? overriddenModelId = freezed,
  }) {
    return _then(_$MessageImpl(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
      validation: freezed == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as Validation?,
      overriddenModelId: freezed == overriddenModelId
          ? _value.overriddenModelId
          : overriddenModelId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.role,
      required this.content,
      required this.timestamp,
      this.usage,
      this.validation,
      this.overriddenModelId});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final Role role;
  @override
  final String content;
  @override
  final int timestamp;
  @override
  final Usage? usage;
  @override
  final Validation? validation;
  @override
  final String? overriddenModelId;

  @override
  String toString() {
    return 'Message(role: $role, content: $content, timestamp: $timestamp, usage: $usage, validation: $validation, overriddenModelId: $overriddenModelId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.validation, validation) ||
                other.validation == validation) &&
            (identical(other.overriddenModelId, overriddenModelId) ||
                other.overriddenModelId == overriddenModelId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, content, timestamp, usage,
      validation, overriddenModelId);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final Role role,
      required final String content,
      required final int timestamp,
      final Usage? usage,
      final Validation? validation,
      final String? overriddenModelId}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  Role get role;
  @override
  String get content;
  @override
  int get timestamp;
  @override
  Usage? get usage;
  @override
  Validation? get validation;
  @override
  String? get overriddenModelId;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValidateRequest _$ValidateRequestFromJson(Map<String, dynamic> json) {
  return _ValidateRequest.fromJson(json);
}

/// @nodoc
mixin _$ValidateRequest {
  Message get targetMessage => throw _privateConstructorUsedError;
  Message get sysPrompt => throw _privateConstructorUsedError;
  ChatSession get currentSession => throw _privateConstructorUsedError;
  String? get modelId => throw _privateConstructorUsedError;
  Parameters? get parameters => throw _privateConstructorUsedError;

  /// Serializes this ValidateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidateRequestCopyWith<ValidateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidateRequestCopyWith<$Res> {
  factory $ValidateRequestCopyWith(
          ValidateRequest value, $Res Function(ValidateRequest) then) =
      _$ValidateRequestCopyWithImpl<$Res, ValidateRequest>;
  @useResult
  $Res call(
      {Message targetMessage,
      Message sysPrompt,
      ChatSession currentSession,
      String? modelId,
      Parameters? parameters});

  $MessageCopyWith<$Res> get targetMessage;
  $MessageCopyWith<$Res> get sysPrompt;
  $ChatSessionCopyWith<$Res> get currentSession;
  $ParametersCopyWith<$Res>? get parameters;
}

/// @nodoc
class _$ValidateRequestCopyWithImpl<$Res, $Val extends ValidateRequest>
    implements $ValidateRequestCopyWith<$Res> {
  _$ValidateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetMessage = null,
    Object? sysPrompt = null,
    Object? currentSession = null,
    Object? modelId = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      targetMessage: null == targetMessage
          ? _value.targetMessage
          : targetMessage // ignore: cast_nullable_to_non_nullable
              as Message,
      sysPrompt: null == sysPrompt
          ? _value.sysPrompt
          : sysPrompt // ignore: cast_nullable_to_non_nullable
              as Message,
      currentSession: null == currentSession
          ? _value.currentSession
          : currentSession // ignore: cast_nullable_to_non_nullable
              as ChatSession,
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Parameters?,
    ) as $Val);
  }

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get targetMessage {
    return $MessageCopyWith<$Res>(_value.targetMessage, (value) {
      return _then(_value.copyWith(targetMessage: value) as $Val);
    });
  }

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get sysPrompt {
    return $MessageCopyWith<$Res>(_value.sysPrompt, (value) {
      return _then(_value.copyWith(sysPrompt: value) as $Val);
    });
  }

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatSessionCopyWith<$Res> get currentSession {
    return $ChatSessionCopyWith<$Res>(_value.currentSession, (value) {
      return _then(_value.copyWith(currentSession: value) as $Val);
    });
  }

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParametersCopyWith<$Res>? get parameters {
    if (_value.parameters == null) {
      return null;
    }

    return $ParametersCopyWith<$Res>(_value.parameters!, (value) {
      return _then(_value.copyWith(parameters: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ValidateRequestImplCopyWith<$Res>
    implements $ValidateRequestCopyWith<$Res> {
  factory _$$ValidateRequestImplCopyWith(_$ValidateRequestImpl value,
          $Res Function(_$ValidateRequestImpl) then) =
      __$$ValidateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Message targetMessage,
      Message sysPrompt,
      ChatSession currentSession,
      String? modelId,
      Parameters? parameters});

  @override
  $MessageCopyWith<$Res> get targetMessage;
  @override
  $MessageCopyWith<$Res> get sysPrompt;
  @override
  $ChatSessionCopyWith<$Res> get currentSession;
  @override
  $ParametersCopyWith<$Res>? get parameters;
}

/// @nodoc
class __$$ValidateRequestImplCopyWithImpl<$Res>
    extends _$ValidateRequestCopyWithImpl<$Res, _$ValidateRequestImpl>
    implements _$$ValidateRequestImplCopyWith<$Res> {
  __$$ValidateRequestImplCopyWithImpl(
      _$ValidateRequestImpl _value, $Res Function(_$ValidateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetMessage = null,
    Object? sysPrompt = null,
    Object? currentSession = null,
    Object? modelId = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_$ValidateRequestImpl(
      targetMessage: null == targetMessage
          ? _value.targetMessage
          : targetMessage // ignore: cast_nullable_to_non_nullable
              as Message,
      sysPrompt: null == sysPrompt
          ? _value.sysPrompt
          : sysPrompt // ignore: cast_nullable_to_non_nullable
              as Message,
      currentSession: null == currentSession
          ? _value.currentSession
          : currentSession // ignore: cast_nullable_to_non_nullable
              as ChatSession,
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Parameters?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$ValidateRequestImpl implements _ValidateRequest {
  const _$ValidateRequestImpl(
      {required this.targetMessage,
      required this.sysPrompt,
      required this.currentSession,
      this.modelId,
      this.parameters});

  factory _$ValidateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidateRequestImplFromJson(json);

  @override
  final Message targetMessage;
  @override
  final Message sysPrompt;
  @override
  final ChatSession currentSession;
  @override
  final String? modelId;
  @override
  final Parameters? parameters;

  @override
  String toString() {
    return 'ValidateRequest(targetMessage: $targetMessage, sysPrompt: $sysPrompt, currentSession: $currentSession, modelId: $modelId, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateRequestImpl &&
            (identical(other.targetMessage, targetMessage) ||
                other.targetMessage == targetMessage) &&
            (identical(other.sysPrompt, sysPrompt) ||
                other.sysPrompt == sysPrompt) &&
            (identical(other.currentSession, currentSession) ||
                other.currentSession == currentSession) &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.parameters, parameters) ||
                other.parameters == parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, targetMessage, sysPrompt,
      currentSession, modelId, parameters);

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidateRequestImplCopyWith<_$ValidateRequestImpl> get copyWith =>
      __$$ValidateRequestImplCopyWithImpl<_$ValidateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidateRequestImplToJson(
      this,
    );
  }
}

abstract class _ValidateRequest implements ValidateRequest {
  const factory _ValidateRequest(
      {required final Message targetMessage,
      required final Message sysPrompt,
      required final ChatSession currentSession,
      final String? modelId,
      final Parameters? parameters}) = _$ValidateRequestImpl;

  factory _ValidateRequest.fromJson(Map<String, dynamic> json) =
      _$ValidateRequestImpl.fromJson;

  @override
  Message get targetMessage;
  @override
  Message get sysPrompt;
  @override
  ChatSession get currentSession;
  @override
  String? get modelId;
  @override
  Parameters? get parameters;

  /// Create a copy of ValidateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidateRequestImplCopyWith<_$ValidateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Validation _$ValidationFromJson(Map<String, dynamic> json) {
  return _Validation.fromJson(json);
}

/// @nodoc
mixin _$Validation {
  String get modelId => throw _privateConstructorUsedError;
  String get result => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  Usage? get usage => throw _privateConstructorUsedError;

  /// Serializes this Validation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Validation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidationCopyWith<Validation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationCopyWith<$Res> {
  factory $ValidationCopyWith(
          Validation value, $Res Function(Validation) then) =
      _$ValidationCopyWithImpl<$Res, Validation>;
  @useResult
  $Res call({String modelId, String result, int timestamp, Usage? usage});

  $UsageCopyWith<$Res>? get usage;
}

/// @nodoc
class _$ValidationCopyWithImpl<$Res, $Val extends Validation>
    implements $ValidationCopyWith<$Res> {
  _$ValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Validation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = null,
    Object? result = null,
    Object? timestamp = null,
    Object? usage = freezed,
  }) {
    return _then(_value.copyWith(
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
    ) as $Val);
  }

  /// Create a copy of Validation
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
abstract class _$$ValidationImplCopyWith<$Res>
    implements $ValidationCopyWith<$Res> {
  factory _$$ValidationImplCopyWith(
          _$ValidationImpl value, $Res Function(_$ValidationImpl) then) =
      __$$ValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String modelId, String result, int timestamp, Usage? usage});

  @override
  $UsageCopyWith<$Res>? get usage;
}

/// @nodoc
class __$$ValidationImplCopyWithImpl<$Res>
    extends _$ValidationCopyWithImpl<$Res, _$ValidationImpl>
    implements _$$ValidationImplCopyWith<$Res> {
  __$$ValidationImplCopyWithImpl(
      _$ValidationImpl _value, $Res Function(_$ValidationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Validation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelId = null,
    Object? result = null,
    Object? timestamp = null,
    Object? usage = freezed,
  }) {
    return _then(_$ValidationImpl(
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$ValidationImpl implements _Validation {
  const _$ValidationImpl(
      {required this.modelId,
      required this.result,
      required this.timestamp,
      this.usage});

  factory _$ValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationImplFromJson(json);

  @override
  final String modelId;
  @override
  final String result;
  @override
  final int timestamp;
  @override
  final Usage? usage;

  @override
  String toString() {
    return 'Validation(modelId: $modelId, result: $result, timestamp: $timestamp, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationImpl &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, modelId, result, timestamp, usage);

  /// Create a copy of Validation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationImplCopyWith<_$ValidationImpl> get copyWith =>
      __$$ValidationImplCopyWithImpl<_$ValidationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationImplToJson(
      this,
    );
  }
}

abstract class _Validation implements Validation {
  const factory _Validation(
      {required final String modelId,
      required final String result,
      required final int timestamp,
      final Usage? usage}) = _$ValidationImpl;

  factory _Validation.fromJson(Map<String, dynamic> json) =
      _$ValidationImpl.fromJson;

  @override
  String get modelId;
  @override
  String get result;
  @override
  int get timestamp;
  @override
  Usage? get usage;

  /// Create a copy of Validation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationImplCopyWith<_$ValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Parameters _$ParametersFromJson(Map<String, dynamic> json) {
  return _Parameters.fromJson(json);
}

/// @nodoc
mixin _$Parameters {
  /// This sets the upper limit for the number of tokens the model can generate in response.
  /// It won't produce more than this limit.
  /// The maximum value is the context length minus the prompt length.
  @JsonKey(name: 'max_tokens')
  int? get maxTokens => throw _privateConstructorUsedError;

  /// This setting influences the variety in the model's responses.
  /// Lower values lead to more predictable and typical responses,
  /// while higher values encourage more diverse and less common responses.
  /// At 0, the model always gives the same response for a given input.
  ///
  /// Allowed values: 0.0 to 2.0
  /// Default: 1.0
  @JsonKey(name: 'temperature')
  double? get temperature => throw _privateConstructorUsedError;

  /// This setting limits the model's choices to a percentage of likely tokens:
  /// only the top tokens whose probabilities add up to P.
  /// A lower value makes the model's responses more predictable,
  /// while the default setting allows for a full range of token choices.
  /// Think of it like a dynamic Top-K.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 1.0
  @JsonKey(name: 'top_p')
  double? get topP => throw _privateConstructorUsedError;

  /// This limits the model's choice of tokens at each step, making it choose from a smaller set.
  /// A value of 1 means the model will always pick the most likely next token, leading to predictable results.
  /// By default this setting is disabled, making the model to consider all choices.
  ///
  /// Allowed values: 0 to 1
  /// Default: 0
  @JsonKey(name: 'top_k')
  int? get topK => throw _privateConstructorUsedError;

  /// This setting aims to control the repetition of tokens based on how often they appear in the input.
  /// It tries to use less frequently those tokens that appear more in the input,
  /// proportional to how frequently they occur.
  /// Token penalty scales with the number of occurrences.
  /// Negative values will encourage token reuse.
  ///
  /// Allowed values: -2.0 to 2.0
  /// Default: 0.0
  @JsonKey(name: 'frequency_penalty')
  double? get frequencyPenalty => throw _privateConstructorUsedError;

  /// Adjusts how often the model repeats specific tokens already used in the input.
  /// Higher values make such repetition less likely, while negative values do the opposite.
  /// Token penalty does not scale with the number of occurrences.
  /// Negative values will encourage token reuse.
  ///
  /// Allowed values: -2.0 to 2.0
  /// Default: 0.0
  @JsonKey(name: 'presence_penalty')
  double? get presencePenalty => throw _privateConstructorUsedError;

  /// Helps to reduce the repetition of tokens from the input.
  /// A higher value makes the model less likely to repeat tokens,
  /// but too high a value can make the output less coherent (often with run-on sentences that lack small words).
  /// Token penalty scales based on original token's probability.
  ///
  /// Allowed values: 0.0 to 2.0
  /// Default: 1.0
  @JsonKey(name: 'repetition_penalty')
  double? get repetitionPenalty => throw _privateConstructorUsedError;

  /// Represents the minimum probability for a token to be considered,
  /// relative to the probability of the most likely token.
  /// (The value changes depending on the confidence level of the most probable token.)
  /// If your Min-P is set to 0.1,
  /// that means it will only allow for tokens that are at least 1/10th as probable as the best possible option.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 0.0
  @JsonKey(name: 'min_p')
  double? get minProbability => throw _privateConstructorUsedError;

  /// Consider only the top tokens with "sufficiently high" probabilities based on the probability of the most likely token.
  /// Think of it like a dynamic Top-P.
  /// A lower Top-A value focuses the choices based on the highest probability token but with a narrower scope.
  /// A higher Top-A value does not necessarily affect the creativity of the output,
  /// but rather refines the filtering process based on the maximum probability.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 0.0
  @JsonKey(name: 'top_a')
  double? get topAnswer => throw _privateConstructorUsedError;

  /// If specified, the inferencing will sample deterministically,
  /// such that repeated requests with the same seed and parameters should return the same result.
  /// Determinism is not guaranteed for some models.
  @JsonKey(name: 'seed')
  int? get seed => throw _privateConstructorUsedError;

  /// Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer)
  /// to an associated bias value from -100 to 100. Mathematically,
  /// the bias is added to the logits generated by the model prior to sampling.
  /// The exact effect will vary per model, but values between -1 and 1 should decrease
  /// or increase likelihood of selection;
  /// values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
  @JsonKey(name: 'logit_bias')
  Map<String, int>? get logitBias => throw _privateConstructorUsedError;

  /// Whether to return log probabilities of the output tokens or not.
  /// If true, returns the log probabilities of each output token returned.
  @JsonKey(name: 'logprobs')
  bool? get logProbabilities => throw _privateConstructorUsedError;

  /// An integer between 0 and 20 specifying the number of most likely tokens to return at each token position,
  /// each with an associated log probability. logprobs must be set to true if this parameter is used.
  @JsonKey(name: 'top_logprobs')
  int? get topLogProbabilities => throw _privateConstructorUsedError;

  /// Forces the model to produce specific output format.
  /// Setting to { "type": "json_object" } enables JSON mode,
  /// which guarantees the message the model generates is valid JSON.
  ///  Note: when using JSON mode, you should also instruct the model to produce JSON yourself via a system or user message.
  @JsonKey(name: 'response_format')
  Map<String, String>? get responseFormat => throw _privateConstructorUsedError;

  /// Stop generation immediately if the model encounter any token specified in the stop array.
  @JsonKey(name: 'stop')
  List<int>? get stop => throw _privateConstructorUsedError;

  /// Serializes this Parameters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParametersCopyWith<Parameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParametersCopyWith<$Res> {
  factory $ParametersCopyWith(
          Parameters value, $Res Function(Parameters) then) =
      _$ParametersCopyWithImpl<$Res, Parameters>;
  @useResult
  $Res call(
      {@JsonKey(name: 'max_tokens') int? maxTokens,
      @JsonKey(name: 'temperature') double? temperature,
      @JsonKey(name: 'top_p') double? topP,
      @JsonKey(name: 'top_k') int? topK,
      @JsonKey(name: 'frequency_penalty') double? frequencyPenalty,
      @JsonKey(name: 'presence_penalty') double? presencePenalty,
      @JsonKey(name: 'repetition_penalty') double? repetitionPenalty,
      @JsonKey(name: 'min_p') double? minProbability,
      @JsonKey(name: 'top_a') double? topAnswer,
      @JsonKey(name: 'seed') int? seed,
      @JsonKey(name: 'logit_bias') Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') bool? logProbabilities,
      @JsonKey(name: 'top_logprobs') int? topLogProbabilities,
      @JsonKey(name: 'response_format') Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') List<int>? stop});
}

/// @nodoc
class _$ParametersCopyWithImpl<$Res, $Val extends Parameters>
    implements $ParametersCopyWith<$Res> {
  _$ParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxTokens = freezed,
    Object? temperature = freezed,
    Object? topP = freezed,
    Object? topK = freezed,
    Object? frequencyPenalty = freezed,
    Object? presencePenalty = freezed,
    Object? repetitionPenalty = freezed,
    Object? minProbability = freezed,
    Object? topAnswer = freezed,
    Object? seed = freezed,
    Object? logitBias = freezed,
    Object? logProbabilities = freezed,
    Object? topLogProbabilities = freezed,
    Object? responseFormat = freezed,
    Object? stop = freezed,
  }) {
    return _then(_value.copyWith(
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
      topP: freezed == topP
          ? _value.topP
          : topP // ignore: cast_nullable_to_non_nullable
              as double?,
      topK: freezed == topK
          ? _value.topK
          : topK // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyPenalty: freezed == frequencyPenalty
          ? _value.frequencyPenalty
          : frequencyPenalty // ignore: cast_nullable_to_non_nullable
              as double?,
      presencePenalty: freezed == presencePenalty
          ? _value.presencePenalty
          : presencePenalty // ignore: cast_nullable_to_non_nullable
              as double?,
      repetitionPenalty: freezed == repetitionPenalty
          ? _value.repetitionPenalty
          : repetitionPenalty // ignore: cast_nullable_to_non_nullable
              as double?,
      minProbability: freezed == minProbability
          ? _value.minProbability
          : minProbability // ignore: cast_nullable_to_non_nullable
              as double?,
      topAnswer: freezed == topAnswer
          ? _value.topAnswer
          : topAnswer // ignore: cast_nullable_to_non_nullable
              as double?,
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int?,
      logitBias: freezed == logitBias
          ? _value.logitBias
          : logitBias // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      logProbabilities: freezed == logProbabilities
          ? _value.logProbabilities
          : logProbabilities // ignore: cast_nullable_to_non_nullable
              as bool?,
      topLogProbabilities: freezed == topLogProbabilities
          ? _value.topLogProbabilities
          : topLogProbabilities // ignore: cast_nullable_to_non_nullable
              as int?,
      responseFormat: freezed == responseFormat
          ? _value.responseFormat
          : responseFormat // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      stop: freezed == stop
          ? _value.stop
          : stop // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParametersImplCopyWith<$Res>
    implements $ParametersCopyWith<$Res> {
  factory _$$ParametersImplCopyWith(
          _$ParametersImpl value, $Res Function(_$ParametersImpl) then) =
      __$$ParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'max_tokens') int? maxTokens,
      @JsonKey(name: 'temperature') double? temperature,
      @JsonKey(name: 'top_p') double? topP,
      @JsonKey(name: 'top_k') int? topK,
      @JsonKey(name: 'frequency_penalty') double? frequencyPenalty,
      @JsonKey(name: 'presence_penalty') double? presencePenalty,
      @JsonKey(name: 'repetition_penalty') double? repetitionPenalty,
      @JsonKey(name: 'min_p') double? minProbability,
      @JsonKey(name: 'top_a') double? topAnswer,
      @JsonKey(name: 'seed') int? seed,
      @JsonKey(name: 'logit_bias') Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') bool? logProbabilities,
      @JsonKey(name: 'top_logprobs') int? topLogProbabilities,
      @JsonKey(name: 'response_format') Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') List<int>? stop});
}

/// @nodoc
class __$$ParametersImplCopyWithImpl<$Res>
    extends _$ParametersCopyWithImpl<$Res, _$ParametersImpl>
    implements _$$ParametersImplCopyWith<$Res> {
  __$$ParametersImplCopyWithImpl(
      _$ParametersImpl _value, $Res Function(_$ParametersImpl) _then)
      : super(_value, _then);

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxTokens = freezed,
    Object? temperature = freezed,
    Object? topP = freezed,
    Object? topK = freezed,
    Object? frequencyPenalty = freezed,
    Object? presencePenalty = freezed,
    Object? repetitionPenalty = freezed,
    Object? minProbability = freezed,
    Object? topAnswer = freezed,
    Object? seed = freezed,
    Object? logitBias = freezed,
    Object? logProbabilities = freezed,
    Object? topLogProbabilities = freezed,
    Object? responseFormat = freezed,
    Object? stop = freezed,
  }) {
    return _then(_$ParametersImpl(
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
      topP: freezed == topP
          ? _value.topP
          : topP // ignore: cast_nullable_to_non_nullable
              as double?,
      topK: freezed == topK
          ? _value.topK
          : topK // ignore: cast_nullable_to_non_nullable
              as int?,
      frequencyPenalty: freezed == frequencyPenalty
          ? _value.frequencyPenalty
          : frequencyPenalty // ignore: cast_nullable_to_non_nullable
              as double?,
      presencePenalty: freezed == presencePenalty
          ? _value.presencePenalty
          : presencePenalty // ignore: cast_nullable_to_non_nullable
              as double?,
      repetitionPenalty: freezed == repetitionPenalty
          ? _value.repetitionPenalty
          : repetitionPenalty // ignore: cast_nullable_to_non_nullable
              as double?,
      minProbability: freezed == minProbability
          ? _value.minProbability
          : minProbability // ignore: cast_nullable_to_non_nullable
              as double?,
      topAnswer: freezed == topAnswer
          ? _value.topAnswer
          : topAnswer // ignore: cast_nullable_to_non_nullable
              as double?,
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int?,
      logitBias: freezed == logitBias
          ? _value._logitBias
          : logitBias // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      logProbabilities: freezed == logProbabilities
          ? _value.logProbabilities
          : logProbabilities // ignore: cast_nullable_to_non_nullable
              as bool?,
      topLogProbabilities: freezed == topLogProbabilities
          ? _value.topLogProbabilities
          : topLogProbabilities // ignore: cast_nullable_to_non_nullable
              as int?,
      responseFormat: freezed == responseFormat
          ? _value._responseFormat
          : responseFormat // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      stop: freezed == stop
          ? _value._stop
          : stop // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ParametersImpl implements _Parameters {
  const _$ParametersImpl(
      {@JsonKey(name: 'max_tokens') this.maxTokens,
      @JsonKey(name: 'temperature') this.temperature,
      @JsonKey(name: 'top_p') this.topP,
      @JsonKey(name: 'top_k') this.topK,
      @JsonKey(name: 'frequency_penalty') this.frequencyPenalty,
      @JsonKey(name: 'presence_penalty') this.presencePenalty,
      @JsonKey(name: 'repetition_penalty') this.repetitionPenalty,
      @JsonKey(name: 'min_p') this.minProbability,
      @JsonKey(name: 'top_a') this.topAnswer,
      @JsonKey(name: 'seed') this.seed,
      @JsonKey(name: 'logit_bias') final Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') this.logProbabilities,
      @JsonKey(name: 'top_logprobs') this.topLogProbabilities,
      @JsonKey(name: 'response_format')
      final Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') final List<int>? stop})
      : _logitBias = logitBias,
        _responseFormat = responseFormat,
        _stop = stop;

  factory _$ParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParametersImplFromJson(json);

  /// This sets the upper limit for the number of tokens the model can generate in response.
  /// It won't produce more than this limit.
  /// The maximum value is the context length minus the prompt length.
  @override
  @JsonKey(name: 'max_tokens')
  final int? maxTokens;

  /// This setting influences the variety in the model's responses.
  /// Lower values lead to more predictable and typical responses,
  /// while higher values encourage more diverse and less common responses.
  /// At 0, the model always gives the same response for a given input.
  ///
  /// Allowed values: 0.0 to 2.0
  /// Default: 1.0
  @override
  @JsonKey(name: 'temperature')
  final double? temperature;

  /// This setting limits the model's choices to a percentage of likely tokens:
  /// only the top tokens whose probabilities add up to P.
  /// A lower value makes the model's responses more predictable,
  /// while the default setting allows for a full range of token choices.
  /// Think of it like a dynamic Top-K.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 1.0
  @override
  @JsonKey(name: 'top_p')
  final double? topP;

  /// This limits the model's choice of tokens at each step, making it choose from a smaller set.
  /// A value of 1 means the model will always pick the most likely next token, leading to predictable results.
  /// By default this setting is disabled, making the model to consider all choices.
  ///
  /// Allowed values: 0 to 1
  /// Default: 0
  @override
  @JsonKey(name: 'top_k')
  final int? topK;

  /// This setting aims to control the repetition of tokens based on how often they appear in the input.
  /// It tries to use less frequently those tokens that appear more in the input,
  /// proportional to how frequently they occur.
  /// Token penalty scales with the number of occurrences.
  /// Negative values will encourage token reuse.
  ///
  /// Allowed values: -2.0 to 2.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'frequency_penalty')
  final double? frequencyPenalty;

  /// Adjusts how often the model repeats specific tokens already used in the input.
  /// Higher values make such repetition less likely, while negative values do the opposite.
  /// Token penalty does not scale with the number of occurrences.
  /// Negative values will encourage token reuse.
  ///
  /// Allowed values: -2.0 to 2.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'presence_penalty')
  final double? presencePenalty;

  /// Helps to reduce the repetition of tokens from the input.
  /// A higher value makes the model less likely to repeat tokens,
  /// but too high a value can make the output less coherent (often with run-on sentences that lack small words).
  /// Token penalty scales based on original token's probability.
  ///
  /// Allowed values: 0.0 to 2.0
  /// Default: 1.0
  @override
  @JsonKey(name: 'repetition_penalty')
  final double? repetitionPenalty;

  /// Represents the minimum probability for a token to be considered,
  /// relative to the probability of the most likely token.
  /// (The value changes depending on the confidence level of the most probable token.)
  /// If your Min-P is set to 0.1,
  /// that means it will only allow for tokens that are at least 1/10th as probable as the best possible option.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'min_p')
  final double? minProbability;

  /// Consider only the top tokens with "sufficiently high" probabilities based on the probability of the most likely token.
  /// Think of it like a dynamic Top-P.
  /// A lower Top-A value focuses the choices based on the highest probability token but with a narrower scope.
  /// A higher Top-A value does not necessarily affect the creativity of the output,
  /// but rather refines the filtering process based on the maximum probability.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'top_a')
  final double? topAnswer;

  /// If specified, the inferencing will sample deterministically,
  /// such that repeated requests with the same seed and parameters should return the same result.
  /// Determinism is not guaranteed for some models.
  @override
  @JsonKey(name: 'seed')
  final int? seed;

  /// Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer)
  /// to an associated bias value from -100 to 100. Mathematically,
  /// the bias is added to the logits generated by the model prior to sampling.
  /// The exact effect will vary per model, but values between -1 and 1 should decrease
  /// or increase likelihood of selection;
  /// values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
  final Map<String, int>? _logitBias;

  /// Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer)
  /// to an associated bias value from -100 to 100. Mathematically,
  /// the bias is added to the logits generated by the model prior to sampling.
  /// The exact effect will vary per model, but values between -1 and 1 should decrease
  /// or increase likelihood of selection;
  /// values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
  @override
  @JsonKey(name: 'logit_bias')
  Map<String, int>? get logitBias {
    final value = _logitBias;
    if (value == null) return null;
    if (_logitBias is EqualUnmodifiableMapView) return _logitBias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Whether to return log probabilities of the output tokens or not.
  /// If true, returns the log probabilities of each output token returned.
  @override
  @JsonKey(name: 'logprobs')
  final bool? logProbabilities;

  /// An integer between 0 and 20 specifying the number of most likely tokens to return at each token position,
  /// each with an associated log probability. logprobs must be set to true if this parameter is used.
  @override
  @JsonKey(name: 'top_logprobs')
  final int? topLogProbabilities;

  /// Forces the model to produce specific output format.
  /// Setting to { "type": "json_object" } enables JSON mode,
  /// which guarantees the message the model generates is valid JSON.
  ///  Note: when using JSON mode, you should also instruct the model to produce JSON yourself via a system or user message.
  final Map<String, String>? _responseFormat;

  /// Forces the model to produce specific output format.
  /// Setting to { "type": "json_object" } enables JSON mode,
  /// which guarantees the message the model generates is valid JSON.
  ///  Note: when using JSON mode, you should also instruct the model to produce JSON yourself via a system or user message.
  @override
  @JsonKey(name: 'response_format')
  Map<String, String>? get responseFormat {
    final value = _responseFormat;
    if (value == null) return null;
    if (_responseFormat is EqualUnmodifiableMapView) return _responseFormat;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Stop generation immediately if the model encounter any token specified in the stop array.
  final List<int>? _stop;

  /// Stop generation immediately if the model encounter any token specified in the stop array.
  @override
  @JsonKey(name: 'stop')
  List<int>? get stop {
    final value = _stop;
    if (value == null) return null;
    if (_stop is EqualUnmodifiableListView) return _stop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Parameters(maxTokens: $maxTokens, temperature: $temperature, topP: $topP, topK: $topK, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty, repetitionPenalty: $repetitionPenalty, minProbability: $minProbability, topAnswer: $topAnswer, seed: $seed, logitBias: $logitBias, logProbabilities: $logProbabilities, topLogProbabilities: $topLogProbabilities, responseFormat: $responseFormat, stop: $stop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParametersImpl &&
            (identical(other.maxTokens, maxTokens) ||
                other.maxTokens == maxTokens) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.topP, topP) || other.topP == topP) &&
            (identical(other.topK, topK) || other.topK == topK) &&
            (identical(other.frequencyPenalty, frequencyPenalty) ||
                other.frequencyPenalty == frequencyPenalty) &&
            (identical(other.presencePenalty, presencePenalty) ||
                other.presencePenalty == presencePenalty) &&
            (identical(other.repetitionPenalty, repetitionPenalty) ||
                other.repetitionPenalty == repetitionPenalty) &&
            (identical(other.minProbability, minProbability) ||
                other.minProbability == minProbability) &&
            (identical(other.topAnswer, topAnswer) ||
                other.topAnswer == topAnswer) &&
            (identical(other.seed, seed) || other.seed == seed) &&
            const DeepCollectionEquality()
                .equals(other._logitBias, _logitBias) &&
            (identical(other.logProbabilities, logProbabilities) ||
                other.logProbabilities == logProbabilities) &&
            (identical(other.topLogProbabilities, topLogProbabilities) ||
                other.topLogProbabilities == topLogProbabilities) &&
            const DeepCollectionEquality()
                .equals(other._responseFormat, _responseFormat) &&
            const DeepCollectionEquality().equals(other._stop, _stop));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      maxTokens,
      temperature,
      topP,
      topK,
      frequencyPenalty,
      presencePenalty,
      repetitionPenalty,
      minProbability,
      topAnswer,
      seed,
      const DeepCollectionEquality().hash(_logitBias),
      logProbabilities,
      topLogProbabilities,
      const DeepCollectionEquality().hash(_responseFormat),
      const DeepCollectionEquality().hash(_stop));

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParametersImplCopyWith<_$ParametersImpl> get copyWith =>
      __$$ParametersImplCopyWithImpl<_$ParametersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParametersImplToJson(
      this,
    );
  }
}

abstract class _Parameters implements Parameters {
  const factory _Parameters(
      {@JsonKey(name: 'max_tokens') final int? maxTokens,
      @JsonKey(name: 'temperature') final double? temperature,
      @JsonKey(name: 'top_p') final double? topP,
      @JsonKey(name: 'top_k') final int? topK,
      @JsonKey(name: 'frequency_penalty') final double? frequencyPenalty,
      @JsonKey(name: 'presence_penalty') final double? presencePenalty,
      @JsonKey(name: 'repetition_penalty') final double? repetitionPenalty,
      @JsonKey(name: 'min_p') final double? minProbability,
      @JsonKey(name: 'top_a') final double? topAnswer,
      @JsonKey(name: 'seed') final int? seed,
      @JsonKey(name: 'logit_bias') final Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') final bool? logProbabilities,
      @JsonKey(name: 'top_logprobs') final int? topLogProbabilities,
      @JsonKey(name: 'response_format')
      final Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') final List<int>? stop}) = _$ParametersImpl;

  factory _Parameters.fromJson(Map<String, dynamic> json) =
      _$ParametersImpl.fromJson;

  /// This sets the upper limit for the number of tokens the model can generate in response.
  /// It won't produce more than this limit.
  /// The maximum value is the context length minus the prompt length.
  @override
  @JsonKey(name: 'max_tokens')
  int? get maxTokens;

  /// This setting influences the variety in the model's responses.
  /// Lower values lead to more predictable and typical responses,
  /// while higher values encourage more diverse and less common responses.
  /// At 0, the model always gives the same response for a given input.
  ///
  /// Allowed values: 0.0 to 2.0
  /// Default: 1.0
  @override
  @JsonKey(name: 'temperature')
  double? get temperature;

  /// This setting limits the model's choices to a percentage of likely tokens:
  /// only the top tokens whose probabilities add up to P.
  /// A lower value makes the model's responses more predictable,
  /// while the default setting allows for a full range of token choices.
  /// Think of it like a dynamic Top-K.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 1.0
  @override
  @JsonKey(name: 'top_p')
  double? get topP;

  /// This limits the model's choice of tokens at each step, making it choose from a smaller set.
  /// A value of 1 means the model will always pick the most likely next token, leading to predictable results.
  /// By default this setting is disabled, making the model to consider all choices.
  ///
  /// Allowed values: 0 to 1
  /// Default: 0
  @override
  @JsonKey(name: 'top_k')
  int? get topK;

  /// This setting aims to control the repetition of tokens based on how often they appear in the input.
  /// It tries to use less frequently those tokens that appear more in the input,
  /// proportional to how frequently they occur.
  /// Token penalty scales with the number of occurrences.
  /// Negative values will encourage token reuse.
  ///
  /// Allowed values: -2.0 to 2.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'frequency_penalty')
  double? get frequencyPenalty;

  /// Adjusts how often the model repeats specific tokens already used in the input.
  /// Higher values make such repetition less likely, while negative values do the opposite.
  /// Token penalty does not scale with the number of occurrences.
  /// Negative values will encourage token reuse.
  ///
  /// Allowed values: -2.0 to 2.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'presence_penalty')
  double? get presencePenalty;

  /// Helps to reduce the repetition of tokens from the input.
  /// A higher value makes the model less likely to repeat tokens,
  /// but too high a value can make the output less coherent (often with run-on sentences that lack small words).
  /// Token penalty scales based on original token's probability.
  ///
  /// Allowed values: 0.0 to 2.0
  /// Default: 1.0
  @override
  @JsonKey(name: 'repetition_penalty')
  double? get repetitionPenalty;

  /// Represents the minimum probability for a token to be considered,
  /// relative to the probability of the most likely token.
  /// (The value changes depending on the confidence level of the most probable token.)
  /// If your Min-P is set to 0.1,
  /// that means it will only allow for tokens that are at least 1/10th as probable as the best possible option.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'min_p')
  double? get minProbability;

  /// Consider only the top tokens with "sufficiently high" probabilities based on the probability of the most likely token.
  /// Think of it like a dynamic Top-P.
  /// A lower Top-A value focuses the choices based on the highest probability token but with a narrower scope.
  /// A higher Top-A value does not necessarily affect the creativity of the output,
  /// but rather refines the filtering process based on the maximum probability.
  ///
  /// Allowed values: 0.0 to 1.0
  /// Default: 0.0
  @override
  @JsonKey(name: 'top_a')
  double? get topAnswer;

  /// If specified, the inferencing will sample deterministically,
  /// such that repeated requests with the same seed and parameters should return the same result.
  /// Determinism is not guaranteed for some models.
  @override
  @JsonKey(name: 'seed')
  int? get seed;

  /// Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer)
  /// to an associated bias value from -100 to 100. Mathematically,
  /// the bias is added to the logits generated by the model prior to sampling.
  /// The exact effect will vary per model, but values between -1 and 1 should decrease
  /// or increase likelihood of selection;
  /// values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
  @override
  @JsonKey(name: 'logit_bias')
  Map<String, int>? get logitBias;

  /// Whether to return log probabilities of the output tokens or not.
  /// If true, returns the log probabilities of each output token returned.
  @override
  @JsonKey(name: 'logprobs')
  bool? get logProbabilities;

  /// An integer between 0 and 20 specifying the number of most likely tokens to return at each token position,
  /// each with an associated log probability. logprobs must be set to true if this parameter is used.
  @override
  @JsonKey(name: 'top_logprobs')
  int? get topLogProbabilities;

  /// Forces the model to produce specific output format.
  /// Setting to { "type": "json_object" } enables JSON mode,
  /// which guarantees the message the model generates is valid JSON.
  ///  Note: when using JSON mode, you should also instruct the model to produce JSON yourself via a system or user message.
  @override
  @JsonKey(name: 'response_format')
  Map<String, String>? get responseFormat;

  /// Stop generation immediately if the model encounter any token specified in the stop array.
  @override
  @JsonKey(name: 'stop')
  List<int>? get stop;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParametersImplCopyWith<_$ParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageChunk _$MessageChunkFromJson(Map<String, dynamic> json) {
  return _MessageChunk.fromJson(json);
}

/// @nodoc
mixin _$MessageChunk {
  ChunkType get type => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  Usage? get usage => throw _privateConstructorUsedError;

  /// Serializes this MessageChunk to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageChunk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageChunkCopyWith<MessageChunk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageChunkCopyWith<$Res> {
  factory $MessageChunkCopyWith(
          MessageChunk value, $Res Function(MessageChunk) then) =
      _$MessageChunkCopyWithImpl<$Res, MessageChunk>;
  @useResult
  $Res call({ChunkType type, String? content, Usage? usage});

  $UsageCopyWith<$Res>? get usage;
}

/// @nodoc
class _$MessageChunkCopyWithImpl<$Res, $Val extends MessageChunk>
    implements $MessageChunkCopyWith<$Res> {
  _$MessageChunkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageChunk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = freezed,
    Object? usage = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChunkType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
    ) as $Val);
  }

  /// Create a copy of MessageChunk
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
abstract class _$$MessageChunkImplCopyWith<$Res>
    implements $MessageChunkCopyWith<$Res> {
  factory _$$MessageChunkImplCopyWith(
          _$MessageChunkImpl value, $Res Function(_$MessageChunkImpl) then) =
      __$$MessageChunkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChunkType type, String? content, Usage? usage});

  @override
  $UsageCopyWith<$Res>? get usage;
}

/// @nodoc
class __$$MessageChunkImplCopyWithImpl<$Res>
    extends _$MessageChunkCopyWithImpl<$Res, _$MessageChunkImpl>
    implements _$$MessageChunkImplCopyWith<$Res> {
  __$$MessageChunkImplCopyWithImpl(
      _$MessageChunkImpl _value, $Res Function(_$MessageChunkImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageChunk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = freezed,
    Object? usage = freezed,
  }) {
    return _then(_$MessageChunkImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChunkType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$MessageChunkImpl implements _MessageChunk {
  const _$MessageChunkImpl({required this.type, this.content, this.usage});

  factory _$MessageChunkImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageChunkImplFromJson(json);

  @override
  final ChunkType type;
  @override
  final String? content;
  @override
  final Usage? usage;

  @override
  String toString() {
    return 'MessageChunk(type: $type, content: $content, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageChunkImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, content, usage);

  /// Create a copy of MessageChunk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageChunkImplCopyWith<_$MessageChunkImpl> get copyWith =>
      __$$MessageChunkImplCopyWithImpl<_$MessageChunkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageChunkImplToJson(
      this,
    );
  }
}

abstract class _MessageChunk implements MessageChunk {
  const factory _MessageChunk(
      {required final ChunkType type,
      final String? content,
      final Usage? usage}) = _$MessageChunkImpl;

  factory _MessageChunk.fromJson(Map<String, dynamic> json) =
      _$MessageChunkImpl.fromJson;

  @override
  ChunkType get type;
  @override
  String? get content;
  @override
  Usage? get usage;

  /// Create a copy of MessageChunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageChunkImplCopyWith<_$MessageChunkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
