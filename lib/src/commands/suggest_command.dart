import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/domain/action.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/action.dart';
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
      ..addFlag('raw',
          abbr: 'r',
          help: 'get raw outputs of prompt and api requests',
          negatable: false);
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
    // concatenate all remaining arguments to form the prompt
    final prompt = args.join(' ');
    final initialMsg =
        Message(role: Role.user, content: prompt, timestamp: currentTime);
    final session =
        ChatSession(id: currentTime, messages: [sysMsg, initialMsg]);
    var shouldDebug = false;

    if (argResults?['raw'] == true) {
      shouldDebug = true;
    }

    final initialResult = await openRouter.invoke(
        session: session, logger: _logger, shouldDebug: shouldDebug);
    if (initialResult.isError()) {
      _logger.err('An Error occured while asking for suggested commands');
      return ExitCode.tempFail.code;
    }

    if (argResults?['desc'] == true) {
      final initialSession = initialResult.getOrThrow();
      final newResult = await ActionService.explain(initialSession, _logger,
          shouldDebug: shouldDebug);
      if (newResult.isError()) {
        _logger.err('An Error occured while asking for descriptions');
        return ExitCode.tempFail.code;
      }
    }

    final action = _logger.chooseOne(
      'Your action:',
      choices: [
        ActionType.copy,
        ActionType.run,
        ActionType.explain,
      ],
      defaultValue: ActionType.copy,
      display: (choice) {
        switch (choice) {
          case ActionType.copy:
            return 'copy';
          case ActionType.run:
            return 'run';
          case ActionType.explain:
            return 'Explain';
          default:
            throw UnimplementedError();
        }
      },
    );
    final initialSession = initialResult.getOrThrow();
    final aiCMD = initialSession.messages.last.content;
    switch (action) {
      case ActionType.copy:
        await ActionService.copy(aiCMD);

      case ActionType.run:
        await ActionService.run(aiCMD);

      case ActionType.explain:
        final explainResult = await ActionService.explain(
            initialSession, _logger,
            shouldDebug: shouldDebug);
        if (explainResult.isError()) {
          _logger.err('An Error occured while asking for explanations');
          return ExitCode.tempFail.code;
        }
      default:
        throw UnimplementedError();
    }

    return ExitCode.success.code;
  }
}
