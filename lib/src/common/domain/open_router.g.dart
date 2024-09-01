// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      role: $enumDecode(_$RoleEnumMap, json['role']),
      content: json['content'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) {
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
};

_$ORResponseImpl _$$ORResponseImplFromJson(Map<String, dynamic> json) =>
    _$ORResponseImpl(
      id: json['id'] as String?,
      model: json['model'] as String?,
      object: json['object'] as String?,
      created: (json['created'] as num?)?.toInt(),
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => Choices.fromJson(e as Map<String, dynamic>))
          .toList(),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ORResponseImplToJson(_$ORResponseImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('model', instance.model);
  writeNotNull('object', instance.object);
  writeNotNull('created', instance.created);
  writeNotNull('choices', instance.choices?.map((e) => e.toJson()).toList());
  writeNotNull('usage', instance.usage?.toJson());
  return val;
}

_$ChoicesImpl _$$ChoicesImplFromJson(Map<String, dynamic> json) =>
    _$ChoicesImpl(
      index: (json['index'] as num?)?.toInt(),
      delta: json['delta'] == null
          ? null
          : Delta.fromJson(json['delta'] as Map<String, dynamic>),
      finishReason: json['finishReason'] as String?,
      logprobs: json['logprobs'] as String?,
    );

Map<String, dynamic> _$$ChoicesImplToJson(_$ChoicesImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('index', instance.index);
  writeNotNull('delta', instance.delta?.toJson());
  writeNotNull('finishReason', instance.finishReason);
  writeNotNull('logprobs', instance.logprobs);
  return val;
}

_$DeltaImpl _$$DeltaImplFromJson(Map<String, dynamic> json) => _$DeltaImpl(
      role: json['role'] as String?,
      content: json['content'] as String?,
      toolCall: json['toolCall'] == null
          ? null
          : ToolCall.fromJson(json['toolCall'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DeltaImplToJson(_$DeltaImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('role', instance.role);
  writeNotNull('content', instance.content);
  writeNotNull('toolCall', instance.toolCall?.toJson());
  return val;
}

_$ToolCallImpl _$$ToolCallImplFromJson(Map<String, dynamic> json) =>
    _$ToolCallImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      function: json['function'] as String?,
    );

Map<String, dynamic> _$$ToolCallImplToJson(_$ToolCallImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'function': instance.function,
    };

_$UsageImpl _$$UsageImplFromJson(Map<String, dynamic> json) => _$UsageImpl(
      promptTokens: (json['promptTokens'] as num?)?.toInt(),
      completionTokens: (json['completionTokens'] as num?)?.toInt(),
      totalTokens: (json['totalTokens'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UsageImplToJson(_$UsageImpl instance) =>
    <String, dynamic>{
      'promptTokens': instance.promptTokens,
      'completionTokens': instance.completionTokens,
      'totalTokens': instance.totalTokens,
    };
