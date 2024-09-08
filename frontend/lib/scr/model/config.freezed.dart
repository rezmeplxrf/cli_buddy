// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) {
  return _Configuration.fromJson(json);
}

/// @nodoc
mixin _$Configuration {
  @JsonKey(name: 'secret_env_path', defaultValue: null)
  String? get secretEnvPath => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false, name: 'save_session')
  bool get saveSession => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_messages', defaultValue: 20)
  int get maxMessages => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
  String get defaultModel => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0.3, name: 'temperature')
  double get temperature => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'max_tokens')
  int? get maxTokens => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'top_p')
  int? get topP => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'top_k')
  int? get topK => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'frequency_penalty')
  double? get frequencyPenalty => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'presence_penalty')
  double? get presencePenalty => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'repetition_penalty')
  double? get repetitionPenalty => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'min_p')
  double? get minP => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'top_a')
  double? get topA => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'seed')
  int? get seed => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'logit_bias')
  Map<String, int>? get logitBias => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'logprobs')
  bool? get logprobs => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'top_logprobs')
  int? get topLogprobs => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'response_format')
  Map<String, dynamic>? get responseFormat =>
      throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'stop')
  List<dynamic>? get stop => throw _privateConstructorUsedError;
  @JsonKey(name: 'cmd_prompt')
  String? get cmdPrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'explain_prompt')
  String? get explainPrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_prompt')
  String? get codePrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_prompt')
  String? get chatPrompt => throw _privateConstructorUsedError;

  /// Serializes this Configuration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Configuration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigurationCopyWith<Configuration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigurationCopyWith<$Res> {
  factory $ConfigurationCopyWith(
          Configuration value, $Res Function(Configuration) then) =
      _$ConfigurationCopyWithImpl<$Res, Configuration>;
  @useResult
  $Res call(
      {@JsonKey(name: 'secret_env_path', defaultValue: null)
      String? secretEnvPath,
      @JsonKey(defaultValue: false, name: 'save_session') bool saveSession,
      @JsonKey(name: 'max_messages', defaultValue: 20) int maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
      String defaultModel,
      @JsonKey(defaultValue: 0.3, name: 'temperature') double temperature,
      @JsonKey(defaultValue: null, name: 'max_tokens') int? maxTokens,
      @JsonKey(defaultValue: null, name: 'top_p') int? topP,
      @JsonKey(defaultValue: null, name: 'top_k') int? topK,
      @JsonKey(defaultValue: null, name: 'frequency_penalty')
      double? frequencyPenalty,
      @JsonKey(defaultValue: null, name: 'presence_penalty')
      double? presencePenalty,
      @JsonKey(defaultValue: null, name: 'repetition_penalty')
      double? repetitionPenalty,
      @JsonKey(defaultValue: null, name: 'min_p') double? minP,
      @JsonKey(defaultValue: null, name: 'top_a') double? topA,
      @JsonKey(defaultValue: null, name: 'seed') int? seed,
      @JsonKey(defaultValue: null, name: 'logit_bias')
      Map<String, int>? logitBias,
      @JsonKey(defaultValue: null, name: 'logprobs') bool? logprobs,
      @JsonKey(defaultValue: null, name: 'top_logprobs') int? topLogprobs,
      @JsonKey(defaultValue: null, name: 'response_format')
      Map<String, dynamic>? responseFormat,
      @JsonKey(defaultValue: null, name: 'stop') List<dynamic>? stop,
      @JsonKey(name: 'cmd_prompt') String? cmdPrompt,
      @JsonKey(name: 'explain_prompt') String? explainPrompt,
      @JsonKey(name: 'code_prompt') String? codePrompt,
      @JsonKey(name: 'chat_prompt') String? chatPrompt});
}

