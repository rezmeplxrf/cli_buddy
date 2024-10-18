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
      maxMessages: (json['max_messages'] as num?)?.toInt() ?? 20,
      openrouterDefaultModel:
          json['openrouter_default_model'] as String? ?? 'openai/gpt-4o',
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
      validatePrompt: json['validate_prompt'] as String? ??
          'Your job is to verify if the provided code by the previous AI assistant is valid.\nProvide concise response unless asked for more details.',
    );

Map<String, dynamic> _$$ConfigurationImplToJson(_$ConfigurationImpl instance) =>
    <String, dynamic>{
      'api_provider': _$APIProviderEnumMap[instance.apiProvider]!,
      'localEndpoint': instance.localEndpoint,
      'save_session': instance.saveSession,
      'save_online': instance.saveOnline,
      'max_messages': instance.maxMessages,
      'openrouter_default_model': instance.openrouterDefaultModel,
      'ollama_default_model': instance.ollamaDefaultModel,
      'ollamaEndpoint': instance.ollamaEndpoint,
      'openrouter_key': instance.openrouterKey,
      'temperature': instance.temperature,
      'max_tokens': instance.maxTokens,
      'top_p': instance.topP,
      'top_k': instance.topK,
      'frequency_penalty': instance.frequencyPenalty,
      'presence_penalty': instance.presencePenalty,
      'repetition_penalty': instance.repetitionPenalty,
      'min_p': instance.minP,
      'top_a': instance.topA,
      'seed': instance.seed,
      'logit_bias': instance.logitBias,
      'logprobs': instance.logprobs,
      'top_logprobs': instance.topLogprobs,
      'response_format': instance.responseFormat,
      'stop': instance.stop,
      'cmd_prompt': instance.cmdPrompt,
      'explain_prompt': instance.explainPrompt,
      'code_prompt': instance.codePrompt,
      'chat_prompt': instance.chatPrompt,
      'validate_prompt': instance.validatePrompt,
    };

const _$APIProviderEnumMap = {
  APIProvider.openrouter: 'openrouter',
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
