import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/models/exception.dart';
import 'package:cli_buddy/src/common/models/open_router.dart';
import 'package:cli_buddy/src/common/models/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:cli_buddy/src/common/service/helper.dart';
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
   
    final msgBuffer = StringBuffer();
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

    final parameters =
        (session.parameters != null) ? session.parameters : parametersCache;
    final overriddenModelId = session.messages.last.overriddenModelId;
    final trimedSession = _removeOldMessages(session, maxMsg);
    final prompt = <String, dynamic>{
      'model': overriddenModelId ?? session.modelId,
      'stream': true,
      'messages':
          trimedSession.messages.map(Helper.toAPICompatibleJson).toList(),
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        _logger?.info('Request was cancelled.');
       
        final msgChunk = MessageChunk(
            type: ChunkType.end,
            content: msgBuffer.toString(),
           );
        WebService.webSocket?.sink.add(jsonEncode(msgChunk));
        return session.toSuccess();
      } else {
        rethrow;
      }
    } catch (e) {
      progress?.fail();

      return CustomException(
        message: 'Error while making API request. - $e',
        stack: 'OpenRouterService.invoke',
        details: {'error': e.toString()},
      ).toFailure();
    }
 Usage? usage;
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

              return CustomException(
                  message:
                      'An Error occured from the provider - ${response.choices!.first.error?.toJson()}',
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

    final finishTime = DateTime.now().millisecondsSinceEpoch / 1000;
    final difference = ((finishTime - startTime) * 10).ceil() / 10;
    final aiResponse = Message(
      role: Role.assistant,
      content: msgBuffer.toString(),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      usage: usage?.copyWith(responseTime: difference),
    );
    final newSession = session.copyWith(
      messages: [...session.messages, aiResponse],
    );

    final usageLog =
        '\nToken usage | Prompt: ${usage?.promptTokens} | Completion: ${usage?.completionTokens} | Total: ${usage?.totalTokens} | Time: ${difference}s\n';
    _logger?.info(darkGray.wrap(usageLog));

    await SessionService.saveSession(session: newSession);

    return newSession.toSuccess();
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
