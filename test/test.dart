import 'dart:convert';

import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:dio/dio.dart';

Future<void> main() async {
  final headers = {
    'HTTP-Referer': 'insightsentry.com',
    'X-Title': 'Buddy CLI',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer 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'
  };
  final data = json.encode({
    'model': 'mistralai/mixtral-8x7b-instruct',
    'stream': true,
    'messages': [
      {'role': 'user', 'content': 'Who are you?'},
      {'role': 'assistant', 'content': "I'm not sure, but my best guess is"}
    ]
  });
  final dio = Dio();
  final response = await dio.post<ResponseBody>(
    'https://openrouter.ai/api/v1/chat/completions',
    options: Options(headers: headers, responseType: ResponseType.stream),
    data: data,
  );

  final msg = StringBuffer();
  ORResponse? metrics;
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
            metrics = response.choices!.first.delta!.copyWith(content: msg.toString());
            print(metrics);
          }
        }
      }
    }
  }
}
