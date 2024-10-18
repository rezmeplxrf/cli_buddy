import '../service/prompts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

enum APIProvider { openrouter,  ollama }

@freezed
class Configuration with _$Configuration {
  @JsonSerializable(includeIfNull: true)
  const factory Configuration({
    @JsonKey(defaultValue: APIProvider.openrouter, name: 'api_provider')
    required APIProvider apiProvider,
    @JsonKey(defaultValue: 'localhost:43210') required String localEndpoint,
    @JsonKey(defaultValue: true, name: 'save_session')
    required bool saveSession,
    @JsonKey(defaultValue: false, name: 'save_online') required bool saveOnline,
    @JsonKey(name: 'max_messages', defaultValue: 20) required int maxMessages,
    @JsonKey(defaultValue: 'openai/gpt-4o', name: 'openrouter_default_model')
    String? openrouterDefaultModel,
    @JsonKey(defaultValue: null, name: 'ollama_default_model')
    String? ollamaDefaultModel,
    @JsonKey(defaultValue: 'localhost:11434') String? ollamaEndpoint,
    @JsonKey(name: 'openrouter_key', defaultValue: null) String? openrouterKey,
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
    String? validatePrompt,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}

@freezed
class SysPrompt with _$SysPrompt {
  const factory SysPrompt(
      {required String name,
      required String prompt,
      String? modelId}) = _SysPrompt;

  factory SysPrompt.fromJson(Map<String, Object?> json) =>
      _$SysPromptFromJson(json);
}
