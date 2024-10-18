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
  @JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
  APIProvider get apiProvider => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'localhost:43210')
  String get localEndpoint => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: true, name: 'save_session')
  bool get saveSession => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false, name: 'save_online')
  bool get saveOnline => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_messages', defaultValue: 20)
  int get maxMessages => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
  String? get openrouterDefaultModel => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'ollama_default_model')
  String? get ollamaDefaultModel => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'localhost:11434')
  String? get ollamaEndpoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'openrouter_key', defaultValue: null)
  String? get openrouterKey => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: null, name: 'temperature')
  double? get temperature => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
  String? get cmdPrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
  String? get explainPrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
  String? get codePrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
  String? get chatPrompt => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
  String? get validatePrompt => throw _privateConstructorUsedError;

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
      {@JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
      APIProvider apiProvider,
      @JsonKey(defaultValue: 'localhost:43210') String localEndpoint,
      @JsonKey(defaultValue: true, name: 'save_session') bool saveSession,
      @JsonKey(defaultValue: false, name: 'save_online') bool saveOnline,
      @JsonKey(name: 'max_messages', defaultValue: 20) int maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
      String? openrouterDefaultModel,
      @JsonKey(defaultValue: null, name: 'ollama_default_model')
      String? ollamaDefaultModel,
      @JsonKey(defaultValue: 'localhost:11434') String? ollamaEndpoint,
      @JsonKey(name: 'openrouter_key', defaultValue: null)
      String? openrouterKey,
      @JsonKey(defaultValue: null, name: 'temperature') double? temperature,
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
      @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
      String? cmdPrompt,
      @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
      String? explainPrompt,
      @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
      String? codePrompt,
      @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
      String? chatPrompt,
      @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
      String? validatePrompt});
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
    Object? apiProvider = null,
    Object? localEndpoint = null,
    Object? saveSession = null,
    Object? saveOnline = null,
    Object? maxMessages = null,
    Object? openrouterDefaultModel = freezed,
    Object? ollamaDefaultModel = freezed,
    Object? ollamaEndpoint = freezed,
    Object? openrouterKey = freezed,
    Object? temperature = freezed,
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
    Object? validatePrompt = freezed,
  }) {
    return _then(_value.copyWith(
      apiProvider: null == apiProvider
          ? _value.apiProvider
          : apiProvider // ignore: cast_nullable_to_non_nullable
              as APIProvider,
      localEndpoint: null == localEndpoint
          ? _value.localEndpoint
          : localEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      saveSession: null == saveSession
          ? _value.saveSession
          : saveSession // ignore: cast_nullable_to_non_nullable
              as bool,
      saveOnline: null == saveOnline
          ? _value.saveOnline
          : saveOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      maxMessages: null == maxMessages
          ? _value.maxMessages
          : maxMessages // ignore: cast_nullable_to_non_nullable
              as int,
      openrouterDefaultModel: freezed == openrouterDefaultModel
          ? _value.openrouterDefaultModel
          : openrouterDefaultModel // ignore: cast_nullable_to_non_nullable
              as String?,
      ollamaDefaultModel: freezed == ollamaDefaultModel
          ? _value.ollamaDefaultModel
          : ollamaDefaultModel // ignore: cast_nullable_to_non_nullable
              as String?,
      ollamaEndpoint: freezed == ollamaEndpoint
          ? _value.ollamaEndpoint
          : ollamaEndpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      openrouterKey: freezed == openrouterKey
          ? _value.openrouterKey
          : openrouterKey // ignore: cast_nullable_to_non_nullable
              as String?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
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
      validatePrompt: freezed == validatePrompt
          ? _value.validatePrompt
          : validatePrompt // ignore: cast_nullable_to_non_nullable
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
      {@JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
      APIProvider apiProvider,
      @JsonKey(defaultValue: 'localhost:43210') String localEndpoint,
      @JsonKey(defaultValue: true, name: 'save_session') bool saveSession,
      @JsonKey(defaultValue: false, name: 'save_online') bool saveOnline,
      @JsonKey(name: 'max_messages', defaultValue: 20) int maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
      String? openrouterDefaultModel,
      @JsonKey(defaultValue: null, name: 'ollama_default_model')
      String? ollamaDefaultModel,
      @JsonKey(defaultValue: 'localhost:11434') String? ollamaEndpoint,
      @JsonKey(name: 'openrouter_key', defaultValue: null)
      String? openrouterKey,
      @JsonKey(defaultValue: null, name: 'temperature') double? temperature,
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
      @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
      String? cmdPrompt,
      @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
      String? explainPrompt,
      @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
      String? codePrompt,
      @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
      String? chatPrompt,
      @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
      String? validatePrompt});
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
    Object? apiProvider = null,
    Object? localEndpoint = null,
    Object? saveSession = null,
    Object? saveOnline = null,
    Object? maxMessages = null,
    Object? openrouterDefaultModel = freezed,
    Object? ollamaDefaultModel = freezed,
    Object? ollamaEndpoint = freezed,
    Object? openrouterKey = freezed,
    Object? temperature = freezed,
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
    Object? validatePrompt = freezed,
  }) {
    return _then(_$ConfigurationImpl(
      apiProvider: null == apiProvider
          ? _value.apiProvider
          : apiProvider // ignore: cast_nullable_to_non_nullable
              as APIProvider,
      localEndpoint: null == localEndpoint
          ? _value.localEndpoint
          : localEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      saveSession: null == saveSession
          ? _value.saveSession
          : saveSession // ignore: cast_nullable_to_non_nullable
              as bool,
      saveOnline: null == saveOnline
          ? _value.saveOnline
          : saveOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      maxMessages: null == maxMessages
          ? _value.maxMessages
          : maxMessages // ignore: cast_nullable_to_non_nullable
              as int,
      openrouterDefaultModel: freezed == openrouterDefaultModel
          ? _value.openrouterDefaultModel
          : openrouterDefaultModel // ignore: cast_nullable_to_non_nullable
              as String?,
      ollamaDefaultModel: freezed == ollamaDefaultModel
          ? _value.ollamaDefaultModel
          : ollamaDefaultModel // ignore: cast_nullable_to_non_nullable
              as String?,
      ollamaEndpoint: freezed == ollamaEndpoint
          ? _value.ollamaEndpoint
          : ollamaEndpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      openrouterKey: freezed == openrouterKey
          ? _value.openrouterKey
          : openrouterKey // ignore: cast_nullable_to_non_nullable
              as String?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
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
      validatePrompt: freezed == validatePrompt
          ? _value.validatePrompt
          : validatePrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: true)
class _$ConfigurationImpl implements _Configuration {
  const _$ConfigurationImpl(
      {@JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
      required this.apiProvider,
      @JsonKey(defaultValue: 'localhost:43210') required this.localEndpoint,
      @JsonKey(defaultValue: true, name: 'save_session')
      required this.saveSession,
      @JsonKey(defaultValue: false, name: 'save_online')
      required this.saveOnline,
      @JsonKey(name: 'max_messages', defaultValue: 20)
      required this.maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
      this.openrouterDefaultModel,
      @JsonKey(defaultValue: null, name: 'ollama_default_model')
      this.ollamaDefaultModel,
      @JsonKey(defaultValue: 'localhost:11434') this.ollamaEndpoint,
      @JsonKey(name: 'openrouter_key', defaultValue: null) this.openrouterKey,
      @JsonKey(defaultValue: null, name: 'temperature') this.temperature,
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
      @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
      this.cmdPrompt,
      @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
      this.explainPrompt,
      @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
      this.codePrompt,
      @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
      this.chatPrompt,
      @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
      this.validatePrompt})
      : _logitBias = logitBias,
        _responseFormat = responseFormat,
        _stop = stop;

  factory _$ConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigurationImplFromJson(json);

  @override
  @JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
  final APIProvider apiProvider;
  @override
  @JsonKey(defaultValue: 'localhost:43210')
  final String localEndpoint;
  @override
  @JsonKey(defaultValue: true, name: 'save_session')
  final bool saveSession;
  @override
  @JsonKey(defaultValue: false, name: 'save_online')
  final bool saveOnline;
  @override
  @JsonKey(name: 'max_messages', defaultValue: 20)
  final int maxMessages;
  @override
  @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
  final String? openrouterDefaultModel;
  @override
  @JsonKey(defaultValue: null, name: 'ollama_default_model')
  final String? ollamaDefaultModel;
  @override
  @JsonKey(defaultValue: 'localhost:11434')
  final String? ollamaEndpoint;
  @override
  @JsonKey(name: 'openrouter_key', defaultValue: null)
  final String? openrouterKey;
  @override
  @JsonKey(defaultValue: null, name: 'temperature')
  final double? temperature;
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
  @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
  final String? cmdPrompt;
  @override
  @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
  final String? explainPrompt;
  @override
  @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
  final String? codePrompt;
  @override
  @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
  final String? chatPrompt;
  @override
  @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
  final String? validatePrompt;

  @override
  String toString() {
    return 'Configuration(apiProvider: $apiProvider, localEndpoint: $localEndpoint, saveSession: $saveSession, saveOnline: $saveOnline, maxMessages: $maxMessages, openrouterDefaultModel: $openrouterDefaultModel, ollamaDefaultModel: $ollamaDefaultModel, ollamaEndpoint: $ollamaEndpoint, openrouterKey: $openrouterKey, temperature: $temperature, maxTokens: $maxTokens, topP: $topP, topK: $topK, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty, repetitionPenalty: $repetitionPenalty, minP: $minP, topA: $topA, seed: $seed, logitBias: $logitBias, logprobs: $logprobs, topLogprobs: $topLogprobs, responseFormat: $responseFormat, stop: $stop, cmdPrompt: $cmdPrompt, explainPrompt: $explainPrompt, codePrompt: $codePrompt, chatPrompt: $chatPrompt, validatePrompt: $validatePrompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigurationImpl &&
            (identical(other.apiProvider, apiProvider) ||
                other.apiProvider == apiProvider) &&
            (identical(other.localEndpoint, localEndpoint) ||
                other.localEndpoint == localEndpoint) &&
            (identical(other.saveSession, saveSession) ||
                other.saveSession == saveSession) &&
            (identical(other.saveOnline, saveOnline) ||
                other.saveOnline == saveOnline) &&
            (identical(other.maxMessages, maxMessages) ||
                other.maxMessages == maxMessages) &&
            (identical(other.openrouterDefaultModel, openrouterDefaultModel) ||
                other.openrouterDefaultModel == openrouterDefaultModel) &&
            (identical(other.ollamaDefaultModel, ollamaDefaultModel) ||
                other.ollamaDefaultModel == ollamaDefaultModel) &&
            (identical(other.ollamaEndpoint, ollamaEndpoint) ||
                other.ollamaEndpoint == ollamaEndpoint) &&
            (identical(other.openrouterKey, openrouterKey) ||
                other.openrouterKey == openrouterKey) &&
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
                other.chatPrompt == chatPrompt) &&
            (identical(other.validatePrompt, validatePrompt) ||
                other.validatePrompt == validatePrompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        apiProvider,
        localEndpoint,
        saveSession,
        saveOnline,
        maxMessages,
        openrouterDefaultModel,
        ollamaDefaultModel,
        ollamaEndpoint,
        openrouterKey,
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
        chatPrompt,
        validatePrompt
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
      {@JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
      required final APIProvider apiProvider,
      @JsonKey(defaultValue: 'localhost:43210')
      required final String localEndpoint,
      @JsonKey(defaultValue: true, name: 'save_session')
      required final bool saveSession,
      @JsonKey(defaultValue: false, name: 'save_online')
      required final bool saveOnline,
      @JsonKey(name: 'max_messages', defaultValue: 20)
      required final int maxMessages,
      @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
      final String? openrouterDefaultModel,
      @JsonKey(defaultValue: null, name: 'ollama_default_model')
      final String? ollamaDefaultModel,
      @JsonKey(defaultValue: 'localhost:11434') final String? ollamaEndpoint,
      @JsonKey(name: 'openrouter_key', defaultValue: null)
      final String? openrouterKey,
      @JsonKey(defaultValue: null, name: 'temperature')
      final double? temperature,
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
      @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
      final String? cmdPrompt,
      @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
      final String? explainPrompt,
      @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
      final String? codePrompt,
      @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
      final String? chatPrompt,
      @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
      final String? validatePrompt}) = _$ConfigurationImpl;

  factory _Configuration.fromJson(Map<String, dynamic> json) =
      _$ConfigurationImpl.fromJson;

  @override
  @JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
  APIProvider get apiProvider;
  @override
  @JsonKey(defaultValue: 'localhost:43210')
  String get localEndpoint;
  @override
  @JsonKey(defaultValue: true, name: 'save_session')
  bool get saveSession;
  @override
  @JsonKey(defaultValue: false, name: 'save_online')
  bool get saveOnline;
  @override
  @JsonKey(name: 'max_messages', defaultValue: 20)
  int get maxMessages;
  @override
  @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
  String? get openrouterDefaultModel;
  @override
  @JsonKey(defaultValue: null, name: 'ollama_default_model')
  String? get ollamaDefaultModel;
  @override
  @JsonKey(defaultValue: 'localhost:11434')
  String? get ollamaEndpoint;
  @override
  @JsonKey(name: 'openrouter_key', defaultValue: null)
  String? get openrouterKey;
  @override
  @JsonKey(defaultValue: null, name: 'temperature')
  double? get temperature;
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
  @JsonKey(name: 'cmd_prompt', defaultValue: defaultCommandPrompt)
  String? get cmdPrompt;
  @override
  @JsonKey(name: 'explain_prompt', defaultValue: defaultExplainPrompt)
  String? get explainPrompt;
  @override
  @JsonKey(name: 'code_prompt', defaultValue: defaultCodePrompt)
  String? get codePrompt;
  @override
  @JsonKey(name: 'chat_prompt', defaultValue: defaultChatPrompt)
  String? get chatPrompt;
  @override
  @JsonKey(defaultValue: defaultValidatePrompt, name: 'validate_prompt')
  String? get validatePrompt;

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
  String? get modelId => throw _privateConstructorUsedError;

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
  $Res call({String name, String prompt, String? modelId});
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
    Object? modelId = freezed,
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
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({String name, String prompt, String? modelId});
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
    Object? modelId = freezed,
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
      modelId: freezed == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SysPromptImpl implements _SysPrompt {
  const _$SysPromptImpl(
      {required this.name, required this.prompt, this.modelId});

  factory _$SysPromptImpl.fromJson(Map<String, dynamic> json) =>
      _$$SysPromptImplFromJson(json);

  @override
  final String name;
  @override
  final String prompt;
  @override
  final String? modelId;

  @override
  String toString() {
    return 'SysPrompt(name: $name, prompt: $prompt, modelId: $modelId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SysPromptImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.modelId, modelId) || other.modelId == modelId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, prompt, modelId);

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
      required final String prompt,
      final String? modelId}) = _$SysPromptImpl;

  factory _SysPrompt.fromJson(Map<String, dynamic> json) =
      _$SysPromptImpl.fromJson;

  @override
  String get name;
  @override
  String get prompt;
  @override
  String? get modelId;

  /// Create a copy of SysPrompt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SysPromptImplCopyWith<_$SysPromptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
