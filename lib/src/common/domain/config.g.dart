// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigurationImpl _$$ConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$ConfigurationImpl(
      apiProvider:
          $enumDecodeNullable(_$APIProviderEnumMap, json['api_provider']) ??
              APIProvider.openrouter,
      localEndpoint: json['localEndpoint'] as String? ?? 'localhost:43210',
      saveSession: json['save_session'] as bool? ?? true,
      saveOnline: json['save_online'] as bool? ?? false,
      isLocal: json['local_web'] as bool? ?? true,
      maxMessages: (json['max_messages'] as num?)?.toInt() ?? 20,
      openrouterDefaultModel:
          json['openrouter_default_model'] as String? ?? 'openai/gpt-4o',
      buddyDefaultModel:
          json['buddy_default_model'] as String? ?? 'openai/gpt-4o',
      buddyKey: json['buddy_key'] as String?,
      ollamaDefaultModel: json['ollama_default_model'] as String?,
      ollamaEndpoint: json['ollamaEndpoint'] as String? ?? 'localhost:11434',
      openrouterKey: json['openrouter_key'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      maxTokens: (json['max_tokens'] as num?)?.toInt(),
      topP: (json['top_p'] as num?)?.toInt(),
      topK: (json['top_k'] as num?)?.toInt(),
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble(),
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble(),
      repetitionPenalty: (json['repetition_penalty'] as num?)?.toDouble(),
      minP: (json['min_p'] as num?)?.toDouble(),
      topA: (json['top_a'] as num?)?.toDouble(),
      seed: (json['seed'] as num?)?.toInt(),
      logitBias: (json['logit_bias'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      logprobs: json['logprobs'] as bool?,
      topLogprobs: (json['top_logprobs'] as num?)?.toInt(),
      responseFormat: json['response_format'] as Map<String, dynamic>?,
      stop: json['stop'] as List<dynamic>?,
      cmdPrompt: json['cmd_prompt'] as String? ??
          'If there is a lack of details, provide most logical solution.\nEnsure the output is a valid shell command.\nIf multiple steps required try to combine them together in one command.\nProvide only plain text without Markdown formatting.\nDo not provide markdown formatting such as ```.',
      explainPrompt: json['explain_prompt'] as String? ??
          'Provide short and concise explanation of your previous response about command or code.\nProvide only plain text without Markdown formatting.\nDo not provide markdown formatting such as ```.',
      codePrompt: json['code_prompt'] as String? ??
          'Provide only code as output without any description.\nProvide only code in plain text format without Markdown formatting.\nDo not include symbols such as ``` or ```python.\nIf there is a lack of details, provide most logical solution.\nYou are not allowed to ask for more details.\nFor example if the prompt is "Hello world Python", you should return "print(\'Hello world\')".',
      chatPrompt: json['chat_prompt'] as String? ??
          'You are a helpful assistant.\nProvide concise response unless asked for more details.',
    );

Map<String, dynamic> _$$ConfigurationImplToJson(_$ConfigurationImpl instance) {
  final val = <String, dynamic>{
    'api_provider': _$APIProviderEnumMap[instance.apiProvider]!,
    'localEndpoint': instance.localEndpoint,
    'save_session': instance.saveSession,
    'save_online': instance.saveOnline,
    'local_web': instance.isLocal,
    'max_messages': instance.maxMessages,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('openrouter_default_model', instance.openrouterDefaultModel);
  writeNotNull('buddy_default_model', instance.buddyDefaultModel);
  writeNotNull('buddy_key', instance.buddyKey);
  writeNotNull('ollama_default_model', instance.ollamaDefaultModel);
  writeNotNull('ollamaEndpoint', instance.ollamaEndpoint);
  writeNotNull('openrouter_key', instance.openrouterKey);
  writeNotNull('temperature', instance.temperature);
  writeNotNull('max_tokens', instance.maxTokens);
  writeNotNull('top_p', instance.topP);
  writeNotNull('top_k', instance.topK);
  writeNotNull('frequency_penalty', instance.frequencyPenalty);
  writeNotNull('presence_penalty', instance.presencePenalty);
  writeNotNull('repetition_penalty', instance.repetitionPenalty);
  writeNotNull('min_p', instance.minP);
  writeNotNull('top_a', instance.topA);
  writeNotNull('seed', instance.seed);
  writeNotNull('logit_bias', instance.logitBias);
  writeNotNull('logprobs', instance.logprobs);
  writeNotNull('top_logprobs', instance.topLogprobs);
  writeNotNull('response_format', instance.responseFormat);
  writeNotNull('stop', instance.stop);
  writeNotNull('cmd_prompt', instance.cmdPrompt);
  writeNotNull('explain_prompt', instance.explainPrompt);
  writeNotNull('code_prompt', instance.codePrompt);
  writeNotNull('chat_prompt', instance.chatPrompt);
  return val;
}

const _$APIProviderEnumMap = {
  APIProvider.openrouter: 'openrouter',
  APIProvider.buddy: 'buddy',
  APIProvider.ollama: 'ollama',
};

_$SysPromptImpl _$$SysPromptImplFromJson(Map<String, dynamic> json) =>
    _$SysPromptImpl(
      name: json['name'] as String,
      prompt: json['prompt'] as String,
      modelId: json['modelId'] as String?,
    );

Map<String, dynamic> _$$SysPromptImplToJson(_$SysPromptImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'prompt': instance.prompt,
      'modelId': instance.modelId,
    };
