import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:cli_buddy/src/common/service/markdown.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:cli_buddy/src/common/service/web.dart';
import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

const _baseUrl = 'https://openrouter.ai/api/v1';

class OpenRouterService {
  factory OpenRouterService() => _instance;
  OpenRouterService._internal();
  static final OpenRouterService _instance = OpenRouterService._internal();

  static void setLogger(Logger? logger) => _logger = logger;
  // TODO: When clients disconnect or cancel, also cancel the request via cancelToken
  static CancelToken? cancelToken;
  static Logger? _logger;

  Future<Map<String, String>> getHeaders() async {
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    final header = {
      'HTTP-Referer': 'insightsentry.com',
      'X-Title': 'CLI Buddy',
      'Authorization': 'Bearer $openrouterKey',
      'Accept': 'application/json',
      'User-Agent': 'InsightSentry/CLI Buddy',
    };
    return header;
  }

  Future<Result<ChatSession, CustomException>> invoke({
    required ChatSession session,
    bool? markdown,
    bool? shouldDebug = false,
    int? overrideMaxMsg,
  }) async {
    final startTime = DateTime.now().millisecondsSinceEpoch / 1000;
    const waitingMsg = 'Waiting for response...';
    final progress = _logger?.progress(
      green.wrap(waitingMsg)!,
      options: const ProgressOptions(
        animation: ProgressAnimation(interval: Duration(milliseconds: 150)),
      ),
    );

    final maxMsg = overrideMaxMsg ?? configuration?.maxMessages ?? 20;
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();

    final headers = await getHeaders();

    final model = session.model;
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
    cancelToken = CancelToken();
    Response<ResponseBody>? response;

    try {
      response = await dio.post<ResponseBody>(
        '$_baseUrl/chat/completions',
        cancelToken: cancelToken,
        options: Options(headers: headers, responseType: ResponseType.stream),
        data: prompt,
      );
    } catch (e) {
      progress?.fail();
      final errorMsg = MessageChunk(
          type: ChunkType.error,
          content:
              'An error occurred while requesting the API - Status code: ${response?.statusCode} | message: ${response?.statusMessage}');
      WebService.webSocket?.sink.add(jsonEncode(errorMsg));

      return CustomException(
        message: 'Error while making API request.',
        stack: 'OpenRouterService.invoke',
        details: {'error': e.toString()},
      ).toFailure();
    }

    final msgBuffer = StringBuffer();

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

      if (!firstChunk && markdown != null && !markdown) {
        firstChunk = true;
        progress?.complete('');
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
            final content = response.choices?.first.delta?.content ?? '';
            msgBuffer.write(content);

            if (shouldDebug != null && shouldDebug) {
              _logger?.info('\n${darkGray.wrap(jsonEncode(decodedJson))}\n');
            } else {
              final msgChunk = MessageChunk(
                  type: ChunkType.chunk, content: msgBuffer.toString());
              WebService.webSocket?.sink.add(jsonEncode(msgChunk));
              // send chunked message to the websocket here
              if (stdout.hasTerminal && markdown != null && !markdown) {
                stdout.write(cyan.wrap(content));
                index = msgBuffer.length;

                if ((index - lineStart) >= consoleWidth) {
                  stdout.writeln();
                  lineStart = index;
                }
              }
            }

            if (response.choices?.first.error != null) {
              msgBuffer.clear();
              progress?.fail();
              final msgChunk = MessageChunk(
                  type: ChunkType.error,
                  content:
                      'An error occured while processing the API streaming message | error: ${response.choices?.first.error?.message}');
              WebService.webSocket?.sink.add(jsonEncode(msgChunk));
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

    if (markdown != null && markdown) {
      progress?.complete('');
      _logger?.info(markdownStyle.apply(msgBuffer.toString()));
    }

    if (responses.isNotEmpty) {
      final finishTime = DateTime.now().millisecondsSinceEpoch / 1000;
      final difference = ((finishTime - startTime) * 10).ceil() / 10;
      final aiResponse = Message(
        role: Role.assistant,
        content: msgBuffer.toString(),
        timestamp: DateTime.now().millisecondsSinceEpoch,
        usage: usage?.copyWith(responseTime: difference),
      );
      newSession = session.copyWith(
          messages: [...session.messages, aiResponse],
          model: model,
          parameters: parameters);

      final usageLog =
          '\nToken usage | Prompt: ${usage?.promptTokens} | Completion: ${usage?.completionTokens} | Total: ${usage?.totalTokens} | Time: ${difference}s\n';
      _logger?.info(darkGray.wrap(usageLog));

      await SessionService.saveSession(session: newSession);

      return Success(newSession);
    } else {
      msgBuffer.clear();
      progress?.fail();
      _logger?.err('Something went wrong');
      const msgChunk = MessageChunk(
          type: ChunkType.error,
          content: 'An unexpected error occured - responses are empty');
      WebService.webSocket?.sink.add(jsonEncode(msgChunk));
      return CustomException(
              message: 'Something went wrong - newSession is null',
              details: {'api_responses': responses},
              stack: 'OpenRouterService.invoke')
          .toFailure();
    }
  }

  Future<Result<ChatSession, CustomException>> validate({
    required ValidateRequest request
  }) async {
    final startTime = DateTime.now().millisecondsSinceEpoch / 1000;
    const waitingMsg = 'Waiting for response...';
    final progress = _logger?.progress(
      green.wrap(waitingMsg)!,
      options: const ProgressOptions(
        animation: ProgressAnimation(interval: Duration(milliseconds: 150)),
      ),
    );

    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    final headers = await getHeaders();

    final prompt = <String, dynamic>{
      'model': request.modelId ?? request.session.model,
      'stream': true,
      'messages': [request.sysPrompt.toJson(), request.message.toJson()],
    };

    if (request.parameters != null) {
      prompt.addAll(request.parameters!.toJson());
    }

    Response<ResponseBody>? response;

    try {
      response = await dio.post<ResponseBody>(
        '$_baseUrl/chat/completions',
        options: Options(headers: headers, responseType: ResponseType.stream),
        data: prompt,
      );
    } catch (e) {
      progress?.fail();
      _logger?.err(e.toString());

      return CustomException(
        message: 'Error while making API request.',
        stack: 'OpenRouterService.invoke',
        details: {'error': e.toString()},
      ).toFailure();
    }

    final msgBuffer = StringBuffer();

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
        progress?.complete('');
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
            final content = response.choices?.first.delta?.content ?? '';
            msgBuffer.write(content);

            if (stdout.hasTerminal) {
              stdout.write(cyan.wrap(content));
              index = msgBuffer.length;

              if ((index - lineStart) >= consoleWidth) {
                stdout.writeln();
                lineStart = index;
              }
            }

            if (response.choices?.first.error != null) {
              msgBuffer.clear();
              progress?.fail();
              _logger?.err('An Error occured from the provider');
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

    if (responses.isNotEmpty) {
      final finishTime = DateTime.now().millisecondsSinceEpoch / 1000;
      final difference = ((finishTime - startTime) * 10).ceil() / 10;
      final validatedResult = Validation(
        model: request.modelId ?? request.session.model,
        result: msgBuffer.toString(),
        timestamp: DateTime.now().millisecondsSinceEpoch,
        usage: usage?.copyWith(responseTime: difference),
      );
      // Update the message in the session
      final updatedMessages = request.session.messages.map((m) {
        if (m == request.message) {
          return m.copyWith(validation: validatedResult);
        }
        return m;
      }).toList();

      newSession = request.session.copyWith(messages: updatedMessages);

      final usageLog =
          '\nToken usage | Prompt: ${usage?.promptTokens} | Completion: ${usage?.completionTokens} | Total: ${usage?.totalTokens} | Time: ${difference}s\n';
      _logger?.info(darkGray.wrap(usageLog));

      await SessionService.saveSession(session: newSession);

      return newSession.toSuccess();
    } else {
      msgBuffer.clear();
      progress?.fail();
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

  Future<Result<List<ORModel>, CustomException>> getModelList() async {
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    const url = '$_baseUrl/models';
    final headers = await getHeaders();
    try {
      final response = await dio.get<Map<String, dynamic>>(url,
          options: Options(headers: headers));
      final list = <ORModel>[];
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
        list.add(ORModel.fromJson(model));
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
    const url = '$_baseUrl/auth/key';
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    final headers = await getHeaders();
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
    final url = '$_baseUrl/parameters/$encodedModel';
    openrouterKey ??= await ConfigService.loadOpenrouterKey().getOrThrow();
    final headers = await getHeaders();
    try {
      final response = await dio.get<Map<String, dynamic>>(url,
          options: Options(headers: headers));
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
