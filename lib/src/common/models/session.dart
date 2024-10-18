import 'open_router.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class ChatSession with _$ChatSession {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory ChatSession({
    required int id,
    required List<Message> messages,
    required String modelId,
    Parameters? parameters,
  }) = _ChatSession;

  factory ChatSession.fromJson(Map<String, Object?> json) =>
      _$ChatSessionFromJson(json);
}

enum Role { system, user, assistant, tool, reviewer }

@freezed
class Message with _$Message {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory Message(
      {required Role role,
      required String content,
      required int timestamp,
      Usage? usage,
      Validation? validation,
      String? overriddenModelId}) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}

@freezed
class ValidateRequest with _$ValidateRequest {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory ValidateRequest({
    required Message targetMessage,
    required Message sysPrompt,
    required ChatSession currentSession,
    String? modelId,
    Parameters? parameters,
  }) = _ValidateRequest;

  factory ValidateRequest.fromJson(Map<String, Object?> json) =>
      _$ValidateRequestFromJson(json);
}

@freezed
class Validation with _$Validation {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory Validation({
    required String modelId,
    required String result,
    required int timestamp,
    Usage? usage,
  }) = _Validation;

  factory Validation.fromJson(Map<String, Object?> json) =>
      _$ValidationFromJson(json);
}

@freezed
class Parameters with _$Parameters {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory Parameters({
    /// This sets the upper limit for the number of tokens the model can generate in response.
    /// It won't produce more than this limit.
    /// The maximum value is the context length minus the prompt length.
    @JsonKey(name: 'max_tokens') int? maxTokens,

    /// This setting influences the variety in the model's responses.
    /// Lower values lead to more predictable and typical responses,
    /// while higher values encourage more diverse and less common responses.
    /// At 0, the model always gives the same response for a given input.
    ///
    /// Allowed values: 0.0 to 2.0
    /// Default: 1.0
    @JsonKey(name: 'temperature') double? temperature,

    /// This setting limits the model's choices to a percentage of likely tokens:
    /// only the top tokens whose probabilities add up to P.
    /// A lower value makes the model's responses more predictable,
    /// while the default setting allows for a full range of token choices.
    /// Think of it like a dynamic Top-K.
    ///
    /// Allowed values: 0.0 to 1.0
    /// Default: 1.0
    @JsonKey(name: 'top_p') double? topP,

    /// This limits the model's choice of tokens at each step, making it choose from a smaller set.
    /// A value of 1 means the model will always pick the most likely next token, leading to predictable results.
    /// By default this setting is disabled, making the model to consider all choices.
    ///
    /// Allowed values: 0 to 1
    /// Default: 0
    @JsonKey(name: 'top_k') int? topK,

    /// This setting aims to control the repetition of tokens based on how often they appear in the input.
    /// It tries to use less frequently those tokens that appear more in the input,
    /// proportional to how frequently they occur.
    /// Token penalty scales with the number of occurrences.
    /// Negative values will encourage token reuse.
    ///
    /// Allowed values: -2.0 to 2.0
    /// Default: 0.0
    @JsonKey(name: 'frequency_penalty') double? frequencyPenalty,

    /// Adjusts how often the model repeats specific tokens already used in the input.
    /// Higher values make such repetition less likely, while negative values do the opposite.
    /// Token penalty does not scale with the number of occurrences.
    /// Negative values will encourage token reuse.
    ///
    /// Allowed values: -2.0 to 2.0
    /// Default: 0.0
    @JsonKey(name: 'presence_penalty') double? presencePenalty,

    /// Helps to reduce the repetition of tokens from the input.
    /// A higher value makes the model less likely to repeat tokens,
    /// but too high a value can make the output less coherent (often with run-on sentences that lack small words).
    /// Token penalty scales based on original token's probability.
    ///
    /// Allowed values: 0.0 to 2.0
    /// Default: 1.0
    @JsonKey(name: 'repetition_penalty') double? repetitionPenalty,

    /// Represents the minimum probability for a token to be considered,
    /// relative to the probability of the most likely token.
    /// (The value changes depending on the confidence level of the most probable token.)
    /// If your Min-P is set to 0.1,
    /// that means it will only allow for tokens that are at least 1/10th as probable as the best possible option.
    ///
    /// Allowed values: 0.0 to 1.0
    /// Default: 0.0
    @JsonKey(name: 'min_p') double? minProbability,

    /// Consider only the top tokens with "sufficiently high" probabilities based on the probability of the most likely token.
    /// Think of it like a dynamic Top-P.
    /// A lower Top-A value focuses the choices based on the highest probability token but with a narrower scope.
    /// A higher Top-A value does not necessarily affect the creativity of the output,
    /// but rather refines the filtering process based on the maximum probability.
    ///
    /// Allowed values: 0.0 to 1.0
    /// Default: 0.0
    @JsonKey(name: 'top_a') double? topAnswer,

    /// If specified, the inferencing will sample deterministically,
    /// such that repeated requests with the same seed and parameters should return the same result.
    /// Determinism is not guaranteed for some models.
    @JsonKey(name: 'seed') int? seed,

    /// Accepts a JSON object that maps tokens (specified by their token ID in the tokenizer)
    /// to an associated bias value from -100 to 100. Mathematically,
    /// the bias is added to the logits generated by the model prior to sampling.
    /// The exact effect will vary per model, but values between -1 and 1 should decrease
    /// or increase likelihood of selection;
    /// values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
    @JsonKey(name: 'logit_bias') Map<String, int>? logitBias,

    /// Whether to return log probabilities of the output tokens or not.
    /// If true, returns the log probabilities of each output token returned.
    @JsonKey(name: 'logprobs') bool? logProbabilities,

    /// An integer between 0 and 20 specifying the number of most likely tokens to return at each token position,
    /// each with an associated log probability. logprobs must be set to true if this parameter is used.
    @JsonKey(name: 'top_logprobs') int? topLogProbabilities,

    /// Forces the model to produce specific output format.
    /// Setting to { "type": "json_object" } enables JSON mode,
    /// which guarantees the message the model generates is valid JSON.
    ///  Note: when using JSON mode, you should also instruct the model to produce JSON yourself via a system or user message.
    @JsonKey(name: 'response_format') Map<String, String>? responseFormat,

    /// Stop generation immediately if the model encounter any token specified in the stop array.
    @JsonKey(name: 'stop') List<int>? stop,

    ///
    /// Not implemented yet
    ///
    /// Tool calling parameter.
    /// Will be passed down as-is for providers implementing OpenAI's interface.
    /// For providers with custom interfaces, we transform and map the properties.
    /// Otherwise, we transform the tools into a YAML template. The model responds with an assistant message.
    // @JsonKey(name: 'tools') List<Tool>? tools,

    ///
    /// Not implemented yet
    ///
    // /// Controls which (if any) tool is called by the model.
    // /// 'none' means the model will not call any tool and instead generates a message.
    // /// 'auto' means the model can pick between generating a message or calling one or more tools.
    // /// 'required' means the model must call one or more tools.
    // /// Specifying a particular tool via {"type": "function", "function": {"name": "my_function"}} forces the model to call that tool.
    // @JsonKey(name: 'tool_choice') List<ToolChoice>? toolChoices,
  }) = _Parameters;

