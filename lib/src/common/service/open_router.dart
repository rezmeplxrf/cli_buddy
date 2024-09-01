import 'dart:convert';

import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

final headers = {
  'HTTP-Referer': 'insightsentry.com',
  'X-Title': 'Buddy CLI',
  'Content-Type': 'application/json',
  'Authorization':
      'Bearer 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'
};

class OpenRouterService {
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();
  static final OpenRouterService _instance = OpenRouterService._internal();

  Future<Result<ChatSession, CustomException>> invoke(
      ChatSession session) async {
    final prompt = <String, dynamic>{
      'model': session.model,
      'stream': true,
      'messages': session.messages,
    };

    if (session.parameters != null) {
      prompt.addAll(session.parameters!.toJson());
    }

    final promptJson = json.encode(prompt);
    print(promptJson);

    final response = await dio.post<ResponseBody>(
      'https://openrouter.ai/api/v1/chat/completions',
      options: Options(headers: headers, responseType: ResponseType.stream),
      data: prompt,
    );

    final msg = StringBuffer();

    ChatSession? newSession;
    final responses = <ORResponse>[];

    await for (final chunk in response.data!.stream) {
      if (chunk.isEmpty) continue;
      final decodedString = utf8.decode(chunk);
      final parts = decodedString.split('\n');

      for (var i = 0; i < parts.length - 1; i++) {
        final part = parts[i].trim();
        if (part.startsWith('data:') &&
            part.length > 5 &&
            !part.contains('[DONE]')) {
          final jsonString = part.substring(5).trim();
          if (jsonString.isNotEmpty) {
            final decodedJson = json.decode(jsonString) as Map<String, dynamic>;
            final response = ORResponse.fromJson(decodedJson);
            responses.add(response);

            if (response.choices != null &&
                response.choices!.first.delta?.content?.trim() != null) {
              msg.write(response.choices!.first.delta!.content);
            }

            if (response.choices?.first.error != null) {
              throw CustomException(
                  message: 'An Error occured from the provider',
                  stack: 'OpenRouterService.invoke',
                  verboseMessage: {
                    'api_error_message': response.choices!.first.error?.toJson()
                  });
            }
          }
        }
      }
    }
    if (responses.isNotEmpty) {
      final lastResponse = responses.last;
      final aiResponse = Message(
        role: Role.assistant,
        content: msg.toString(),
        timestamp: DateTime.now().millisecondsSinceEpoch,
        usage: lastResponse.usage,
      );
      newSession = session.copyWith(
        messages: [...session.messages, aiResponse],
      );
    }
    if (newSession != null) {
      return Success(newSession);
    } else {
      throw CustomException(
          message: 'Something went wrong - newSession is null',
          verboseMessage: {'api_responses': responses},
          stack: 'OpenRouterService.invoke');
    }
  }
}
