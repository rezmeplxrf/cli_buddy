import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/gui.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template open_command}
///
/// `buddy open`
/// A [Command] to chat with the AI
/// {@endtemplate}
class OpenCommand extends Command<int> {
  /// {@macro open_command}
  OpenCommand({
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
  String get description => 'Open Graphic Interface on Localhost';

  @override
  String get name => 'open';

  final Logger _logger;

  @override
  Future<int> run() async {
    final sessionId = argResults?['session'];
    if (sessionId != null && sessionId is int) {
      _logger.info('Session ID: $sessionId');
    }
    final server = GUIService();
    await server.start();

    // Handle SIGINT (Ctrl+C) to stop the server and clean up resources
    ProcessSignal.sigint.watch().listen((signal) async {
      _logger.info('Received SIGINT, stopping server...');
      await server.stop();
      exit(0);
    });

    // Keep the server running indefinitely
    final completer = Completer<int>();
    return completer.future;
  }
}
