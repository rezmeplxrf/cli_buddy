import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/web.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';
import 'package:result_dart/result_dart.dart';

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
      ..addFlag('local',
          abbr: 'c',
          help: 'Donwload the web files locally and serve it from localhost',
          defaultsTo: true)
      ..addFlag(
        'launch',
        abbr: 'l',
        help: 'Open the page with default browser automatically',
        defaultsTo: true,
      )
      ..addOption('port', abbr: 'p', help: 'Port to listen on')
      ..addOption('address', abbr: 'a', help: 'Address to listen on');
  }

  @override
  String get description => 'Open Graphic Interface on Localhost';

  @override
  String get name => 'open';

  final Logger _logger;

  @override
  Future<int> run() async {
    configuration ??= await ConfigService.loadConfig().getOrNull();
    final port = argResults?['port'] as String? ?? configuration?.port;
    final address =
        argResults?['address'] as String? ?? configuration?.ipAddress;
    final autoFlag = argResults?['launch'] as bool? ?? true;
    final isLocal = argResults?['local'] as bool? ?? true;

    final server = WebService();

    await server.start(
        address: address!, port: int.parse(port!), isLocal: isLocal);
    if (!isLocal) {
      _logger
        ..info('The web interface is available at $hostedWeb in your browser.')
        ..info(
            'It is completely private for you only. - No data is collected and nothing is sent to external services.')
        ..info(
            'If you are still worried, you can check out the network section of the devtool');
    }

    // Handle SIGINT (Ctrl+C) to stop the server and clean up resources
    ProcessSignal.sigint.watch().listen((signal) async {
      _logger.info('Stopping the server...');
      await server.stop();
      exit(0);
    });

    if (autoFlag) {
      await _open(
          port: port, address: address, isLocal: isLocal, logger: _logger);
    }

    final completer = Completer<int>();
    return completer.future;
  }
}

Future<void> _open(
    {required String port,
    required String address,
    required bool isLocal,
    required Logger logger}) async {
  final shell = Shell();
  final url = isLocal ? 'http://$address:$port' : hostedWeb;

  if (Platform.isMacOS) {
    await shell.run('open $url');
  } else if (Platform.isLinux) {
    try {
      await shell.run('xdg-open $url');
    } catch (e) {
      logger.info('xdg-open failed, trying gnome-open...');
      try {
        await shell.run('gnome-open $url');
      } catch (e) {
        logger.info('gnome-open failed, trying kde-open...');
        try {
          await shell.run('kde-open $url');
        } catch (e) {
          logger.err('All methods failed to open the URL on Linux: $e');
        }
      }
    }
  } else if (Platform.isWindows) {
    await shell.run('start $url');
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

const hostedWeb = 'https://buddy-c3bf4.web.app/';
