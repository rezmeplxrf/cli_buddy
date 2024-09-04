import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

final openRouter = OpenRouterService();
const _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';

class OpenRouterService {
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();
  static final OpenRouterService _instance = OpenRouterService._internal();

  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;
  Future<Result<ChatSession, CustomException>> invoke(
      {required ChatSession session,
      bool? shouldDebug = false,
      int? overrideMaxMsg,

      /// Whether to skip logging. Used when there is no terminal or when markdown is needed.
      /// In order to use markdown in console, real time logging must be disabled.
      bool? shouldSkipLog,
      bool? markdown}) async {
    const waitingMsg = 'Waiting for response...';
    final progress = _logger?.progress(
      green.wrap(waitingMsg)!,
      options: const ProgressOptions(
        animation: ProgressAnimation(interval: Duration(milliseconds: 150)),
      ),
    );

    final skipLog = shouldSkipLog != null && shouldSkipLog;
    final maxMsg = overrideMaxMsg ?? configuration?.maxMessages ?? 20;
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();

    final headers = {
      'HTTP-Referer': 'rfway.org',
      'X-Title': 'CLI Buddy',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openrouterKey',
      'User-Agent': 'InsightSentry/CLI Buddy',
    };

    final model = (session.model != null)
        ? session.model
        : configuration?.defaultModel ?? fallbackModel;
    final parameters =
        (session.parameters != null) ? session.parameters : parametersCache;

    final trimedSession = _removeOldMessages(session, maxMsg);
    final prompt = <String, dynamic>{
      'model': model,
      'stream': true,
      'messages': trimedSession.messages,
    };

    if (parameters != null) {
      prompt.addAll(parameters.toJson());
    }

    _logger?.info(
      '\n',
    );
    if (shouldDebug != null && shouldDebug) {
      final promptForDebug = json.encode(prompt);
      final log = '''

## Prompt
${lightCyan.wrap(promptForDebug)}

## Response
''';
      _logger?.info(log);
    }

    Response<ResponseBody>? response;
    try {
      response = await dio.post<ResponseBody>(
        _baseUrl,
        options: Options(headers: headers, responseType: ResponseType.stream),
        data: prompt,
      );
    } catch (e) {
      return CustomException(
        message: 'Error while making API request.',
        stack: 'OpenRouterService.invoke',
        details: {'error': e.toString()},
      ).toFailure();
    }

    final msg = StringBuffer();

    ChatSession? newSession;
    Usage? usage;
    final responses = <ORResponse>[];
    var index = 0;
    var lineStart = 0;
    final consoleWidth =
        (stdout.hasTerminal) ? stdout.terminalColumns - 20 : 80;
    var firstChunk = false;
    await for (final chunk in response.data!.stream) {
      if (chunk.isEmpty) continue;

      if (!firstChunk) {
        firstChunk = true;
        progress?.complete();
      }

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
            if (response.usage?.completionTokens != null) {
              usage = response.usage;
            }
            responses.add(response);
            final content = response.choices?.first.delta?.content;
            if (content != null && content.isNotEmpty) {
              msg.write(content);
              if (shouldDebug != null && shouldDebug) {
                _logger?.info('\n${darkGray.wrap(jsonEncode(decodedJson))}\n');
              } else {
                if (!skipLog) {
                  stdout.write(cyan.wrap(content));
                  index = msg.length;

                  if ((index - lineStart) >= consoleWidth) {
                    stdout.writeln();
                    lineStart = index;
                  }
                }
              }
            }

            if (response.choices?.first.error != null) {
              return CustomException(
                  message: 'An Error occured from the provider',
                  stack: 'OpenRouterService.invoke',
                  details: {
                    'api_error_message': response.choices!.first.error?.toJson()
                  }).toFailure();
            }
          }
        }
      }
    }
    if (!skipLog) {
      stdout.writeln();
    }
    // TODO: if markdown and skipLog is true, print out markdown applied msg here

    if (responses.isNotEmpty) {
      final aiResponse = Message(
        role: Role.assistant,
        content: msg.toString(),
        timestamp: DateTime.now().millisecondsSinceEpoch,
        usage: usage,
      );
      newSession = session.copyWith(
          messages: [...session.messages, aiResponse],
          model: model,
          parameters: parameters);

      final usageLog =
          'Token usage | Prompt: ${usage?.promptTokens} | Completion: ${usage?.completionTokens} | Total: ${usage?.totalTokens}\n';
      _logger?.info(darkGray.wrap(usageLog));
    }
    if (newSession != null) {
      unawaited(SessionService.saveSession(session: session));
      return Success(newSession);
    } else {
      _logger?.err('Something went wrong');
      return CustomException(
              message: 'Something went wrong - newSession is null',
              details: {'api_responses': responses},
              stack: 'OpenRouterService.invoke')
          .toFailure();
    }
  }

  ChatSession _removeOldMessages(ChatSession session, int maxMsg) {
    if (session.messages.length > maxMsg) {
      final excessMessagesCount = session.messages.length - maxMsg;
      final trimmedMessages = session.messages.sublist(excessMessagesCount);
      return session.copyWith(messages: trimmedMessages);
    }
    return session;
  }

  Future<Result<List<ORModelList>, CustomException>> getModelList() async {
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    const url = 'https://openrouter.ai/api/v1/models';
    final header = {
      'Authorization': 'Bearer $openrouterKey',
      'User-Agent': 'InsightSentry/CLI Buddy',
    };
    try {
      final response = await dio.get<Map<String, dynamic>>(url,
          options: Options(headers: header));
      //  print(response.data);
      final list = <ORModelList>[];
      if (response.data == null) {
        throw Exception('response.data is Empty');
      }
      for (final data in response.data!['data'] as List<dynamic>) {
        final model = data as Map<String, dynamic>;
        final name = model['name'] as String?;
        if (name != null &&
            (name.startsWith('Flavor') || name.startsWith('Auto'))) {
          continue;
        }
        list.add(ORModelList.fromJson(model));
      }

      return list.toSuccess();
    } catch (e) {
      _logger?.err('Failed to get models from OpenRouter');
      return CustomException(
          message: 'Failed to get models from OpenRouter',
          stack: 'OpenRouterService.getCloudAIModelList',
          details: {'error': e.toString()}).toFailure();
    }
  }

  Future<Result<ORCredit, CustomException>> checkCredits() async {
    const url = 'https://openrouter.ai/api/v1/auth/key';
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    final headers = {
      'Authorization': 'Bearer $openrouterKey',
      'User-Agent': 'InsightSentry/CLI Buddy',
    };
    try {
      final response = await dio.get<Map<String, dynamic>>(url,
          options: Options(headers: headers));

      final data = response.data?['data'] as Map<String, dynamic>;

      final credits = ORCredit.fromJson(data);
      return credits.toSuccess();
    } catch (e) {
      _logger?.err('Failed to get credit data from OpenRouter');
      return CustomException(
          message: 'Failed to get credit data from OpenRouter',
          stack: 'OpenRouterService.getCloudAIModelList',
          details: {'error': e.toString()}).toFailure();
    }
  }

  Future<Result<ParameterInfo, CustomException>> getParameterInfo(
      {required String model}) async {
    final encodedModel = Uri.encodeComponent(model);
    final url = 'https://openrouter.ai/api/v1/parameters/$encodedModel';
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    final header = {
      'Authorization': 'Bearer $openrouterKey',
      'Accept': 'application/json',
      'User-Agent': 'InsightSentry/CLI Buddy',
    };
    try {
      final response = await dio.get<Map<String, dynamic>>(url,
          options: Options(headers: header));
      if (response.statusCode == 200 && response.data == null) {
        throw Exception('response.data is Empty');
      }
      final data = response.data?['data'] as Map<String, dynamic>;
      final parameterInfo = ParameterInfo.fromJson(data);
      return parameterInfo.toSuccess();
    } catch (e) {
      _logger?.err('Failed to get parameter info from OpenRouter. Error: $e');
      return CustomException(
          message: 'Failed to get parameter info from OpenRouter',
          stack: 'OpenRouterService.getParameterInfo',
          details: {'error': e.toString()}).toFailure();
    }
  }
}

// List<ORModelList> _applyOrder(List<ORModelList> data, String order) {
//   switch (order) {
//     case 'name':
//       data.sort((a, b) => a.name.compareTo(b.name));
//     case 'context':
//       data.sort(
//           (a, b) => (a.contextLength ?? 0).compareTo(b.contextLength ?? 0));
//     case 'prompt':
//       data.sort(
//           (a, b) => ((a.pricing?.prompt).toin ?? 0).compareTo(b.pricing?.prompt ?? 0));
//     case 'completion':
//       data.sort((a, b) =>
//           (a.pricing?.completion ?? 0).compareTo(b.pricing?.completion ?? 0));
//     case 'image':
//       data.sort(
//           (a, b) => (a.pricing?.image ?? 0).compareTo(b.pricing?.image ?? 0));
//     default:
//       break;
//   }
//   return data;
// }
