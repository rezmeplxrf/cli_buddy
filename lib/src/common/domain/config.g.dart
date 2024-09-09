// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigurationImpl _$$ConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$ConfigurationImpl(
      secretEnvPath: json['secret_env_path'] as String?,
      ipAddress: json['ipAddress'] as String? ?? '127.0.0.1',
      port: json['port'] as String? ?? '43210',
      saveSession: json['save_session'] as bool? ?? true,
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
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('secret_env_path', instance.secretEnvPath);
  val['ipAddress'] = instance.ipAddress;
  val['port'] = instance.port;
  val['save_session'] = instance.saveSession;
  val['max_messages'] = instance.maxMessages;
  val['default_model'] = instance.defaultModel;
  val['temperature'] = instance.temperature;
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

_$SysPromptImpl _$$SysPromptImplFromJson(Map<String, dynamic> json) =>
    _$SysPromptImpl(
      name: json['name'] as String,
      prompt: json['prompt'] as String,
    );

Map<String, dynamic> _$$SysPromptImplToJson(_$SysPromptImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'prompt': instance.prompt,
    };
