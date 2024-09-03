import 'dart:async';
import 'dart:convert';

import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

final openRouter = OpenRouterService();
const _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';

class OpenRouterService {
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();
  static final OpenRouterService _instance = OpenRouterService._internal();

  Future<Result<ChatSession, CustomException>> invoke(
      {required ChatSession session,
      required Logger logger,
      required bool shouldDebug}) async {
    openrouterKey ??= await ConfigService.loadOpenrouterKey(logger);
    defaultModel ??= await ConfigService.loadDefaultModel(logger);
    defaultParameters ??= await ConfigService.loadDefaultParameters(logger);
    defaultMaxMessages = await ConfigService.loadMaxMessagesSent(logger);
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
    final parameters =
        (session.parameters != null) ? session.parameters : defaultParameters;
    // TODO: test
    final trimedSession = _trimSessionMessages(session);
    final prompt = <String, dynamic>{
      'model': model,
      'stream': true,
      'messages': trimedSession.messages,
    };

    if (parameters != null) {
      prompt.addAll(parameters.toJson());
    }

    Progress? progress;
    logger.info(
      '\n',
    );
    if (shouldDebug) {
      final promptForDebug = json.encode(prompt);
      final log = '''

## Prompt
${lightCyan.wrap(promptForDebug)}

## Response
''';
      logger.info(log);
    } else {
      progress = logger.progress(
        '',
        options: const ProgressOptions(
          animation: ProgressAnimation(interval: Duration(milliseconds: 150)),
        ),
      );
    }

    final response = await dio.post<ResponseBody>(
      _baseUrl,
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
            final content = response.choices?.first.delta?.content;
            if (response.choices != null && content!.isNotEmpty) {
              msg.write(content);
              if (shouldDebug) {
                logger.info('\n${darkGray.wrap(jsonEncode(decodedJson))}\n');
              } else {
             
                progress?.update(msg.length.toString());
              }
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

    progress?.complete();

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
          model: model,
          parameters: parameters);
      final tokenUsage = lastResponse.usage;

      final usageLog =
          'Token usage | Prompt: ${tokenUsage?.promptTokens} | Completion: ${tokenUsage?.completionTokens} | Total: ${tokenUsage?.totalTokens}\n';
      logger.info(darkGray.wrap(usageLog));
    }
    if (newSession != null) {
      unawaited(ConfigService.saveSession(logger, session: session));
      return Success(newSession);
    } else {
      throw CustomException(
          message: 'Something went wrong - newSession is null',
          details: {'api_responses': responses},
          stack: 'OpenRouterService.invoke');
    }
  }

  ChatSession _trimSessionMessages(ChatSession session) {
    if (session.messages.length > defaultMaxMessages!) {
      final trimmedMessages = session.messages
          .where((message) => message.role != Role.user)
          .toList();
      final userMessages = session.messages
          .where((message) => message.role == Role.user)
          .toList();

      while (
          trimmedMessages.length + userMessages.length > defaultMaxMessages! &&
              userMessages.isNotEmpty) {
        userMessages.removeAt(0);
      }

      return session.copyWith(messages: [...trimmedMessages, ...userMessages]);
    }
    return session;
  }
}
