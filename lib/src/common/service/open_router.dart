import 'dart:convert';

import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

String fallbackModel = 'openai/gpt-4o-2024-08-06';

class OpenRouterService {
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();
  static final OpenRouterService _instance = OpenRouterService._internal();

  static Future<Result<ChatSession, CustomException>> invoke(
      {required ChatSession session,
      required Logger logger,
      bool? debug = false}) async {
    openrouterKey ??= await ConfigService.readOpenrouterKey(logger);
    defaultModel ??= await ConfigService.readDefaultModel(logger);
    if (openrouterKey == null) {
      throw CustomException(
        message: 'openrouter_key not found in .env file',
        stack: 'OpenRouterService.invoke',
      );
    }
    final headers = {
      'HTTP-Referer': 'insightsentry.com',
      'X-Title': 'CLI Buddy',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openrouterKey'
    };
    final model =
        (session.model != null) ? session.model : defaultModel ?? fallbackModel;
    final prompt = <String, dynamic>{
      'model': model,
      'stream': true,
      'messages': session.messages,
    };

    if (session.parameters != null) {
      prompt.addAll(session.parameters!.toJson());
    }

    final promptForDebug = json.encode(prompt);
    if (debug != null && debug) {
      logger.info('Prompt:\n${lightCyan.wrap(promptForDebug)}');
    }

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
                  details: {
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
          details: {'api_responses': responses},
          stack: 'OpenRouterService.invoke');
    }
  }
}
