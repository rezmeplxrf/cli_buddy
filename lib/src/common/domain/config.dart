import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Configuration with _$Configuration {
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
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  void validate() {
    if (temperature < 0.0 || temperature > 2.0) {
      throw ArgumentError('Temperature must be between 0.0 and 2.0');
    }
    if (topP != null && (topP! < 0.0 || topP! > 1.0)) {
      throw ArgumentError('TopP must be between 0.0 and 1.0');
    }
    if (topK != null && topK! < 0) {
      throw ArgumentError('TopK must be 0 or above');
    }
    if (frequencyPenalty != null &&
        (frequencyPenalty! < -2.0 || frequencyPenalty! > 2.0)) {
      throw ArgumentError('FrequencyPenalty must be between -2.0 and 2.0');
    }
    if (presencePenalty != null &&
        (presencePenalty! < -2.0 || presencePenalty! > 2.0)) {
      throw ArgumentError('PresencePenalty must be between -2.0 and 2.0');
    }
    if (repetitionPenalty != null &&
        (repetitionPenalty! < 0.0 || repetitionPenalty! > 2.0)) {
      throw ArgumentError('RepetitionPenalty must be between 0.0 and 2.0');
    }
    if (minP != null && (minP! < 0.0 || minP! > 1.0)) {
      throw ArgumentError('MinP must be between 0.0 and 1.0');
    }
    if (topA != null && (topA! < 0.0 || topA! > 1.0)) {
      throw ArgumentError('TopA must be between 0.0 and 1.0');
    }
    if (maxTokens != null && maxTokens! < 1) {
      throw ArgumentError('MaxTokens must be 1 or above');
    }
    if (logitBias != null) {
      for (final value in logitBias!.values) {
        if (value < -100 || value > 100) {
          throw ArgumentError('LogitBias values must be between -100 and 100');
        }
      }
    }
    if (topLogprobs != null && (topLogprobs! < 0 || topLogprobs! > 20)) {
      throw ArgumentError('TopLogprobs must be between 0 and 20');
    }
  }
}