/// @nodoc
class _$ConfigurationCopyWithImpl<$Res, $Val extends Configuration>
    implements $ConfigurationCopyWith<$Res> {
  _$ConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Configuration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secretEnvPath = freezed,
    Object? saveSession = null,
    Object? maxMessages = null,
    Object? defaultModel = null,
    Object? temperature = null,
    Object? maxTokens = freezed,
    Object? topP = freezed,
    Object? topK = freezed,
    Object? frequencyPenalty = freezed,
    Object? presencePenalty = freezed,
    Object? repetitionPenalty = freezed,
    Object? minP = freezed,
    Object? topA = freezed,
    Object? seed = freezed,
    Object? logitBias = freezed,
    Object? logprobs = freezed,
    Object? topLogprobs = freezed,
    Object? responseFormat = freezed,
    Object? stop = freezed,
    Object? cmdPrompt = freezed,
    Object? explainPrompt = freezed,
    Object? codePrompt = freezed,
    Object? chatPrompt = freezed,
  }) {
    return _then(_value.copyWith(
      secretEnvPath: freezed == secretEnvPath
          ? _value.secretEnvPath
          : secretEnvPath // ignore: cast_nullable_to_non_nullable
              as String?,
      saveSession: null == saveSession
          ? _value.saveSession
          : saveSession // ignore: cast_nullable_to_non_nullable
              as bool,
      maxMessages: null == maxMessages
          ? _value.maxMessages
          : maxMessages // ignore: cast_nullable_to_non_nullable
              as int,
      defaultModel: null == defaultModel
          ? _value.defaultModel
          : defaultModel // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      topP: freezed == topP
          ? _value.topP
          : topP // ignore: cast_nullable_to_non_nullable
              as int?,
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
      minP: freezed == minP
          ? _value.minP
          : minP // ignore: cast_nullable_to_non_nullable
              as double?,
      topA: freezed == topA
          ? _value.topA
          : topA // ignore: cast_nullable_to_non_nullable
              as double?,
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int?,
      logitBias: freezed == logitBias
          ? _value.logitBias
          : logitBias // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      logprobs: freezed == logprobs
          ? _value.logprobs
          : logprobs // ignore: cast_nullable_to_non_nullable
              as bool?,
      topLogprobs: freezed == topLogprobs
          ? _value.topLogprobs
          : topLogprobs // ignore: cast_nullable_to_non_nullable
              as int?,
      responseFormat: freezed == responseFormat
          ? _value.responseFormat
          : responseFormat // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      stop: freezed == stop
          ? _value.stop
          : stop // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      cmdPrompt: freezed == cmdPrompt
          ? _value.cmdPrompt
          : cmdPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      explainPrompt: freezed == explainPrompt
          ? _value.explainPrompt
          : explainPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      codePrompt: freezed == codePrompt
          ? _value.codePrompt
          : codePrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      chatPrompt: freezed == chatPrompt
          ? _value.chatPrompt
          : chatPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigurationImplCopyWith<$Res>
    implements $ConfigurationCopyWith<$Res> {
  factory _$$ConfigurationImplCopyWith(
          _$ConfigurationImpl value, $Res Function(_$ConfigurationImpl) then) =
      __$$ConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'secret_env_path', defaultValue: null)
      String? secretEnvPath,
      @JsonKey(defaultValue: false, name: 'save_session') bool saveSession,
      @JsonKey(name: 'max_messages', defaultValue: 20) int maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
      String defaultModel,
      @JsonKey(defaultValue: 0.3, name: 'temperature') double temperature,
      @JsonKey(defaultValue: null, name: 'max_tokens') int? maxTokens,
      @JsonKey(defaultValue: null, name: 'top_p') int? topP,
      @JsonKey(defaultValue: null, name: 'top_k') int? topK,
      @JsonKey(defaultValue: null, name: 'frequency_penalty')
      double? frequencyPenalty,
      @JsonKey(defaultValue: null, name: 'presence_penalty')
      double? presencePenalty,
      @JsonKey(defaultValue: null, name: 'repetition_penalty')
      double? repetitionPenalty,
      @JsonKey(defaultValue: null, name: 'min_p') double? minP,
      @JsonKey(defaultValue: null, name: 'top_a') double? topA,
      @JsonKey(defaultValue: null, name: 'seed') int? seed,
      @JsonKey(defaultValue: null, name: 'logit_bias')
      Map<String, int>? logitBias,
      @JsonKey(defaultValue: null, name: 'logprobs') bool? logprobs,
      @JsonKey(defaultValue: null, name: 'top_logprobs') int? topLogprobs,
      @JsonKey(defaultValue: null, name: 'response_format')
      Map<String, dynamic>? responseFormat,
      @JsonKey(defaultValue: null, name: 'stop') List<dynamic>? stop,
      @JsonKey(name: 'cmd_prompt') String? cmdPrompt,
      @JsonKey(name: 'explain_prompt') String? explainPrompt,
      @JsonKey(name: 'code_prompt') String? codePrompt,
      @JsonKey(name: 'chat_prompt') String? chatPrompt});
}

