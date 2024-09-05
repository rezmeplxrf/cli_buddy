import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_router.freezed.dart';
part 'open_router.g.dart';

@freezed
class Usage with _$Usage {
  const factory Usage({
    @JsonKey(name: 'prompt_tokens') int? promptTokens,
    @JsonKey(name: 'completion_tokens') int? completionTokens,
    @JsonKey(name: 'total_tokens') int? totalTokens,
    @JsonKey(name: 'response_time') double? responseTime,
  }) = _Usage;

  factory Usage.fromJson(Map<String, Object?> json) => _$UsageFromJson(json);
}

@freezed
class ORModelList with _$ORModelList {
  const factory ORModelList({
    required String id,
    required String name,
    required String description,
    required Pricing? pricing,
    @JsonKey(name: 'context_length') required int? contextLength,
    required Architecture? architecture,
    @JsonKey(name: 'top_provider') required TopProvider? topProvider,
    @JsonKey(name: 'per_request_limits')
    required PerRequestLimits? perRequestLimits,
  }) = _ORModelList;

  factory ORModelList.fromJson(Map<String, dynamic> json) =>
      _$ORModelListFromJson(json);
}

@freezed
class Pricing with _$Pricing {
  const factory Pricing({
    required String? prompt,
    required String? completion,
    required String? image,
    required String? request,
  }) = _Pricing;

  factory Pricing.fromJson(Map<String, dynamic> json) =>
      _$PricingFromJson(json);
}

@freezed
class Architecture with _$Architecture {
  const factory Architecture({
    required String? modality,
    required String? tokenizer,
    @JsonKey(name: 'instruct_type') required String? instructType,
  }) = _Architecture;

  factory Architecture.fromJson(Map<String, dynamic> json) =>
      _$ArchitectureFromJson(json);
}

@freezed
class TopProvider with _$TopProvider {
  const factory TopProvider({
    @JsonKey(name: 'context_length') required int? contextLength,
    @JsonKey(name: 'max_completion_tokens') required int? maxCompletionTokens,
    @JsonKey(name: 'is_moderated') required bool? isModerated,
  }) = _TopProvider;

  factory TopProvider.fromJson(Map<String, dynamic> json) =>
      _$TopProviderFromJson(json);
}

@freezed
class PerRequestLimits with _$PerRequestLimits {
  const factory PerRequestLimits({
    @JsonKey(name: 'prompt_tokens') required String? promptTokens,
    @JsonKey(name: 'completion_tokens') required String? completionTokens,
  }) = _PerRequestLimits;

  factory PerRequestLimits.fromJson(Map<String, dynamic> json) =>
      _$PerRequestLimitsFromJson(json);
}

@freezed
class ORCredit with _$ORCredit {
  const factory ORCredit({
    @JsonKey(name: 'label') String? label,
    @JsonKey(name: 'limit') int? limit,
    @JsonKey(name: 'usage') double? usage,
    @JsonKey(name: 'limit_remaining') int? limitRemaining,
    @JsonKey(name: 'is_free_tier') bool? isFreeTier,
    @JsonKey(name: 'rate_limit') RateLimit? rateLimit,
  }) = _ORCredit;

  factory ORCredit.fromJson(Map<String, Object?> json) =>
      _$ORCreditFromJson(json);
}

@freezed
class RateLimit with _$RateLimit {
  const factory RateLimit({
    @JsonKey(name: 'requests') int? requests,
    @JsonKey(name: 'interval') String? interval,
  }) = _RateLimit;

  factory RateLimit.fromJson(Map<String, Object?> json) =>
      _$RateLimitFromJson(json);
}

@freezed
class ParameterInfo with _$ParameterInfo {
  const factory ParameterInfo({
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'supported_parameters') List<String>? supportedParameters,
    @JsonKey(name: 'frequency_penalty_p10') int? frequencyPenaltyP10,
    @JsonKey(name: 'frequency_penalty_p50') int? frequencyPenaltyP50,
    @JsonKey(name: 'frequency_penalty_p90') double? frequencyPenaltyP90,
    @JsonKey(name: 'min_p_p10') int? minPP10,
    @JsonKey(name: 'min_p_p50') int? minPP50,
    @JsonKey(name: 'min_p_p90') int? minPP90,
    @JsonKey(name: 'presence_penalty_p10') int? presencePenaltyP10,
    @JsonKey(name: 'presence_penalty_p50') int? presencePenaltyP50,
    @JsonKey(name: 'presence_penalty_p90') double? presencePenaltyP90,
    @JsonKey(name: 'repetition_penalty_p10') int? repetitionPenaltyP10,
    @JsonKey(name: 'repetition_penalty_p50') int? repetitionPenaltyP50,
    @JsonKey(name: 'repetition_penalty_p90') int? repetitionPenaltyP90,
    @JsonKey(name: 'temperature_p10') int? temperatureP10,
    @JsonKey(name: 'temperature_p50') double? temperatureP50,
    @JsonKey(name: 'temperature_p90') int? temperatureP90,
    @JsonKey(name: 'top_a_p10') int? topAP10,
    @JsonKey(name: 'top_a_p50') int? topAP50,
    @JsonKey(name: 'top_a_p90') int? topAP90,
    @JsonKey(name: 'top_k_p10') int? topKP10,
    @JsonKey(name: 'top_k_p50') int? topKP50,
    @JsonKey(name: 'top_k_p90') int? topKP90,
    @JsonKey(name: 'top_p_p10') int? topPP10,
    @JsonKey(name: 'top_p_p50') int? topPP50,
    @JsonKey(name: 'top_p_p90') int? topPP90,
  }) = _ParameterInfo;

  factory ParameterInfo.fromJson(Map<String, Object?> json) =>
      _$ParameterInfoFromJson(json);
}
