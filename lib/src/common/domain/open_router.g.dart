// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      type: $enumDecode(_$PromptTypeEnumMap, json['type']),
      content: json['content'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'type': _$PromptTypeEnumMap[instance.type]!,
      'content': instance.content,
      'timestamp': instance.timestamp,
    };

const _$PromptTypeEnumMap = {
  PromptType.system: 'system',
  PromptType.user: 'user',
  PromptType.assistant: 'assistant',
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

Map<String, dynamic> _$$ORResponseImplToJson(_$ORResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'object': instance.object,
      'created': instance.created,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
    };

_$ChoicesImpl _$$ChoicesImplFromJson(Map<String, dynamic> json) =>
    _$ChoicesImpl(
      index: (json['index'] as num?)?.toInt(),
      delta: json['delta'] == null
          ? null
          : Delta.fromJson(json['delta'] as Map<String, dynamic>),
      finishReason: json['finishReason'] as String?,
      logprobs: json['logprobs'] as String?,
    );

Map<String, dynamic> _$$ChoicesImplToJson(_$ChoicesImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'delta': instance.delta?.toJson(),
      'finishReason': instance.finishReason,
      'logprobs': instance.logprobs,
    };

_$DeltaImpl _$$DeltaImplFromJson(Map<String, dynamic> json) => _$DeltaImpl(
      role: json['role'] as String?,
      content: json['content'] as String?,
      toolCall: json['toolCall'] == null
          ? null
          : ToolCall.fromJson(json['toolCall'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DeltaImplToJson(_$DeltaImpl instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
      'toolCall': instance.toolCall?.toJson(),
    };

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
