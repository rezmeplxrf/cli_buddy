// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_llm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  Role get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  Usage? get usage => throw _privateConstructorUsedError;

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
      {Role role, String content, int timestamp, String? model, Usage? usage});

  $UsageCopyWith<$Res>? get usage;
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
    Object? model = freezed,
    Object? usage = freezed,
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
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
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
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Role role, String content, int timestamp, String? model, Usage? usage});

  @override
  $UsageCopyWith<$Res>? get usage;
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
    Object? model = freezed,
    Object? usage = freezed,
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
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      usage: freezed == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage?,
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
      this.model,
      this.usage});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final Role role;
  @override
  final String content;
  @override
  final int timestamp;
  @override
  final String? model;
  @override
  final Usage? usage;

  @override
  String toString() {
    return 'Message(role: $role, content: $content, timestamp: $timestamp, model: $model, usage: $usage)';
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
            (identical(other.model, model) || other.model == model) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, role, content, timestamp, model, usage);

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
      final String? model,
      final Usage? usage}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  Role get role;
  @override
  String get content;
  @override
  int get timestamp;
  @override
  String? get model;
  @override
  Usage? get usage;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatSession _$ChatSessionFromJson(Map<String, dynamic> json) {
  return _ChatSession.fromJson(json);
}

/// @nodoc
mixin _$ChatSession {
  String get initialPrompt => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;

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
  $Res call({String initialPrompt, List<Message> messages});
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
    Object? initialPrompt = null,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      initialPrompt: null == initialPrompt
          ? _value.initialPrompt
          : initialPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ) as $Val);
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
  $Res call({String initialPrompt, List<Message> messages});
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
    Object? initialPrompt = null,
    Object? messages = null,
  }) {
    return _then(_$ChatSessionImpl(
      initialPrompt: null == initialPrompt
          ? _value.initialPrompt
          : initialPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$ChatSessionImpl implements _ChatSession {
  const _$ChatSessionImpl(
      {required this.initialPrompt, required final List<Message> messages})
      : _messages = messages;

  factory _$ChatSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatSessionImplFromJson(json);

  @override
  final String initialPrompt;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatSession(initialPrompt: $initialPrompt, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSessionImpl &&
            (identical(other.initialPrompt, initialPrompt) ||
                other.initialPrompt == initialPrompt) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, initialPrompt,
      const DeepCollectionEquality().hash(_messages));

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
      {required final String initialPrompt,
      required final List<Message> messages}) = _$ChatSessionImpl;

  factory _ChatSession.fromJson(Map<String, dynamic> json) =
      _$ChatSessionImpl.fromJson;

  @override
  String get initialPrompt;
  @override
  List<Message> get messages;

  /// Create a copy of ChatSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatSessionImplCopyWith<_$ChatSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Parameters _$ParametersFromJson(Map<String, dynamic> json) {
  return _Parameters.fromJson(json);
}

/// @nodoc
mixin _$Parameters {
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

  /// This sets the upper limit for the number of tokens the model can generate in response.
  /// It won't produce more than this limit.
  /// The maximum value is the context length minus the prompt length.
  @JsonKey(name: 'max_tokens')
  int? get maxTokens => throw _privateConstructorUsedError;

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

  /// Tool calling parameter.
  /// Will be passed down as-is for providers implementing OpenAI's interface.
  /// For providers with custom interfaces, we transform and map the properties.
  /// Otherwise, we transform the tools into a YAML template. The model responds with an assistant message.
  @JsonKey(name: 'tools')
  List<dynamic>? get tools => throw _privateConstructorUsedError;

  /// Controls which (if any) tool is called by the model.
  /// 'none' means the model will not call any tool and instead generates a message.
  /// 'auto' means the model can pick between generating a message or calling one or more tools.
  /// 'required' means the model must call one or more tools.
  /// Specifying a particular tool via {"type": "function", "function": {"name": "my_function"}} forces the model to call that tool.
  @JsonKey(name: 'tool_choice')
  List<dynamic>? get toolChoices => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'temperature') double? temperature,
      @JsonKey(name: 'top_p') double? topP,
      @JsonKey(name: 'top_k') int? topK,
      @JsonKey(name: 'frequency_penalty') double? frequencyPenalty,
      @JsonKey(name: 'presence_penalty') double? presencePenalty,
      @JsonKey(name: 'repetition_penalty') double? repetitionPenalty,
      @JsonKey(name: 'min_p') double? minProbability,
      @JsonKey(name: 'top_a') double? topAnswer,
      @JsonKey(name: 'seed') int? seed,
      @JsonKey(name: 'max_tokens') int? maxTokens,
      @JsonKey(name: 'logit_bias') Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') bool? logProbabilities,
      @JsonKey(name: 'top_logprobs') int? topLogProbabilities,
      @JsonKey(name: 'response_format') Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') List<int>? stop,
      @JsonKey(name: 'tools') List<dynamic>? tools,
      @JsonKey(name: 'tool_choice') List<dynamic>? toolChoices});
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
    Object? temperature = freezed,
    Object? topP = freezed,
    Object? topK = freezed,
    Object? frequencyPenalty = freezed,
    Object? presencePenalty = freezed,
    Object? repetitionPenalty = freezed,
    Object? minProbability = freezed,
    Object? topAnswer = freezed,
    Object? seed = freezed,
    Object? maxTokens = freezed,
    Object? logitBias = freezed,
    Object? logProbabilities = freezed,
    Object? topLogProbabilities = freezed,
    Object? responseFormat = freezed,
    Object? stop = freezed,
    Object? tools = freezed,
    Object? toolChoices = freezed,
  }) {
    return _then(_value.copyWith(
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
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
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
      tools: freezed == tools
          ? _value.tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      toolChoices: freezed == toolChoices
          ? _value.toolChoices
          : toolChoices // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
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
      {@JsonKey(name: 'temperature') double? temperature,
      @JsonKey(name: 'top_p') double? topP,
      @JsonKey(name: 'top_k') int? topK,
      @JsonKey(name: 'frequency_penalty') double? frequencyPenalty,
      @JsonKey(name: 'presence_penalty') double? presencePenalty,
      @JsonKey(name: 'repetition_penalty') double? repetitionPenalty,
      @JsonKey(name: 'min_p') double? minProbability,
      @JsonKey(name: 'top_a') double? topAnswer,
      @JsonKey(name: 'seed') int? seed,
      @JsonKey(name: 'max_tokens') int? maxTokens,
      @JsonKey(name: 'logit_bias') Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') bool? logProbabilities,
      @JsonKey(name: 'top_logprobs') int? topLogProbabilities,
      @JsonKey(name: 'response_format') Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') List<int>? stop,
      @JsonKey(name: 'tools') List<dynamic>? tools,
      @JsonKey(name: 'tool_choice') List<dynamic>? toolChoices});
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
    Object? temperature = freezed,
    Object? topP = freezed,
    Object? topK = freezed,
    Object? frequencyPenalty = freezed,
    Object? presencePenalty = freezed,
    Object? repetitionPenalty = freezed,
    Object? minProbability = freezed,
    Object? topAnswer = freezed,
    Object? seed = freezed,
    Object? maxTokens = freezed,
    Object? logitBias = freezed,
    Object? logProbabilities = freezed,
    Object? topLogProbabilities = freezed,
    Object? responseFormat = freezed,
    Object? stop = freezed,
    Object? tools = freezed,
    Object? toolChoices = freezed,
  }) {
    return _then(_$ParametersImpl(
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
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
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
      tools: freezed == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      toolChoices: freezed == toolChoices
          ? _value._toolChoices
          : toolChoices // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$ParametersImpl implements _Parameters {
  const _$ParametersImpl(
      {@JsonKey(name: 'temperature') this.temperature,
      @JsonKey(name: 'top_p') this.topP,
      @JsonKey(name: 'top_k') this.topK,
      @JsonKey(name: 'frequency_penalty') this.frequencyPenalty,
      @JsonKey(name: 'presence_penalty') this.presencePenalty,
      @JsonKey(name: 'repetition_penalty') this.repetitionPenalty,
      @JsonKey(name: 'min_p') this.minProbability,
      @JsonKey(name: 'top_a') this.topAnswer,
      @JsonKey(name: 'seed') this.seed,
      @JsonKey(name: 'max_tokens') this.maxTokens,
      @JsonKey(name: 'logit_bias') final Map<String, int>? logitBias,
      @JsonKey(name: 'logprobs') this.logProbabilities,
      @JsonKey(name: 'top_logprobs') this.topLogProbabilities,
      @JsonKey(name: 'response_format')
      final Map<String, String>? responseFormat,
      @JsonKey(name: 'stop') final List<int>? stop,
      @JsonKey(name: 'tools') final List<dynamic>? tools,
      @JsonKey(name: 'tool_choice') final List<dynamic>? toolChoices})
      : _logitBias = logitBias,
        _responseFormat = responseFormat,
        _stop = stop,
        _tools = tools,
        _toolChoices = toolChoices;

  factory _$ParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParametersImplFromJson(json);

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

  /// This sets the upper limit for the number of tokens the model can generate in response.
  /// It won't produce more than this limit.
  /// The maximum value is the context length minus the prompt length.
  @override
  @JsonKey(name: 'max_tokens')
  final int? maxTokens;

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

  /// Tool calling parameter.
  /// Will be passed down as-is for providers implementing OpenAI's interface.
  /// For providers with custom interfaces, we transform and map the properties.
  /// Otherwise, we transform the tools into a YAML template. The model responds with an assistant message.
  final List<dynamic>? _tools;

  /// Tool calling parameter.
  /// Will be passed down as-is for providers implementing OpenAI's interface.
  /// For providers with custom interfaces, we transform and map the properties.
  /// Otherwise, we transform the tools into a YAML template. The model responds with an assistant message.
  @override
  @JsonKey(name: 'tools')
  List<dynamic>? get tools {
    final value = _tools;
    if (value == null) return null;
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Controls which (if any) tool is called by the model.
  /// 'none' means the model will not call any tool and instead generates a message.
  /// 'auto' means the model can pick between generating a message or calling one or more tools.
  /// 'required' means the model must call one or more tools.
  /// Specifying a particular tool via {"type": "function", "function": {"name": "my_function"}} forces the model to call that tool.
  final List<dynamic>? _toolChoices;

  /// Controls which (if any) tool is called by the model.
  /// 'none' means the model will not call any tool and instead generates a message.
  /// 'auto' means the model can pick between generating a message or calling one or more tools.
  /// 'required' means the model must call one or more tools.
  /// Specifying a particular tool via {"type": "function", "function": {"name": "my_function"}} forces the model to call that tool.
  @override
  @JsonKey(name: 'tool_choice')
  List<dynamic>? get toolChoices {
    final value = _toolChoices;
    if (value == null) return null;
    if (_toolChoices is EqualUnmodifiableListView) return _toolChoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Parameters(temperature: $temperature, topP: $topP, topK: $topK, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty, repetitionPenalty: $repetitionPenalty, minProbability: $minProbability, topAnswer: $topAnswer, seed: $seed, maxTokens: $maxTokens, logitBias: $logitBias, logProbabilities: $logProbabilities, topLogProbabilities: $topLogProbabilities, responseFormat: $responseFormat, stop: $stop, tools: $tools, toolChoices: $toolChoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParametersImpl &&
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
            (identical(other.maxTokens, maxTokens) ||
                other.maxTokens == maxTokens) &&
            const DeepCollectionEquality()
                .equals(other._logitBias, _logitBias) &&
            (identical(other.logProbabilities, logProbabilities) ||
                other.logProbabilities == logProbabilities) &&
            (identical(other.topLogProbabilities, topLogProbabilities) ||
                other.topLogProbabilities == topLogProbabilities) &&
            const DeepCollectionEquality()
                .equals(other._responseFormat, _responseFormat) &&
            const DeepCollectionEquality().equals(other._stop, _stop) &&
            const DeepCollectionEquality().equals(other._tools, _tools) &&
            const DeepCollectionEquality()
                .equals(other._toolChoices, _toolChoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      temperature,
      topP,
      topK,
      frequencyPenalty,
      presencePenalty,
      repetitionPenalty,
      minProbability,
      topAnswer,
      seed,
      maxTokens,
      const DeepCollectionEquality().hash(_logitBias),
      logProbabilities,
      topLogProbabilities,
      const DeepCollectionEquality().hash(_responseFormat),
      const DeepCollectionEquality().hash(_stop),
      const DeepCollectionEquality().hash(_tools),
      const DeepCollectionEquality().hash(_toolChoices));

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
          {@JsonKey(name: 'temperature') final double? temperature,
          @JsonKey(name: 'top_p') final double? topP,
          @JsonKey(name: 'top_k') final int? topK,
          @JsonKey(name: 'frequency_penalty') final double? frequencyPenalty,
          @JsonKey(name: 'presence_penalty') final double? presencePenalty,
          @JsonKey(name: 'repetition_penalty') final double? repetitionPenalty,
          @JsonKey(name: 'min_p') final double? minProbability,
          @JsonKey(name: 'top_a') final double? topAnswer,
          @JsonKey(name: 'seed') final int? seed,
          @JsonKey(name: 'max_tokens') final int? maxTokens,
          @JsonKey(name: 'logit_bias') final Map<String, int>? logitBias,
          @JsonKey(name: 'logprobs') final bool? logProbabilities,
          @JsonKey(name: 'top_logprobs') final int? topLogProbabilities,
          @JsonKey(name: 'response_format')
          final Map<String, String>? responseFormat,
          @JsonKey(name: 'stop') final List<int>? stop,
          @JsonKey(name: 'tools') final List<dynamic>? tools,
          @JsonKey(name: 'tool_choice') final List<dynamic>? toolChoices}) =
      _$ParametersImpl;

  factory _Parameters.fromJson(Map<String, dynamic> json) =
      _$ParametersImpl.fromJson;

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

  /// This sets the upper limit for the number of tokens the model can generate in response.
  /// It won't produce more than this limit.
  /// The maximum value is the context length minus the prompt length.
  @override
  @JsonKey(name: 'max_tokens')
  int? get maxTokens;

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

  /// Tool calling parameter.
  /// Will be passed down as-is for providers implementing OpenAI's interface.
  /// For providers with custom interfaces, we transform and map the properties.
  /// Otherwise, we transform the tools into a YAML template. The model responds with an assistant message.
  @override
  @JsonKey(name: 'tools')
  List<dynamic>? get tools;

  /// Controls which (if any) tool is called by the model.
  /// 'none' means the model will not call any tool and instead generates a message.
  /// 'auto' means the model can pick between generating a message or calling one or more tools.
  /// 'required' means the model must call one or more tools.
  /// Specifying a particular tool via {"type": "function", "function": {"name": "my_function"}} forces the model to call that tool.
  @override
  @JsonKey(name: 'tool_choice')
  List<dynamic>? get toolChoices;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParametersImplCopyWith<_$ParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
