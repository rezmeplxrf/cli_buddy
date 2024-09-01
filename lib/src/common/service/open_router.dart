import 'dart:convert';

import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/service/dio.dart';
import 'package:dio/dio.dart';

final headers = {
  'HTTP-Referer': 'insightsentry.com',
  'X-Title': 'Buddy CLI',
  'Content-Type': 'application/json',
  'Authorization':
      'Bearer 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'
};

class OpenRouterService {
  Future<void> invoke() async {
    final data = json.encode({
      'model': 'mistralai/mixtral-8x7b-instruct',
      'stream': true,
      'messages': [
        {'role': 'user', 'content': 'Who are you?'},
        {'role': 'assistant', 'content': "I'm not sure, but my best guess is"}
      ]
    });
    final response = await dio.post<ResponseBody>(
      'https://openrouter.ai/api/v1/chat/completions',
      options: Options(headers: headers, responseType: ResponseType.stream),
      data: data,
    );

    final msg = StringBuffer();
    ChatMessage? aiResponse;
    await for (final chunk in response.data!.stream) {
      if (chunk.isEmpty) continue;
      final decodedString = utf8.decode(chunk);
      final parts = decodedString.split('\n');

      for (var i = 0; i < parts.length - 1; i++) {
        final part = parts[i].trim();
        if (part.contains('[DONE]')) break;
        if (part.startsWith('data:')) {
          final jsonString = part.substring(5).trim();
          if (jsonString.isNotEmpty) {
            final response = ORResponse.fromJson(
                json.decode(jsonString) as Map<String, dynamic>);

            if (response.choices != null &&
                response.choices!.first.delta?.content?.trim() != null) {
              msg.write(response.choices!.first.delta!.content);
            }
            if (response.usage != null) {
              aiResponse = ChatMessage(
                role: Role.assistant,
                content: msg.toString(),
                timestamp: DateTime.now().millisecondsSinceEpoch,
                usage: response.usage,
              );
              print(aiResponse);
            }
          }
        }
      }
    }
  }
}
