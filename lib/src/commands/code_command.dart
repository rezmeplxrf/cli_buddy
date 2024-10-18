import 'dart:async';

import 'package:args/command_runner.dart';
import '../common/models/action.dart';
import '../common/models/config.dart';
import '../common/models/session.dart';
import '../common/service/action.dart';
import '../common/service/config.dart';
import '../common/service/global.dart';
import '../common/service/prompts.dart';
import '../common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

/// {@template code_command}
///
/// `buddy chat`
/// A [Command] to chat with the AI
/// {@endtemplate}
class CodeCommand extends Command<int> {
  /// {@macro code_command}
  CodeCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'session',
        abbr: 's',
        help: 'Pass the existing chat session to AI',
        negatable: false,
      )
      ..addFlag('raw',
          abbr: 'r',
          help: 'Display raw outputs of prompt and api requests',
          negatable: false);
  }

  @override
  String get description => 'Generates code based on prompt';

  @override
  String get name => 'code';

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
          content: PromptService.codeOnly(),
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
    try {
      final initialResult = await openRouter.invoke(
          session: session!, shouldDebug: shouldDebug, markdown: false);
      if (initialResult.isError()) {
        _logger.err('An Error occurred');

        return ExitCode.tempFail.code;
      }
      session = initialResult.getOrThrow();

      while (true) {
        final actionCompleter = Completer<ActionType>();

        // to block the event loop
        await Future.microtask(() {
          final action = _logger.chooseOne(
            'Your action:',
            choices: [
              ActionType.file,
              ActionType.copy,
              ActionType.chat,
              ActionType.explain,
              ActionType.exit
            ],
            defaultValue: ActionType.copy,
            display: (choice) {
              switch (choice) {
                case ActionType.copy:
                  return 'copy';
                case ActionType.explain:
                  return 'explain';
                case ActionType.chat:
                  return 'chat';
                case ActionType.file:
                  return 'file';
                case ActionType.exit:
                  return 'exit';
                default:
                  throw UnimplementedError();
              }
            },
          );
          actionCompleter.complete(action);
        });

        final action = await actionCompleter.future;
        final lastMsg = session!.messages.last.content;
        switch (action) {
          case ActionType.copy:
            await ActionService.copy(lastMsg);
          case ActionType.file:
            final fileName = _logger.prompt(
              'Enter the name of the file you want to save the output:',
            );
            await ActionService.saveToFile(fileName, lastMsg, shouldAutoOvewrite: false);
          case ActionType.explain:
            final explainResult =
                await ActionService.explain(session, shouldDebug: shouldDebug);
            session = explainResult.getOrThrow();
          case ActionType.chat:
            final prompt = _logger.prompt(
              '...',
            );
            final newMsg = Message(
                role: Role.user,
                content: prompt,
                timestamp: DateTime.now().millisecondsSinceEpoch);
            session = session.copyWith(messages: [...session.messages, newMsg]);

            final chatResult = await openRouter.invoke(
                session: session, shouldDebug: shouldDebug, markdown: false);
            session = chatResult.getOrThrow();
          case ActionType.exit:
            return ExitCode.success.code;
          default:
            throw UnimplementedError();
        }
      }
    } catch (e) {
      _logger.err('$e');
      return ExitCode.tempFail.code;
    }
  }
}
