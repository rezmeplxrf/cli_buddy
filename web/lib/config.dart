import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Configuration with _$Configuration {
    @JsonSerializable(includeIfNull: false)
  const factory Configuration({
    @JsonKey(name: 'secret_env_path', defaultValue: null)
    required String? secretEnvPath,
    @JsonKey(defaultValue: false, name: 'save_session')
    required bool saveSession,
    @JsonKey(name: 'max_messages', defaultValue: 20) required int maxMessages,
    @JsonKey(defaultValue: 'openai/gpt-4o', name: 'default_model')
    required String defaultModel,
    @JsonKey(defaultValue: 0.3, name: 'temperature')
    required double temperature,
    @JsonKey(defaultValue: null, name: 'max_tokens') int? maxTokens,
    @JsonKey(
      defaultValue: null,
      name: 'top_p',
    )
    int? topP,
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
    @JsonKey(
      name: 'cmd_prompt',
    )
    String? cmdPrompt,
    @JsonKey(
      name: 'explain_prompt',
    )
    String? explainPrompt,
    @JsonKey(
      name: 'code_prompt',
    )
    String? codePrompt,
    @JsonKey(
      name: 'chat_prompt',
    )
    String? chatPrompt,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}
