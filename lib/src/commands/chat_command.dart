import 'dart:async';

import 'package:args/command_runner.dart';
import '../common/models/config.dart';
import '../common/models/session.dart';
import '../common/service/config.dart';
import '../common/service/global.dart';
import '../common/service/prompts.dart';
import '../common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

/// {@template chat_command}
///
/// `buddy chat`
/// A [Command] to chat with the AI
/// {@endtemplate}
class ChatCommand extends Command<int> {
  /// {@macro chat_command}
  ChatCommand({
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
          negatable: false)
      ..addFlag('markdown',
          abbr: 'm',
          help: 'Enable markdown formatting in the output',
          negatable: false);
  }

  @override
  String get description => 'Chat with the AI';

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
      session = await SessionService.loadSession(id: sessionId);
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
      configuration ??= await ConfigService.loadConfig().getOrThrow();
      final modelId = (configuration!.apiProvider == APIProvider.openrouter)
          ? configuration!.openrouterDefaultModel
          : configuration!.ollamaDefaultModel;
      if (modelId == null) {
        _logger.err('Default APIProvider is not found');
        return ExitCode.tempFail.code;
      }
      session = ChatSession(
          id: currentTime, messages: [sysMsg, initialMsg], modelId: modelId);
    }

    final shouldDebug = argResults?['raw'] as bool? ?? false;
    final markdown = argResults?['markdown'] as bool?;

    final initialResult = await openRouter.invoke(
        session: session!, shouldDebug: shouldDebug, markdown: markdown);
    if (initialResult.isError()) {
      _logger.err('An Error occurred');
      return ExitCode.tempFail.code;
    }
    session = initialResult.getOrThrow();

    while (true) {
      final promptCompleter = Completer<String>();
      // to block the event loop
      await Future.microtask(() {
        final prompt = _logger.prompt(
          '...',
        );
        promptCompleter.complete(prompt);
      });

      final prompt = await promptCompleter.future;

      final newMsg = Message(
          role: Role.user,
          content: prompt,
          timestamp: DateTime.now().millisecondsSinceEpoch);
      session = session!.copyWith(messages: [...session.messages, newMsg]);
      final newResult = await openRouter.invoke(
          session: session, shouldDebug: shouldDebug, markdown: markdown);
      if (newResult.isError()) {
        _logger.err('An Error occurred');
        return ExitCode.tempFail.code;
      }
      session = newResult.getOrThrow();
    }
  }
}
