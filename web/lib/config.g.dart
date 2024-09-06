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
      logitBias: (json['logit_bias'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
      logprobs: (json['logprobs'] as num?)?.toInt(),
      topLogprobs: (json['top_logprobs'] as num?)?.toInt(),
      responseFormat: json['response_format'] as Map<String, dynamic>?,
      stop: json['stop'] as List<dynamic>?,
      cmdPrompt: json['cmd_prompt'] as String?,
      explainPrompt: json['explain_prompt'] as String?,
      codePrompt: json['code_prompt'] as String?,
      chatPrompt: json['chat_prompt'] as String?,
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
      'logit_bias':
          instance.logitBias?.map((k, e) => MapEntry(k.toString(), e)),
      'logprobs': instance.logprobs,
      'top_logprobs': instance.topLogprobs,
      'response_format': instance.responseFormat,
      'stop': instance.stop,
      'cmd_prompt': instance.cmdPrompt,
      'explain_prompt': instance.explainPrompt,
      'code_prompt': instance.codePrompt,
      'chat_prompt': instance.chatPrompt,
    };
