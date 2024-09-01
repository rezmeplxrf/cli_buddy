import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> main() async {
  const session = ChatSession(
      model: 'openai/gpt-4o-mini-2024-07-18',
      messages: [
        Message(
            role: Role.user,
            content:
                'Can you perform function callings if I provide you with tools?',
            timestamp: 0)
      ],
      parameters: Parameters(temperature: 1));
  final result = await OpenRouterService.invoke(session: session, logger: Logger());
  result.fold(
    (success) {
      // handle the success here
      print(success.toJson());
    },
    (failure) {
      print(failure.toJson());
    },
  );
}
