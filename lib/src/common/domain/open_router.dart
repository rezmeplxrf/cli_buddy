import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_router.freezed.dart';
part 'open_router.g.dart';

enum Role { system, user, assistant }

@freezed
class ChatMessage with _$ChatMessage {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory ChatMessage({
    required Role role,
    required String content,
    required int timestamp,
    Usage? usage,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);
}

@freezed
class ORResponse with _$ORResponse {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory ORResponse({
    String? id,
    String? model,
    String? object,
    int? created,
    List<Choices>? choices,
    Usage? usage,
  }) = _ORResponse;

  factory ORResponse.fromJson(Map<String, Object?> json) =>
      _$ORResponseFromJson(json);
}

@freezed
class Choices with _$Choices {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory Choices({
    int? index,
    Delta? delta,
    String? finishReason,
    String? logprobs,
  }) = _Choices;

  factory Choices.fromJson(Map<String, Object?> json) =>
      _$ChoicesFromJson(json);
}

@freezed
class Delta with _$Delta {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory Delta({
    String? role,
    String? content,
    ToolCall? toolCall,
  }) = _Delta;

  factory Delta.fromJson(Map<String, Object?> json) => _$DeltaFromJson(json);
}

@freezed
class ToolCall with _$ToolCall {
  const factory ToolCall({
    String? id,
    String? type,
    String? function,
  }) = _ToolCall;

  factory ToolCall.fromJson(Map<String, Object?> json) =>
      _$ToolCallFromJson(json);
}

@freezed
class Usage with _$Usage {
  const factory Usage({
    int? promptTokens,
    int? completionTokens,
    int? totalTokens,
  }) = _Usage;

  factory Usage.fromJson(Map<String, Object?> json) => _$UsageFromJson(json);
}
