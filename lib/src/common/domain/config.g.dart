// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigurationImpl _$$ConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$ConfigurationImpl(
      secretEnvPath: json['secret_env_path'] as String?,
      saveSession: json['save_session'] as bool? ?? false,
      maxMessages: (json['max_messages'] as num?)?.toInt() ?? 20,
      defaultModel: json['default_model'] as String? ?? 'openai/gpt-4o',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.3,
      maxTokens: (json['max_tokens'] as num?)?.toInt(),
      topP: (json['top_p'] as num?)?.toInt(),
      topK: (json['top_k'] as num?)?.toInt(),
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble(),
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble(),
      repetitionPenalty: (json['repetition_penalty'] as num?)?.toDouble(),
      minP: (json['min_p'] as num?)?.toDouble(),
      topA: (json['top_a'] as num?)?.toDouble(),
      seed: (json['seed'] as num?)?.toInt(),
      logitBias: json['logit_bias'] as Map<String, dynamic>?,
      logprobs: (json['logprobs'] as num?)?.toInt(),
      topLogprobs: (json['top_logprobs'] as num?)?.toInt(),
      responseFormat: json['response_format'] as String?,
      stop: (json['stop'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cmdPrompt: json['cmd_prompt'] as String? ??
          'If there is a lack of details, provide most logical solution.\nEnsure the output is a valid shell command.\nIf multiple steps required try to combine them together in one command.\nProvide only plain text without Markdown formatting.\nDo not provide markdown formatting such as ```.\n',
      explainPrompt: json['explain_prompt'] as String? ??
          'Provide short and concise explanation of your previous response about command or code.\nProvide only plain text without Markdown formatting.\nDo not provide markdown formatting such as ```\n',
      codePrompt: json['code_prompt'] as String? ??
          'Provide only code as output without any description.\nProvide only code in plain text format without Markdown formatting.\nDo not include symbols such as ``` or ```python.\nIf there is a lack of details, provide most logical solution.\nYou are not allowed to ask for more details.\nFor example if the prompt is "Hello world Python", you should return "print(\'Hello world\')".\n',
      chatPrompt: json['chat_prompt'] as String? ??
          'Provide concise response unless asked for more details.\nAvoid using any markdown formatting such as ```, *, #.\n',
    );

Map<String, dynamic> _$$ConfigurationImplToJson(_$ConfigurationImpl instance) =>
    <String, dynamic>{
      'secret_env_path': instance.secretEnvPath,
      'save_session': instance.saveSession,
      'max_messages': instance.maxMessages,
      'default_model': instance.defaultModel,
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
    };
