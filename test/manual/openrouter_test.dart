import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> main() async {
  const session = ChatSession(
    messages: [
      Message(
          role: Role.user,
          content:
              'Can you perform function callings if I provide you with tools?',
          timestamp: 0)
    ],
  );
  final logger = Logger();
  final result =
      await OpenRouterService.invoke(session: session, logger: logger, debug: false);
  result.fold(
    (success) {
 
    },
    (failure) {
      print(failure.toJson());
    },
  );
}
