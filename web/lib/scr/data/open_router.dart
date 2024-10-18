import 'dart:async';
import 'dart:convert';

import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/application/session.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/constant/helper.dart';
import 'package:buddy_chat/scr/constant/pref.dart';
import 'package:buddy_chat/scr/domain/config.dart';
import 'package:buddy_chat/scr/domain/open_router.dart';
import 'package:buddy_chat/scr/domain/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_router.g.dart';

const _baseUrl = 'https://openrouter.ai/api/v1';

class OpenRouterRepository {
  OpenRouterRepository(this.ref);
  final OpenRouterRepositoryRef ref;

  Configuration? configuration;

  String getErrorMessage(String error) {
    final markdownErrorMsg = '''
#### Sorry, something went wrong

**$error**

Please try again.

If this issue persists:
- Check your credit balance and/or change the model to another one.
- If you were using a free model, please note that free models are heavily rate-limited.

$errorMessagePart
''';

    return markdownErrorMsg;
  }

  Future<Map<String, String>> getHeaders() async {
    configuration ??= await ref.read(configServiceProvider.future);
    if (configuration!.openrouterKey == null) {
      await EasyLoading.showError('OpenRouter API key not found');
      throw Exception('OpenRouter API key not found');
    }
    final header = {
      'HTTP-Referer': 'insightsentry.com',
      'X-Title': 'CLI Buddy',
      'Authorization': 'Bearer ${configuration!.openrouterKey!}',
      'Accept': 'application/json',
      'User-Agent': 'InsightSentry/CLI Buddy',
    };
    return header;
  }