  factory Parameters.fromJson(Map<String, Object?> json) =>
      _$ParametersFromJson(json);
}

///
/// Not implemented yet
///
// class Tool {
//   Tool({
//     required this.type,
//     required this.function,
//   });

//   factory Tool.fromJson(Map<String, dynamic> json) {
//     return Tool(
//       type: json['type'] as String,
//       function: FunctionDescription.fromJson(
//           json['function'] as Map<String, dynamic>),
//     );
//   }
//   final String type;
//   final FunctionDescription function;

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'function': function.toJson(),
//     };
//   }
// }

// class FunctionDescription {
//   FunctionDescription({
//     required this.name,
//     required this.parameters,
//     this.description,
//   });

//   factory FunctionDescription.fromJson(Map<String, dynamic> json) {
//     return FunctionDescription(
//       description: json['description'] as String?,
//       name: json['name'] as String,
//       parameters: json['parameters'] as Map<String, dynamic>,
//     );
//   }
//   final String? description;
//   final String name;
//   final Map<String, dynamic> parameters;

//   Map<String, dynamic> toJson() {
//     return {
//       'description': description,
//       'name': name,
//       'parameters': parameters,
//     };
//   }
// }

// class ToolChoice {
//   ToolChoice._({
//     this.type,
//     this.function,
//   });

//   factory ToolChoice.none() {
//     return ToolChoice._();
//   }

//   factory ToolChoice.auto() {
//     return ToolChoice._(type: 'auto');
//   }

//   factory ToolChoice.function(String name) {
//     return ToolChoice._(
//       type: 'function',
//       function: FunctionDescription(name: name, parameters: {}),
//     );
//   }

//   factory ToolChoice.fromJson(dynamic json) {
//     if (json == 'none') {
//       return ToolChoice.none();
//     } else if (json == 'auto') {
//       return ToolChoice.auto();
//     } else {
//       return ToolChoice._(
//         type: (json as Map<String, dynamic>).containsKey('type')
//             ? json['type'] as String
//             : null,
//         function: FunctionDescription.fromJson(
//             json['function'] as Map<String, dynamic>),
//       );
//     }
//   }
//   final String? type;
//   final FunctionDescription? function;

//   dynamic toJson() {
//     if (type == null) {
//       return 'none';
//     } else if (type == 'auto') {
//       return 'auto';
//     } else {
//       return {
//         'type': type,
//         'function': function?.toJson(),
//       };
//     }
//   }
// }

enum ChunkType { start, chunk, end, error }

@freezed
class MessageChunk with _$MessageChunk {
  @JsonSerializable(includeIfNull: false)
  const factory MessageChunk({
    required ChunkType type,
    String? content,
    Usage? usage,
  }) = _MessageChunk;

  factory MessageChunk.fromJson(Map<String, Object?> json) =>
      _$MessageChunkFromJson(json);
}
