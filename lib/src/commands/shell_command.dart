import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/models/action.dart';
import 'package:cli_buddy/src/common/models/config.dart';
import 'package:cli_buddy/src/common/models/session.dart';
import 'package:cli_buddy/src/common/service/action.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/global.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

/// {@template shell_command}
///
/// `buddy shell`
/// A [Command] to get cli suggestion based on prompt
/// {@endtemplate}
class ShellCommand extends Command<int> {
  /// {@macro shell_command}
  ShellCommand({
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
  String get description => 'Generate a shell command';

  @override
  String get name => 'shell';

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
      session = await SessionService.loadSession(id: sessionId);
      final prompt = args.join(' ');
      final initialMsg =
          Message(role: Role.user, content: prompt, timestamp: currentTime);
      session = session?.copyWith(messages: [...session.messages, initialMsg]);
    } else {
      final sysMsg = Message(
          role: Role.system,
          content: PromptService.cmdOnly(),
          timestamp: currentTime);
      // concatenate all remaining arguments to form the prompt
      final prompt = args.join(' ');
      final initialMsg =
          Message(role: Role.user, content: prompt, timestamp: currentTime);
            configuration ??= await ConfigService.loadConfig().getOrThrow();
                   final modelId = (configuration!.apiProvider == APIProvider.openrouter)
          ? configuration!.openrouterDefaultModel
          : configuration!.ollamaDefaultModel;
              if (modelId == null){
                _logger.err('Default APIProvider is not found');
                return ExitCode.tempFail.code;
              }
      session = ChatSession(id: currentTime, messages: [sysMsg, initialMsg], modelId: modelId);
    }

    var shouldDebug = false;

    if (argResults?['raw'] == true) {
      shouldDebug = true;
    }

    final initialResult =
        await openRouter.invoke(session: session!, shouldDebug: shouldDebug, markdown: false);
    if (initialResult.isError()) {
      _logger.err('An Error occured while asking for suggested commands');
      return ExitCode.tempFail.code;
    }

    final action = _logger.chooseOne(
      'Your action:',
      choices: [
        ActionType.copy,
        ActionType.run,
        ActionType.explain,
        ActionType.exit
      ],
      defaultValue: ActionType.copy,
      display: (choice) {
        switch (choice) {
          case ActionType.copy:
            return 'copy';
          case ActionType.run:
            return 'run';
          case ActionType.explain:
            return 'explain';
          case ActionType.exit:
            return 'exit';
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
        final explainResult = await ActionService.explain(initialSession,
            shouldDebug: shouldDebug);
        if (explainResult.isError()) {
          _logger.err('An Error occured while asking for explanations');
          return ExitCode.tempFail.code;
        }
      case ActionType.exit:
        return ExitCode.success.code;
      default:
        throw UnimplementedError();
    }

    return ExitCode.success.code;
  }
}
