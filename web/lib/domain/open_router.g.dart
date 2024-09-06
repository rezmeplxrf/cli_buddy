// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsageImpl _$$UsageImplFromJson(Map<String, dynamic> json) => _$UsageImpl(
      promptTokens: (json['prompt_tokens'] as num?)?.toInt(),
      completionTokens: (json['completion_tokens'] as num?)?.toInt(),
      totalTokens: (json['total_tokens'] as num?)?.toInt(),
      responseTime: (json['response_time'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UsageImplToJson(_$UsageImpl instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
      'response_time': instance.responseTime,
    };

_$ORModelListImpl _$$ORModelListImplFromJson(Map<String, dynamic> json) =>
    _$ORModelListImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pricing: json['pricing'] == null
          ? null
          : Pricing.fromJson(json['pricing'] as Map<String, dynamic>),
      contextLength: (json['context_length'] as num?)?.toInt(),
      architecture: json['architecture'] == null
          ? null
          : Architecture.fromJson(json['architecture'] as Map<String, dynamic>),
      topProvider: json['top_provider'] == null
          ? null
          : TopProvider.fromJson(json['top_provider'] as Map<String, dynamic>),
      perRequestLimits: json['per_request_limits'] == null
          ? null
          : PerRequestLimits.fromJson(
              json['per_request_limits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ORModelListImplToJson(_$ORModelListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pricing': instance.pricing,
      'context_length': instance.contextLength,
      'architecture': instance.architecture,
      'top_provider': instance.topProvider,
      'per_request_limits': instance.perRequestLimits,
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
      instructType: json['instruct_type'] as String?,
    );

Map<String, dynamic> _$$ArchitectureImplToJson(_$ArchitectureImpl instance) =>
    <String, dynamic>{
      'modality': instance.modality,
      'tokenizer': instance.tokenizer,
      'instruct_type': instance.instructType,
    };

_$TopProviderImpl _$$TopProviderImplFromJson(Map<String, dynamic> json) =>
    _$TopProviderImpl(
      contextLength: (json['context_length'] as num?)?.toInt(),
      maxCompletionTokens: (json['max_completion_tokens'] as num?)?.toInt(),
      isModerated: json['is_moderated'] as bool?,
    );

Map<String, dynamic> _$$TopProviderImplToJson(_$TopProviderImpl instance) =>
    <String, dynamic>{
      'context_length': instance.contextLength,
      'max_completion_tokens': instance.maxCompletionTokens,
      'is_moderated': instance.isModerated,
    };

_$PerRequestLimitsImpl _$$PerRequestLimitsImplFromJson(
        Map<String, dynamic> json) =>
    _$PerRequestLimitsImpl(
      promptTokens: json['prompt_tokens'] as String?,
      completionTokens: json['completion_tokens'] as String?,
    );

Map<String, dynamic> _$$PerRequestLimitsImplToJson(
        _$PerRequestLimitsImpl instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
    };

_$ORCreditImpl _$$ORCreditImplFromJson(Map<String, dynamic> json) =>
    _$ORCreditImpl(
      label: json['label'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      usage: (json['usage'] as num?)?.toDouble(),
      limitRemaining: (json['limit_remaining'] as num?)?.toInt(),
      isFreeTier: json['is_free_tier'] as bool?,
      rateLimit: json['rate_limit'] == null
          ? null
          : RateLimit.fromJson(json['rate_limit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ORCreditImplToJson(_$ORCreditImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'limit': instance.limit,
      'usage': instance.usage,
      'limit_remaining': instance.limitRemaining,
      'is_free_tier': instance.isFreeTier,
      'rate_limit': instance.rateLimit,
    };

_$RateLimitImpl _$$RateLimitImplFromJson(Map<String, dynamic> json) =>
    _$RateLimitImpl(
      requests: (json['requests'] as num?)?.toInt(),
      interval: json['interval'] as String?,
    );

Map<String, dynamic> _$$RateLimitImplToJson(_$RateLimitImpl instance) =>
    <String, dynamic>{
      'requests': instance.requests,
      'interval': instance.interval,
    };

_$ParameterInfoImpl _$$ParameterInfoImplFromJson(Map<String, dynamic> json) =>
    _$ParameterInfoImpl(
      model: json['model'] as String?,
      supportedParameters: (json['supported_parameters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      frequencyPenaltyP10: (json['frequency_penalty_p10'] as num?)?.toInt(),
      frequencyPenaltyP50: (json['frequency_penalty_p50'] as num?)?.toInt(),
      frequencyPenaltyP90: (json['frequency_penalty_p90'] as num?)?.toDouble(),
      minPP10: (json['min_p_p10'] as num?)?.toInt(),
      minPP50: (json['min_p_p50'] as num?)?.toInt(),
      minPP90: (json['min_p_p90'] as num?)?.toInt(),
      presencePenaltyP10: (json['presence_penalty_p10'] as num?)?.toInt(),
      presencePenaltyP50: (json['presence_penalty_p50'] as num?)?.toInt(),
      presencePenaltyP90: (json['presence_penalty_p90'] as num?)?.toDouble(),
      repetitionPenaltyP10: (json['repetition_penalty_p10'] as num?)?.toInt(),
      repetitionPenaltyP50: (json['repetition_penalty_p50'] as num?)?.toInt(),
      repetitionPenaltyP90: (json['repetition_penalty_p90'] as num?)?.toInt(),
      temperatureP10: (json['temperature_p10'] as num?)?.toInt(),
      temperatureP50: (json['temperature_p50'] as num?)?.toDouble(),
      temperatureP90: (json['temperature_p90'] as num?)?.toInt(),
      topAP10: (json['top_a_p10'] as num?)?.toInt(),
      topAP50: (json['top_a_p50'] as num?)?.toInt(),
      topAP90: (json['top_a_p90'] as num?)?.toInt(),
      topKP10: (json['top_k_p10'] as num?)?.toInt(),
      topKP50: (json['top_k_p50'] as num?)?.toInt(),
      topKP90: (json['top_k_p90'] as num?)?.toInt(),
      topPP10: (json['top_p_p10'] as num?)?.toInt(),
      topPP50: (json['top_p_p50'] as num?)?.toInt(),
      topPP90: (json['top_p_p90'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ParameterInfoImplToJson(_$ParameterInfoImpl instance) =>
    <String, dynamic>{
      'model': instance.model,
      'supported_parameters': instance.supportedParameters,
      'frequency_penalty_p10': instance.frequencyPenaltyP10,
      'frequency_penalty_p50': instance.frequencyPenaltyP50,
      'frequency_penalty_p90': instance.frequencyPenaltyP90,
      'min_p_p10': instance.minPP10,
      'min_p_p50': instance.minPP50,
      'min_p_p90': instance.minPP90,
      'presence_penalty_p10': instance.presencePenaltyP10,
      'presence_penalty_p50': instance.presencePenaltyP50,
      'presence_penalty_p90': instance.presencePenaltyP90,
      'repetition_penalty_p10': instance.repetitionPenaltyP10,
      'repetition_penalty_p50': instance.repetitionPenaltyP50,
      'repetition_penalty_p90': instance.repetitionPenaltyP90,
      'temperature_p10': instance.temperatureP10,
      'temperature_p50': instance.temperatureP50,
      'temperature_p90': instance.temperatureP90,
      'top_a_p10': instance.topAP10,
      'top_a_p50': instance.topAP50,
      'top_a_p90': instance.topAP90,
      'top_k_p10': instance.topKP10,
      'top_k_p50': instance.topKP50,
      'top_k_p90': instance.topKP90,
      'top_p_p10': instance.topPP10,
      'top_p_p50': instance.topPP50,
      'top_p_p90': instance.topPP90,
    };
