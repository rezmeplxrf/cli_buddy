// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      systemFingerprint: json['system_fingerprint'] as String?,
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
  writeNotNull('system_fingerprint', instance.systemFingerprint);
  return val;
}

_$ChoicesImpl _$$ChoicesImplFromJson(Map<String, dynamic> json) =>
    _$ChoicesImpl(
      delta: json['delta'] == null
          ? null
          : Delta.fromJson(json['delta'] as Map<String, dynamic>),
      finishReason: json['finish_reason'] as String?,
      error: json['error'] == null
          ? null
          : Error.fromJson(json['error'] as Map<String, dynamic>),
      logprobs: json['logprobs'] == null
          ? null
          : Logprobs.fromJson(json['logprobs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChoicesImplToJson(_$ChoicesImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('delta', instance.delta?.toJson());
  writeNotNull('finish_reason', instance.finishReason);
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('logprobs', instance.logprobs?.toJson());
  return val;
}

_$DeltaImpl _$$DeltaImplFromJson(Map<String, dynamic> json) => _$DeltaImpl(
      role: json['role'] as String?,
      content: json['content'] as String?,
      toolCalls: (json['tool_calls'] as List<dynamic>?)
          ?.map((e) => ToolCall.fromJson(e as Map<String, dynamic>))
          .toList(),
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
  writeNotNull(
      'tool_calls', instance.toolCalls?.map((e) => e.toJson()).toList());
  return val;
}

_$LogprobsImpl _$$LogprobsImplFromJson(Map<String, dynamic> json) =>
    _$LogprobsImpl(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      refusal: json['refusal'] as String?,
    );

Map<String, dynamic> _$$LogprobsImplToJson(_$LogprobsImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'refusal': instance.refusal,
    };

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      token: json['token'] as String?,
      logprob: (json['logprob'] as num?)?.toDouble(),
      bytes: (json['bytes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      topLogprobs: (json['top_logprobs'] as List<dynamic>?)
          ?.map((e) => TopLogprobs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'logprob': instance.logprob,
      'bytes': instance.bytes,
      'top_logprobs': instance.topLogprobs,
    };

_$TopLogprobsImpl _$$TopLogprobsImplFromJson(Map<String, dynamic> json) =>
    _$TopLogprobsImpl(
      token: json['token'] as String?,
      logprob: (json['logprob'] as num?)?.toDouble(),
      bytes: (json['bytes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$TopLogprobsImplToJson(_$TopLogprobsImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'logprob': instance.logprob,
      'bytes': instance.bytes,
    };

_$ToolCallImpl _$$ToolCallImplFromJson(Map<String, dynamic> json) =>
    _$ToolCallImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      function: json['function'] == null
          ? null
          : FunctionCall.fromJson(json['function'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ToolCallImplToJson(_$ToolCallImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('type', instance.type);
  writeNotNull('function', instance.function?.toJson());
  return val;
}

_$FunctionCallImpl _$$FunctionCallImplFromJson(Map<String, dynamic> json) =>
    _$FunctionCallImpl(
      name: json['name'] as String,
      arguments: json['arguments'] as String,
    );

Map<String, dynamic> _$$FunctionCallImplToJson(_$FunctionCallImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'arguments': instance.arguments,
    };

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

_$UsageImpl _$$UsageImplFromJson(Map<String, dynamic> json) => _$UsageImpl(
      promptTokens: (json['prompt_tokens'] as num?)?.toInt(),
      completionTokens: (json['completion_tokens'] as num?)?.toInt(),
      totalTokens: (json['total_tokens'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UsageImplToJson(_$UsageImpl instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };

_$ORModelListImpl _$$ORModelListImplFromJson(Map<String, dynamic> json) =>
    _$ORModelListImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pricing: json['pricing'] == null
          ? null
          : Pricing.fromJson(json['pricing'] as Map<String, dynamic>),
      contextLength: (json['contextLength'] as num?)?.toInt(),
      architecture: json['architecture'] == null
          ? null
          : Architecture.fromJson(json['architecture'] as Map<String, dynamic>),
      topProvider: json['topProvider'] == null
          ? null
          : TopProvider.fromJson(json['topProvider'] as Map<String, dynamic>),
      perRequestLimits: json['perRequestLimits'] == null
          ? null
          : PerRequestLimits.fromJson(
              json['perRequestLimits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ORModelListImplToJson(_$ORModelListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pricing': instance.pricing,
      'contextLength': instance.contextLength,
      'architecture': instance.architecture,
      'topProvider': instance.topProvider,
      'perRequestLimits': instance.perRequestLimits,
    };

_$PricingImpl _$$PricingImplFromJson(Map<String, dynamic> json) =>
    _$PricingImpl(
      prompt: json['prompt'] as String?,
      completion: json['completion'] as String?,
      image: json['image'] as String?,
      request: json['request'] as String?,
    );

Map<String, dynamic> _$$PricingImplToJson(_$PricingImpl instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'completion': instance.completion,
      'image': instance.image,
      'request': instance.request,
    };

_$ArchitectureImpl _$$ArchitectureImplFromJson(Map<String, dynamic> json) =>
    _$ArchitectureImpl(
      modality: json['modality'] as String?,
      tokenizer: json['tokenizer'] as String?,
      instructType: json['instructType'] as String?,
    );

Map<String, dynamic> _$$ArchitectureImplToJson(_$ArchitectureImpl instance) =>
    <String, dynamic>{
      'modality': instance.modality,
      'tokenizer': instance.tokenizer,
      'instructType': instance.instructType,
    };

_$TopProviderImpl _$$TopProviderImplFromJson(Map<String, dynamic> json) =>
    _$TopProviderImpl(
      maxCompletionTokens: (json['maxCompletionTokens'] as num?)?.toInt(),
      isModerated: json['isModerated'] as bool?,
    );

Map<String, dynamic> _$$TopProviderImplToJson(_$TopProviderImpl instance) =>
    <String, dynamic>{
      'maxCompletionTokens': instance.maxCompletionTokens,
      'isModerated': instance.isModerated,
    };

_$PerRequestLimitsImpl _$$PerRequestLimitsImplFromJson(
        Map<String, dynamic> json) =>
    _$PerRequestLimitsImpl(
      promptTokens: json['promptTokens'] as String?,
      completionTokens: json['completionTokens'] as String?,
    );

Map<String, dynamic> _$$PerRequestLimitsImplToJson(
        _$PerRequestLimitsImpl instance) =>
    <String, dynamic>{
      'promptTokens': instance.promptTokens,
      'completionTokens': instance.completionTokens,
    };

_$ORCreditsImpl _$$ORCreditsImplFromJson(Map<String, dynamic> json) =>
    _$ORCreditsImpl(
      limit: (json['limit'] as num?)?.toInt(),
      usage: (json['usage'] as num?)?.toDouble(),
      isFreeTier: json['is_free_tier'] as bool,
      requestsLimit: (json['requestsLimit'] as num).toInt(),
      interval: json['interval'] as String,
    );

Map<String, dynamic> _$$ORCreditsImplToJson(_$ORCreditsImpl instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'usage': instance.usage,
      'is_free_tier': instance.isFreeTier,
      'requestsLimit': instance.requestsLimit,
      'interval': instance.interval,
    };
