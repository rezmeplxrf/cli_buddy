import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template suggest_command}
///
/// `buddy suggest`
/// A [Command] to get cli suggestion based on prompt
/// {@endtemplate}
class SuggestionCommand extends Command<int> {
  /// {@macro suggest_command}
  SuggestionCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'desc',
        abbr: 'd',
        help: 'Also describes the command',
        negatable: false,
      )
      ..addFlag(
        'raw',
        abbr: 'r',
        help: 'get raw outputs of prompt and api requests',
        negatable: false,
      );
  }

  @override
  String get description => 'Suggests a shell command based on prompt';

  @override
  String get name => 'suggest';

  final Logger _logger;

  @override
  Future<int> run() async {
    final args = argResults?.arguments;
    if (args == null || args.isEmpty) {
      _logger.info('Usage: $name <prompt>');
      return ExitCode.usage.code;
    }
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final sysMsg = Message(
        role: Role.system,
        content: PromptService.cmdOnly(),
        timestamp: currentTime);
    // check if arg is more than one if so, concatenate them
    final prompt = args.length > 1 ? args.join(' ') : args.first;
    final initialMsg =
        Message(role: Role.user, content: prompt, timestamp: currentTime);
    final session = ChatSession(messages: [sysMsg, initialMsg]);
    var shouldDebug = false;

    if (argResults?['raw'] != null && argResults?['raw'] == true) {
      shouldDebug = true;
    }

    final response = await OpenRouterService.invoke(
        session: session, logger: _logger, debug: shouldDebug);

    if (argResults?['desc'] != null &&
        argResults?['desc'] == true &&
        response.isSuccess()) {
      final nextMsg = Message(
          role: Role.user,
          content: PromptService.describeCMD(),
          timestamp: currentTime);

      final newSession = response.getOrNull();
      if (newSession != null) {
        newSession.messages.add(nextMsg);
        final newResponse = await OpenRouterService.invoke(
            session: newSession, logger: _logger, debug: shouldDebug);
        if (newResponse.isError()) {
          _logger.err('An Error occured while asking for descriptions');
          return ExitCode.tempFail.code;
        } else {
          return ExitCode.success.code;
        }
      } else {
        _logger.err('An Error occured while asking for descriptions');
        return ExitCode.tempFail.code;
      }
    }
    if (response.isError()) {
      _logger.err('An Error occured while asking for suggested commands');
      return ExitCode.tempFail.code;
    }
    // TODO:
    // Before exiting, give options to
    // 1. copy the suggested command
    // 2. run it directly
    // 3. execute another prompt

    return ExitCode.success.code;
  }
}