/// @nodoc
class __$$ConfigurationImplCopyWithImpl<$Res>
    extends _$ConfigurationCopyWithImpl<$Res, _$ConfigurationImpl>
    implements _$$ConfigurationImplCopyWith<$Res> {
  __$$ConfigurationImplCopyWithImpl(
      _$ConfigurationImpl _value, $Res Function(_$ConfigurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Configuration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secretEnvPath = freezed,
    Object? saveSession = null,
    Object? maxMessages = null,
    Object? defaultModel = null,
    Object? temperature = null,
    Object? maxTokens = freezed,
    Object? topP = freezed,
    Object? topK = freezed,
    Object? frequencyPenalty = freezed,
    Object? presencePenalty = freezed,
    Object? repetitionPenalty = freezed,
    Object? minP = freezed,
    Object? topA = freezed,
    Object? seed = freezed,
    Object? logitBias = freezed,
    Object? logprobs = freezed,
    Object? topLogprobs = freezed,
    Object? responseFormat = freezed,
    Object? stop = freezed,
    Object? cmdPrompt = freezed,
    Object? explainPrompt = freezed,
    Object? codePrompt = freezed,
    Object? chatPrompt = freezed,
  }) {
    return _then(_$ConfigurationImpl(
      secretEnvPath: freezed == secretEnvPath
          ? _value.secretEnvPath
          : secretEnvPath // ignore: cast_nullable_to_non_nullable
              as String?,
      saveSession: null == saveSession
          ? _value.saveSession
          : saveSession // ignore: cast_nullable_to_non_nullable
              as bool,
      maxMessages: null == maxMessages
          ? _value.maxMessages
          : maxMessages // ignore: cast_nullable_to_non_nullable
              as int,
      defaultModel: null == defaultModel
          ? _value.defaultModel
          : defaultModel // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      maxTokens: freezed == maxTokens
          ? _value.maxTokens
          : maxTokens // ignore: cast_nullable_to_non_nullable
              as int?,
      topP: freezed == topP
          ? _value.topP
          : topP // ignore: cast_nullable_to_non_nullable
              as int?,
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
      minP: freezed == minP
          ? _value.minP
          : minP // ignore: cast_nullable_to_non_nullable
              as double?,
      topA: freezed == topA
          ? _value.topA
          : topA // ignore: cast_nullable_to_non_nullable
              as double?,
      seed: freezed == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int?,
      logitBias: freezed == logitBias
          ? _value._logitBias
          : logitBias // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      logprobs: freezed == logprobs
          ? _value.logprobs
          : logprobs // ignore: cast_nullable_to_non_nullable
              as bool?,
      topLogprobs: freezed == topLogprobs
          ? _value.topLogprobs
          : topLogprobs // ignore: cast_nullable_to_non_nullable
              as int?,
      responseFormat: freezed == responseFormat
          ? _value._responseFormat
          : responseFormat // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      stop: freezed == stop
          ? _value._stop
          : stop // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      cmdPrompt: freezed == cmdPrompt
          ? _value.cmdPrompt
          : cmdPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      explainPrompt: freezed == explainPrompt
          ? _value.explainPrompt
          : explainPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      codePrompt: freezed == codePrompt
          ? _value.codePrompt
          : codePrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      chatPrompt: freezed == chatPrompt
          ? _value.chatPrompt
          : chatPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$ConfigurationImpl implements _Configuration {
  const _$ConfigurationImpl(
      {@JsonKey(name: 'secret_env_path', defaultValue: null)
      required this.secretEnvPath,
      @JsonKey(defaultValue: false, name: 'save_session')
      required this.saveSession,
      @JsonKey(name: 'max_messages', defaultValue: 20)
      required this.maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
      required this.defaultModel,
      @JsonKey(defaultValue: 0.3, name: 'temperature')
      required this.temperature,
      @JsonKey(defaultValue: null, name: 'max_tokens') this.maxTokens,
      @JsonKey(defaultValue: null, name: 'top_p') this.topP,
      @JsonKey(defaultValue: null, name: 'top_k') this.topK,
      @JsonKey(defaultValue: null, name: 'frequency_penalty')
      this.frequencyPenalty,
      @JsonKey(defaultValue: null, name: 'presence_penalty')
      this.presencePenalty,
      @JsonKey(defaultValue: null, name: 'repetition_penalty')
      this.repetitionPenalty,
      @JsonKey(defaultValue: null, name: 'min_p') this.minP,
      @JsonKey(defaultValue: null, name: 'top_a') this.topA,
      @JsonKey(defaultValue: null, name: 'seed') this.seed,
      @JsonKey(defaultValue: null, name: 'logit_bias')
      final Map<String, int>? logitBias,
      @JsonKey(defaultValue: null, name: 'logprobs') this.logprobs,
      @JsonKey(defaultValue: null, name: 'top_logprobs') this.topLogprobs,
      @JsonKey(defaultValue: null, name: 'response_format')
      final Map<String, dynamic>? responseFormat,
      @JsonKey(defaultValue: null, name: 'stop') final List<dynamic>? stop,
      @JsonKey(name: 'cmd_prompt') this.cmdPrompt,
      @JsonKey(name: 'explain_prompt') this.explainPrompt,
      @JsonKey(name: 'code_prompt') this.codePrompt,
      @JsonKey(name: 'chat_prompt') this.chatPrompt})
      : _logitBias = logitBias,
        _responseFormat = responseFormat,
        _stop = stop;

  factory _$ConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigurationImplFromJson(json);

  @override
  @JsonKey(name: 'secret_env_path', defaultValue: null)
  final String? secretEnvPath;
  @override
  @JsonKey(defaultValue: false, name: 'save_session')
  final bool saveSession;
  @override
  @JsonKey(name: 'max_messages', defaultValue: 20)
  final int maxMessages;
  @override
  @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
  final String defaultModel;
  @override
  @JsonKey(defaultValue: 0.3, name: 'temperature')
  final double temperature;
  @override
  @JsonKey(defaultValue: null, name: 'max_tokens')
  final int? maxTokens;
  @override
  @JsonKey(defaultValue: null, name: 'top_p')
  final int? topP;
  @override
  @JsonKey(defaultValue: null, name: 'top_k')
  final int? topK;
  @override
  @JsonKey(defaultValue: null, name: 'frequency_penalty')
  final double? frequencyPenalty;
  @override
  @JsonKey(defaultValue: null, name: 'presence_penalty')
  final double? presencePenalty;
  @override
  @JsonKey(defaultValue: null, name: 'repetition_penalty')
  final double? repetitionPenalty;
  @override
  @JsonKey(defaultValue: null, name: 'min_p')
  final double? minP;
  @override
  @JsonKey(defaultValue: null, name: 'top_a')
  final double? topA;
  @override
  @JsonKey(defaultValue: null, name: 'seed')
  final int? seed;
  final Map<String, int>? _logitBias;
  @override
  @JsonKey(defaultValue: null, name: 'logit_bias')
  Map<String, int>? get logitBias {
    final value = _logitBias;
    if (value == null) return null;
    if (_logitBias is EqualUnmodifiableMapView) return _logitBias;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(defaultValue: null, name: 'logprobs')
  final bool? logprobs;
  @override
  @JsonKey(defaultValue: null, name: 'top_logprobs')
  final int? topLogprobs;
  final Map<String, dynamic>? _responseFormat;
  @override
  @JsonKey(defaultValue: null, name: 'response_format')
  Map<String, dynamic>? get responseFormat {
    final value = _responseFormat;
    if (value == null) return null;
    if (_responseFormat is EqualUnmodifiableMapView) return _responseFormat;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<dynamic>? _stop;
  @override
  @JsonKey(defaultValue: null, name: 'stop')
  List<dynamic>? get stop {
    final value = _stop;
    if (value == null) return null;
    if (_stop is EqualUnmodifiableListView) return _stop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'cmd_prompt')
  final String? cmdPrompt;
  @override
  @JsonKey(name: 'explain_prompt')
  final String? explainPrompt;
  @override
  @JsonKey(name: 'code_prompt')
  final String? codePrompt;
  @override
  @JsonKey(name: 'chat_prompt')
  final String? chatPrompt;

  @override
  String toString() {
    return 'Configuration(secretEnvPath: $secretEnvPath, saveSession: $saveSession, maxMessages: $maxMessages, defaultModel: $defaultModel, temperature: $temperature, maxTokens: $maxTokens, topP: $topP, topK: $topK, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty, repetitionPenalty: $repetitionPenalty, minP: $minP, topA: $topA, seed: $seed, logitBias: $logitBias, logprobs: $logprobs, topLogprobs: $topLogprobs, responseFormat: $responseFormat, stop: $stop, cmdPrompt: $cmdPrompt, explainPrompt: $explainPrompt, codePrompt: $codePrompt, chatPrompt: $chatPrompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigurationImpl &&
            (identical(other.secretEnvPath, secretEnvPath) ||
                other.secretEnvPath == secretEnvPath) &&
            (identical(other.saveSession, saveSession) ||
                other.saveSession == saveSession) &&
            (identical(other.maxMessages, maxMessages) ||
                other.maxMessages == maxMessages) &&
            (identical(other.defaultModel, defaultModel) ||
                other.defaultModel == defaultModel) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.maxTokens, maxTokens) ||
                other.maxTokens == maxTokens) &&
            (identical(other.topP, topP) || other.topP == topP) &&
            (identical(other.topK, topK) || other.topK == topK) &&
            (identical(other.frequencyPenalty, frequencyPenalty) ||
                other.frequencyPenalty == frequencyPenalty) &&
            (identical(other.presencePenalty, presencePenalty) ||
                other.presencePenalty == presencePenalty) &&
            (identical(other.repetitionPenalty, repetitionPenalty) ||
                other.repetitionPenalty == repetitionPenalty) &&
            (identical(other.minP, minP) || other.minP == minP) &&
            (identical(other.topA, topA) || other.topA == topA) &&
            (identical(other.seed, seed) || other.seed == seed) &&
            const DeepCollectionEquality()
                .equals(other._logitBias, _logitBias) &&
            (identical(other.logprobs, logprobs) ||
                other.logprobs == logprobs) &&
            (identical(other.topLogprobs, topLogprobs) ||
                other.topLogprobs == topLogprobs) &&
            const DeepCollectionEquality()
                .equals(other._responseFormat, _responseFormat) &&
            const DeepCollectionEquality().equals(other._stop, _stop) &&
            (identical(other.cmdPrompt, cmdPrompt) ||
                other.cmdPrompt == cmdPrompt) &&
            (identical(other.explainPrompt, explainPrompt) ||
                other.explainPrompt == explainPrompt) &&
            (identical(other.codePrompt, codePrompt) ||
                other.codePrompt == codePrompt) &&
            (identical(other.chatPrompt, chatPrompt) ||
                other.chatPrompt == chatPrompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        secretEnvPath,
        saveSession,
        maxMessages,
        defaultModel,
        temperature,
        maxTokens,
        topP,
        topK,
        frequencyPenalty,
        presencePenalty,
        repetitionPenalty,
        minP,
        topA,
        seed,
        const DeepCollectionEquality().hash(_logitBias),
        logprobs,
        topLogprobs,
        const DeepCollectionEquality().hash(_responseFormat),
        const DeepCollectionEquality().hash(_stop),
        cmdPrompt,
        explainPrompt,
        codePrompt,
        chatPrompt
      ]);

  /// Create a copy of Configuration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigurationImplCopyWith<_$ConfigurationImpl> get copyWith =>
      __$$ConfigurationImplCopyWithImpl<_$ConfigurationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigurationImplToJson(
      this,
    );
  }
}

abstract class _Configuration implements Configuration {
  const factory _Configuration(
      {@JsonKey(name: 'secret_env_path', defaultValue: null)
      required final String? secretEnvPath,
      @JsonKey(defaultValue: false, name: 'save_session')
      required final bool saveSession,
      @JsonKey(name: 'max_messages', defaultValue: 20)
      required final int maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
      required final String defaultModel,
      @JsonKey(defaultValue: 0.3, name: 'temperature')
      required final double temperature,
      @JsonKey(defaultValue: null, name: 'max_tokens') final int? maxTokens,
      @JsonKey(defaultValue: null, name: 'top_p') final int? topP,
      @JsonKey(defaultValue: null, name: 'top_k') final int? topK,
      @JsonKey(defaultValue: null, name: 'frequency_penalty')
      final double? frequencyPenalty,
      @JsonKey(defaultValue: null, name: 'presence_penalty')
      final double? presencePenalty,
      @JsonKey(defaultValue: null, name: 'repetition_penalty')
      final double? repetitionPenalty,
      @JsonKey(defaultValue: null, name: 'min_p') final double? minP,
      @JsonKey(defaultValue: null, name: 'top_a') final double? topA,
      @JsonKey(defaultValue: null, name: 'seed') final int? seed,
      @JsonKey(defaultValue: null, name: 'logit_bias')
      final Map<String, int>? logitBias,
      @JsonKey(defaultValue: null, name: 'logprobs') final bool? logprobs,
      @JsonKey(defaultValue: null, name: 'top_logprobs') final int? topLogprobs,
      @JsonKey(defaultValue: null, name: 'response_format')
      final Map<String, dynamic>? responseFormat,
      @JsonKey(defaultValue: null, name: 'stop') final List<dynamic>? stop,
      @JsonKey(name: 'cmd_prompt') final String? cmdPrompt,
      @JsonKey(name: 'explain_prompt') final String? explainPrompt,
      @JsonKey(name: 'code_prompt') final String? codePrompt,
      @JsonKey(name: 'chat_prompt')
      final String? chatPrompt}) = _$ConfigurationImpl;

  factory _Configuration.fromJson(Map<String, dynamic> json) =
      _$ConfigurationImpl.fromJson;

  @override
  @JsonKey(name: 'secret_env_path', defaultValue: null)
  String? get secretEnvPath;
  @override
  @JsonKey(defaultValue: false, name: 'save_session')
  bool get saveSession;
  @override
  @JsonKey(name: 'max_messages', defaultValue: 20)
  int get maxMessages;
  @override
  @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
  String get defaultModel;
  @override
  @JsonKey(defaultValue: 0.3, name: 'temperature')
  double get temperature;
  @override
  @JsonKey(defaultValue: null, name: 'max_tokens')
  int? get maxTokens;
  @override
  @JsonKey(defaultValue: null, name: 'top_p')
  int? get topP;
  @override
  @JsonKey(defaultValue: null, name: 'top_k')
  int? get topK;
  @override
  @JsonKey(defaultValue: null, name: 'frequency_penalty')
  double? get frequencyPenalty;
  @override
  @JsonKey(defaultValue: null, name: 'presence_penalty')
  double? get presencePenalty;
  @override
  @JsonKey(defaultValue: null, name: 'repetition_penalty')
  double? get repetitionPenalty;
  @override
  @JsonKey(defaultValue: null, name: 'min_p')
  double? get minP;
  @override
  @JsonKey(defaultValue: null, name: 'top_a')
  double? get topA;
  @override
  @JsonKey(defaultValue: null, name: 'seed')
  int? get seed;
  @override
  @JsonKey(defaultValue: null, name: 'logit_bias')
  Map<String, int>? get logitBias;
  @override
  @JsonKey(defaultValue: null, name: 'logprobs')
  bool? get logprobs;
  @override
  @JsonKey(defaultValue: null, name: 'top_logprobs')
  int? get topLogprobs;
  @override
  @JsonKey(defaultValue: null, name: 'response_format')
  Map<String, dynamic>? get responseFormat;
  @override
  @JsonKey(defaultValue: null, name: 'stop')
  List<dynamic>? get stop;
  @override
  @JsonKey(name: 'cmd_prompt')
  String? get cmdPrompt;
  @override
  @JsonKey(name: 'explain_prompt')
  String? get explainPrompt;
  @override
  @JsonKey(name: 'code_prompt')
  String? get codePrompt;
  @override
  @JsonKey(name: 'chat_prompt')
  String? get chatPrompt;

  /// Create a copy of Configuration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigurationImplCopyWith<_$ConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SysPrompt _$SysPromptFromJson(Map<String, dynamic> json) {
  return _SysPrompt.fromJson(json);
}

/// @nodoc
mixin _$SysPrompt {
  String get name => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;

  /// Serializes this SysPrompt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SysPrompt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SysPromptCopyWith<SysPrompt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SysPromptCopyWith<$Res> {
  factory $SysPromptCopyWith(SysPrompt value, $Res Function(SysPrompt) then) =
      _$SysPromptCopyWithImpl<$Res, SysPrompt>;
  @useResult
  $Res call({String name, String prompt});
}

/// @nodoc
class _$SysPromptCopyWithImpl<$Res, $Val extends SysPrompt>
    implements $SysPromptCopyWith<$Res> {
  _$SysPromptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SysPrompt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? prompt = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SysPromptImplCopyWith<$Res>
    implements $SysPromptCopyWith<$Res> {
  factory _$$SysPromptImplCopyWith(
          _$SysPromptImpl value, $Res Function(_$SysPromptImpl) then) =
      __$$SysPromptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String prompt});
}

/// @nodoc
class __$$SysPromptImplCopyWithImpl<$Res>
    extends _$SysPromptCopyWithImpl<$Res, _$SysPromptImpl>
    implements _$$SysPromptImplCopyWith<$Res> {
  __$$SysPromptImplCopyWithImpl(
      _$SysPromptImpl _value, $Res Function(_$SysPromptImpl) _then)
      : super(_value, _then);

  /// Create a copy of SysPrompt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? prompt = null,
  }) {
    return _then(_$SysPromptImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SysPromptImpl implements _SysPrompt {
  const _$SysPromptImpl({required this.name, required this.prompt});

  factory _$SysPromptImpl.fromJson(Map<String, dynamic> json) =>
      _$$SysPromptImplFromJson(json);

  @override
  final String name;
  @override
  final String prompt;

  @override
  String toString() {
    return 'SysPrompt(name: $name, prompt: $prompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SysPromptImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, prompt);

  /// Create a copy of SysPrompt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SysPromptImplCopyWith<_$SysPromptImpl> get copyWith =>
      __$$SysPromptImplCopyWithImpl<_$SysPromptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SysPromptImplToJson(
      this,
    );
  }
}

abstract class _SysPrompt implements SysPrompt {
  const factory _SysPrompt(
      {required final String name,
      required final String prompt}) = _$SysPromptImpl;

  factory _SysPrompt.fromJson(Map<String, dynamic> json) =
      _$SysPromptImpl.fromJson;

  @override
  String get name;
  @override
  String get prompt;

  /// Create a copy of SysPrompt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SysPromptImplCopyWith<_$SysPromptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
