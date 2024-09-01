import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template set_path_command}
///
/// `buddy set-path`
/// A [Command] to set the path of secret.env
/// {@endtemplate}
class SetPathCommand extends Command<int> {
  /// {@macro set_path_command}
  SetPathCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addOption(
      'path',
      abbr: 'p',
      help: 'Path to the secret.env file',
      valueHelp: 'path',
    );
  }

  @override
  String get description => 'Sets the path of the secret.env file';

  @override
  String get name => 'set-path';

  final Logger _logger;

  @override
  Future<int> run() async {
    final path = argResults?['path'];
    if (path == null) {
      _logger.err('Please provide a path using --path or -p');
      return ExitCode.usage.code;
    }

    final file = File('buddy.config');
    await file.writeAsString('secret_env_path=$path');
    _logger.info('Path saved successfully: $path');
    return ExitCode.success.code;
  }
}
