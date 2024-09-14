import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/action.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/global.dart';
import 'package:cli_buddy/src/common/service/web.dart';
import 'package:mason_logger/mason_logger.dart';
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
      ..addFlag('local-web',
          abbr: 'w',
          help:
              'Donwload the web files locally and serve the Web UI from localhost. If the value is false, will use the hosted version of the Web UI.',
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
    final port = argResults?['port'] as String?;
    final address = argResults?['address'] as String?;
    final autoFlag = argResults?['launch'] as bool? ?? true;
    final isLocal = argResults?['local-web'] as bool? ?? true;
    final defaultFullUri = configuration?.localEndpoint; // e.g. localhost:3000
    final defaultAdress = defaultFullUri?.split(':').first;
    final defaultPort = defaultFullUri?.split(':').last;
    final server = WebService();

    await server.start(
        address: address ?? defaultAdress!,
        port: int.parse(port ?? defaultPort!),
        isLocal: isLocal);
    if (!isLocal && autoFlag) {
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
      await ActionService.openWeb(
          port: port ?? defaultPort,
          address: address ?? defaultAdress,
          isLocal: isLocal,
          logger: _logger);
    }

    final completer = Completer<int>();
    return completer.future;
  }
}
