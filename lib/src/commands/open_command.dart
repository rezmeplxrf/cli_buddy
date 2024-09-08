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
      ..addFlag('raw',
          abbr: 'r',
          help: 'Display raw outputs of prompt and api requests',
          negatable: false)
      ..addFlag(
        'launch',
        abbr: 'l',
        help: 'Open the page with default browser automatically',
        defaultsTo: true,
      )
      ..addOption('port',
          abbr: 'p', help: 'Port to listen on', defaultsTo: '43210')
      ..addOption('address',
          abbr: 'a', help: 'Address to listen on', defaultsTo: 'localhost');
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

    final autoFlag = argResults?['launch'] as bool? ?? true;

    if (autoFlag) {
      final port = argResults?['port'] as String? ?? '43210';
      final address = argResults?['address'] as String? ?? 'localhost';
      await _open(port: port, address: address);
    }

    final completer = Completer<int>();
    return completer.future;
  }
}

Future<void> _open({required String port, required String address}) async {
  final shell = Shell();
  final url = 'http://$address:$port';

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
