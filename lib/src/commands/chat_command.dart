import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template suggest_command}
///
/// `buddy chat`
/// A [Command] to chat with the AI
/// {@endtemplate}
class ChatCommand extends Command<int> {
  /// {@macro suggest_command}
  ChatCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'session',
        abbr: 's',
        help: 'pass the existing chat session to AI',
        negatable: false,
      )
      ..addFlag('raw',
          abbr: 'r',
          help: 'get raw outputs of prompt and api requests',
          negatable: false);
  }

  @override
  String get description => 'Chats with the AI';

  @override
  String get name => 'chat';

  final Logger _logger;

  @override
  Future<int> run() async {
    final args = argResults?.arguments;
    if (args == null || args.isEmpty) {
      _logger.info('Usage: $name <prompt>');
      return ExitCode.usage.code;
    }
    final sessionId = argResults?['session'];
    ChatSession? session;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (sessionId != null && sessionId is int) {
      session = await ConfigService.loadSession(_logger, id: sessionId);
      final prompt = args.join(' ');
      final initialMsg =
          Message(role: Role.user, content: prompt, timestamp: currentTime);
      session = session?.copyWith(messages: [...session.messages, initialMsg]);
    } else {
      final sysMsg = Message(
          role: Role.system,
          content: PromptService.chat(),
          timestamp: currentTime);
      // concatenate all remaining arguments to form the prompt
      final prompt = args.join(' ');
      final initialMsg =
          Message(role: Role.user, content: prompt, timestamp: currentTime);
      session = ChatSession(id: currentTime, messages: [sysMsg, initialMsg]);
    }

    var shouldDebug = false;

    if (argResults?['raw'] == true) {
      shouldDebug = true;
    }

    while (true) {
      final initialResult = await OpenRouterService.invoke(
          session: session!, logger: _logger, shouldDebug: shouldDebug);
      if (initialResult.isError()) {
        _logger.err('An Error occurred');
        return ExitCode.tempFail.code;
      }
      session = initialResult.getOrThrow();

      final prompt = _logger.prompt(
        '...',
      );
      final newMsg = Message(
          role: Role.user,
          content: prompt,
          timestamp: DateTime.now().millisecondsSinceEpoch);
      session = session.copyWith(messages: [...session.messages, newMsg]);
      final newResult = await OpenRouterService.invoke(
          session: session, logger: _logger, shouldDebug: shouldDebug);
      if (newResult.isError()) {
        _logger.err('An Error occurred');
        return ExitCode.tempFail.code;
      }
      session = newResult.getOrThrow();
    }
  }
}