  Future<Message?> invoke({
    required ChatSession session,
    required CancelToken cancelToken,
  }) async {
    final startTime = DateTime.now().millisecondsSinceEpoch / 1000;
    configuration ??= await ref.read(configServiceProvider.future);
    final maxMsg = configuration?.maxMessages ?? 20;

    final headers = await getHeaders();

    final parameters = (session.parameters != null)
        ? session.parameters
        : Parameters.fromJson(configuration!.toJson());
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

    Response<ResponseBody>? response;
    var newMessage = Message(
        role: Role.assistant,
        content: 'Thinking...',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        overriddenModelId: overriddenModelId);
    ref
        .read(currentSessionControllerProvider.notifier)
        .updateMessage(newMessage);

    try {
      response = await Global.dio.post<ResponseBody>(
        '$_baseUrl/chat/completions',
        cancelToken: cancelToken,
        options: Options(
          headers: headers,
          responseType: ResponseType.stream,
        ),
        data: prompt,
      );
    } catch (e) {
      Global.talker.error(e.toString());
      newMessage = newMessage.copyWith(
        content: getErrorMessage(e.toString()),
      );
      ref
          .read(currentSessionControllerProvider.notifier)
          .updateMessage(newMessage);

      throw Exception(e.toString());
    }

    final msgBuffer = StringBuffer();

    Usage? usage;
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
            if (response.usage?.completionTokens != null) {
              usage = response.usage;
            }

            final content = response.choices?.first.delta?.content ?? '';
            msgBuffer.write(content);

            newMessage = newMessage.copyWith(
              content: msgBuffer.toString(),
            );
            ref
                .read(currentSessionControllerProvider.notifier)
                .updateMessage(newMessage);

            if (response.choices?.first.error != null) {
              msgBuffer.clear();
              Global.talker.error(response.choices!.first.error.toString());
              newMessage = newMessage.copyWith(
                content:
                    getErrorMessage(response.choices!.first.error.toString()),
              );
              ref
                  .read(currentSessionControllerProvider.notifier)
                  .updateMessage(newMessage);
            }
          }
        }
      }
    }

    final finishTime = DateTime.now().millisecondsSinceEpoch / 1000;
    final difference = ((finishTime - startTime) * 10).ceil() / 10;

    return newMessage.copyWith(
        content: msgBuffer.toString(),
        usage: usage?.copyWith(responseTime: difference));
  }

  Future<ChatSession?> validate({
    required ValidateRequest request,
    required CancelToken cancelToken,
  }) async {
    final startTime = DateTime.now().millisecondsSinceEpoch / 1000;
    configuration ??= await ref.read(configServiceProvider.future);

    final headers = await getHeaders();
    final overridingModel =
        await ref.read(selectedOverridingModelProvider.future);
    final prompt = <String, dynamic>{
      'model':
          request.modelId ?? overridingModel ?? request.currentSession.modelId,
      'stream': true,
      'messages': [
        Helper.toAPICompatibleJson(request.sysPrompt),
        Helper.toAPICompatibleJson(request.targetMessage),
        Helper.toAPICompatibleJson(Message(
            role: Role.user,
            content:
                'The Previous message is written by another AI assistant. Review the previous message according to the System guideline',
            timestamp: DateTime.now().millisecondsSinceEpoch))
      ],
    };

    if (request.parameters != null) {
      prompt.addAll(request.parameters!.toJson());
    }
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    var newMessage = Message(
        role: Role.reviewer, content: 'Reviewing...', timestamp: timeStamp);

    Response<ResponseBody>? response;

    try {
      response = await Global.dio.post<ResponseBody>(
        '$_baseUrl/chat/completions',
        cancelToken: cancelToken,
        options: Options(headers: headers, responseType: ResponseType.stream),
        data: prompt,
      );
    } catch (e) {
      Global.talker.error(e.toString());
      newMessage = newMessage.copyWith(
        content: getErrorMessage(e.toString()),
      );
      ref
          .read(currentSessionControllerProvider.notifier)
          .updateMessage(newMessage);
      throw Exception(e.toString());
    }

    final msgBuffer = StringBuffer();

    Usage? usage;

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
            if (response.usage?.completionTokens != null) {
              usage = response.usage;
            }

            final content = response.choices?.first.delta?.content ?? '';
            msgBuffer.write(content);
            newMessage = newMessage.copyWith(
              content: msgBuffer.toString(),
            );
            ref
                .read(currentSessionControllerProvider.notifier)
                .updateMessage(newMessage);

            if (response.choices?.first.error != null) {
              msgBuffer.clear();
              Global.talker.error(response.choices!.first.error.toString());
              newMessage = newMessage.copyWith(
                content:
                    getErrorMessage(response.choices!.first.error.toString()),
              );
              ref
                  .read(currentSessionControllerProvider.notifier)
                  .updateMessage(newMessage);
            }
          }
        }
      }
    }

    final finishTime = DateTime.now().millisecondsSinceEpoch / 1000;
    final difference = ((finishTime - startTime) * 10).ceil() / 10;
    final validatedResult = Validation(
      modelId: request.modelId ?? request.currentSession.modelId,
      result: msgBuffer.toString(),
      timestamp: timeStamp,
      usage: usage?.copyWith(responseTime: difference),
    );

    final updatedMessage = request.targetMessage.copyWith(
      validation: validatedResult,
    );
    ref
        .read(currentSessionControllerProvider.notifier)
        .updateMessage(updatedMessage);

    // Update the message in the session
    final updatedMessages = request.currentSession.messages.map((m) {
      if (m.timestamp == request.targetMessage.timestamp) {
        return m.copyWith(validation: validatedResult);
      }
      return m;
    }).toList();

    return request.currentSession.copyWith(messages: updatedMessages);
  }

  Future<AutoComplete?> autoComplete({
    required AutoComplete autoComplete,
    required CancelToken cancelToken,
  }) async {
    if (autoComplete.context == null ||
        autoComplete.context!.isEmpty ||
        autoComplete.sysSrompt == null) {
      throw Exception('Context cannot be empty');
    }
    final startTime = DateTime.now().millisecondsSinceEpoch / 1000;

    final headers = await getHeaders();
    final now = DateTime.now().millisecondsSinceEpoch;
    final prompt = <String, dynamic>{
      'model': autoComplete.modelId,
      'messages': [
        Helper.toAPICompatibleJson(Message(
            role: Role.system,
            content: autoComplete.sysSrompt!,
            timestamp: now)),
        Helper.toAPICompatibleJson(Message(
            role: Role.user, content: autoComplete.context!, timestamp: now)),
      ],
    };

    try {
      final response = await Global.dio.post<Map<String, dynamic>>(
        '$_baseUrl/chat/completions',
        cancelToken: cancelToken,
        options: Options(headers: headers, responseType: ResponseType.json),
        data: prompt,
      );
      if (response.data == null) {
        throw Exception('response.data is Empty');
      }
      final parsedData = ORResponse.fromJson(response.data!);
      final finishTime = DateTime.now().millisecondsSinceEpoch / 1000;
      final difference = ((finishTime - startTime) * 10).ceil() / 10;

      final updatedAutoComplete = autoComplete.copyWith(
          result: parsedData.choices?.first.message?.content,
          usage: Usage(
              completionTokens: parsedData.usage?.completionTokens,
              promptTokens: parsedData.usage?.promptTokens,
              totalTokens: parsedData.usage?.totalTokens,
              responseTime: difference));
      return updatedAutoComplete;
    } catch (e) {
      Global.talker.error(e.toString());
      return null;
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

  Future<List<ORModel>> getModelList() async {
    configuration ??= await ref.read(configServiceProvider.future);
    final headers = await getHeaders();
    const url = '$_baseUrl/models';
    try {
      final response = await Global.dio.get<Map<String, dynamic>>(url,
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

      return list;
    } catch (e) {
      Global.talker.error('Failed to get models from OpenRouter');
      throw Exception(e.toString());
    }
  }

  Future<ORCredit> checkCredits() async {
    const url = '$_baseUrl/auth/key';
    configuration ??= await ref.read(configServiceProvider.future);
    final headers = await getHeaders();
    try {
      final response = await Global.dio.get<Map<String, dynamic>>(url,
          options: Options(headers: headers));

      final data = response.data?['data'] as Map<String, dynamic>;

      final credits = ORCredit.fromJson(data);
      return credits;
    } catch (e) {
      Global.talker.error('Failed to get credit data from OpenRouter');
      throw Exception(e.toString());
    }
  }

  Future<ParameterInfo> getParameterInfo({required String model}) async {
    final encodedModel = Uri.encodeComponent(model);
    final url = '$_baseUrl/parameters/$encodedModel';
    configuration ??= await ref.read(configServiceProvider.future);
    final headers = await getHeaders();
    try {
      final response = await Global.dio.get<Map<String, dynamic>>(url,
          options: Options(headers: headers));
      if (response.statusCode == 200 && response.data == null) {
        throw Exception('response.data is Empty');
      }
      final data = response.data?['data'] as Map<String, dynamic>;
      final parameterInfo = ParameterInfo.fromJson(data);
      return parameterInfo;
    } catch (e) {
      Global.talker
          .error('Failed to get parameter info from OpenRouter. Error: $e');
      throw Exception(e.toString());
    }
  }
}

@riverpod
OpenRouterRepository openRouterRepository(OpenRouterRepositoryRef ref) {
  return OpenRouterRepository(ref);
}

@riverpod
Future<AutoComplete?> openRouterAutoComplete(OpenRouterAutoCompleteRef ref,
    {required String context}) async {
  final link = ref.cacheFor(const Duration(minutes: 10));
  final config = await ref.read(autoCompleteControllerProvider.future);
  if (config == null || config.enabled == false) {
    link?.close();
    return null;
  }

  final cancelToken = CancelToken();
  var didReceiveResponse = false;
  ref.onDispose(() {
    if (!didReceiveResponse) {
      cancelToken.cancel();
      link?.close();
      return;
    }
  });
  final repo = ref.watch(openRouterRepositoryProvider);
  final updatedConfig = config.copyWith(context: context);
  final response = await repo.autoComplete(
      autoComplete: updatedConfig, cancelToken: cancelToken);
  if (response == null || response.result == null) {
    link?.close();
    return null;
  }

  didReceiveResponse = true;
  unawaited(
      ref.read(autoCompleteControllerProvider.notifier).saveUsage(response));
  return response;
}

// @riverpod
// Future<Message?> openrouterSendMessage(
//   OpenrouterSendMessageRef ref, {
//   required ChatSession session,
// }) async {
//   final link = ref.keepAlive();

//   final cancelToken = CancelToken();
//   var didReceiveResponse = false;
//   ref.onDispose(() {
//     if (!didReceiveResponse) {
//       cancelToken.cancel();
//       return;
//     }
//   });
//   final repo = ref.watch(openRouterRepositoryProvider);
//   final response =
//       await repo.invoke(session: session, cancelToken: cancelToken);

//   didReceiveResponse = true;
//   Timer.periodic(const Duration(seconds: 3), (timer) {
//     timer.cancel();
//     link.close();
//   });

//   return response;
// }

@riverpod
Future<ChatSession?> openrouterRequestValidation(
  OpenrouterRequestValidationRef ref, {
  required ValidateRequest request,
}) async {
  final link = ref.keepAlive();

  final cancelToken = CancelToken();
  var didReceiveResponse = false;
  ref.onDispose(() {
    if (!didReceiveResponse) {
      cancelToken.cancel();
      return;
    }
  });
  final repo = ref.watch(openRouterRepositoryProvider);
  final response =
      await repo.validate(request: request, cancelToken: cancelToken);

  didReceiveResponse = true;

  Timer.periodic(const Duration(seconds: 3), (timer) {
    timer.cancel();
    link.close();
  });

  return response;
}

@riverpod
FutureOr<List<ORModel>> listOpenRouterModels(
  ListOpenRouterModelsRef ref,
) async {
  // check prefs
  final exipration = await prefs.getInt('model_expiration');
  if (exipration != null &&
      exipration > DateTime.now().millisecondsSinceEpoch) {
    final savedModels = await prefs.getString('models');
    if (savedModels != null) {
      final data = jsonDecode(savedModels) as List<dynamic>;
      final models = data
          .map((json) => ORModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return models;
    }
  }

  final link = ref.keepAlive();
  try {
    final repo = ref.watch(openRouterRepositoryProvider);
    final response = await repo.getModelList();

    // 24 hours later
    await prefs.setInt('model_expiration',
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch);
    await prefs.setString('models', jsonEncode(response));
    return response;
  } catch (e) {
    Global.talker.error(e.toString());
    link.close();
    return [];
  }
}

@riverpod
FutureOr<ParameterInfo?> queryParameters(QueryParametersRef ref,
    {required String model}) async {
  final repo = ref.watch(openRouterRepositoryProvider);
  ref.cacheFor(const Duration(minutes: 5));
  try {
    final response = await repo.getParameterInfo(model: model);

    return response;
  } catch (e) {
    Global.talker.error(e.toString());

    return null;
  }
}
