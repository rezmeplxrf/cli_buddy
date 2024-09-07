import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/web.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';

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
          negatable: false)
      ..addFlag(
        'launch',
        abbr: 'l',
        help: 'Open the page with default browser automatically',
        defaultsTo: true,
      );
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
    final server = WebService();
    await server.start();

    // Handle SIGINT (Ctrl+C) to stop the server and clean up resources
    ProcessSignal.sigint.watch().listen((signal) async {
      _logger.info('Stopping the server...');
      await server.stop();
      exit(0);
    });

    final autoFlag = argResults?['auto'] as bool? ?? true;

    if (autoFlag) {
      await _open();
    }

    final completer = Completer<int>();
    return completer.future;
  }
}

Future<void> _open() async {
  final shell = Shell();
  const url = 'http://127.0.0.1:43210';

  if (Platform.isMacOS) {
    await shell.run('open $url');
  } else if (Platform.isLinux) {
    try {
      await shell.run('xdg-open $url');
    } catch (e) {
      print('xdg-open failed, trying gnome-open...');
      try {
        await shell.run('gnome-open $url');
      } catch (e) {
        print('gnome-open failed, trying kde-open...');
        try {
          await shell.run('kde-open $url');
        } catch (e) {
          print('All methods failed to open the URL on Linux: $e');
        }
      }
    }
  } else if (Platform.isWindows) {
    await shell.run('start $url');
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
