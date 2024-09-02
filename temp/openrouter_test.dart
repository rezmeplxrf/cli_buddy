import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/action.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> main() async {
  final session = ChatSession(
    id: 0,
    messages: [
      Message(
          role: Role.system, content: PromptService.chat(), timestamp: 0),
      const Message(
          role: Role.user, content: 'how can I update homebrew', timestamp: 0)
    ],
  );
  final logger = Logger();
  final result = await OpenRouterService.invoke(
      session: session, logger: logger, shouldDebug: false);
  result.fold(
    (success) {
      final lastMsg = success.messages.last.content;
      ActionService.run(lastMsg);
      ActionService.copy(lastMsg);
    },
    (failure) {
      print(failure.toJson());
    },
  );
}
