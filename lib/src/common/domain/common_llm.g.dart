// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_llm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatSessionImpl _$$ChatSessionImplFromJson(Map<String, dynamic> json) =>
    _$ChatSessionImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      model: json['model'] as String?,
      parameters: json['parameters'] == null
          ? null
          : Parameters.fromJson(json['parameters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatSessionImplToJson(_$ChatSessionImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'model': instance.model,
      'parameters': instance.parameters?.toJson(),
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      role: $enumDecode(_$RoleEnumMap, json['role']),
      content: json['content'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) {
  final val = <String, dynamic>{
    'role': _$RoleEnumMap[instance.role]!,
    'content': instance.content,
    'timestamp': instance.timestamp,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('usage', instance.usage?.toJson());
  return val;
}

const _$RoleEnumMap = {
  Role.system: 'system',
  Role.user: 'user',
  Role.assistant: 'assistant',
  Role.tool: 'tool',
};

_$ParametersImpl _$$ParametersImplFromJson(Map<String, dynamic> json) =>
    _$ParametersImpl(
      maxTokens: (json['max_tokens'] as num?)?.toInt(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      topP: (json['top_p'] as num?)?.toDouble(),
      topK: (json['top_k'] as num?)?.toInt(),
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble(),
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble(),
      repetitionPenalty: (json['repetition_penalty'] as num?)?.toDouble(),
      minProbability: (json['min_p'] as num?)?.toDouble(),
      topAnswer: (json['top_a'] as num?)?.toDouble(),
      seed: (json['seed'] as num?)?.toInt(),
      logitBias: (json['logit_bias'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      logProbabilities: json['logprobs'] as bool?,
      topLogProbabilities: (json['top_logprobs'] as num?)?.toInt(),
      responseFormat: (json['response_format'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      stop: (json['stop'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$ParametersImplToJson(_$ParametersImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('max_tokens', instance.maxTokens);
  writeNotNull('temperature', instance.temperature);
  writeNotNull('top_p', instance.topP);
  writeNotNull('top_k', instance.topK);
  writeNotNull('frequency_penalty', instance.frequencyPenalty);
  writeNotNull('presence_penalty', instance.presencePenalty);
  writeNotNull('repetition_penalty', instance.repetitionPenalty);
  writeNotNull('min_p', instance.minProbability);
  writeNotNull('top_a', instance.topAnswer);
  writeNotNull('seed', instance.seed);
  writeNotNull('logit_bias', instance.logitBias);
  writeNotNull('logprobs', instance.logProbabilities);
  writeNotNull('top_logprobs', instance.topLogProbabilities);
  writeNotNull('response_format', instance.responseFormat);
  writeNotNull('stop', instance.stop);
  return val;
}
