import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';

/// {@template set_command}
///
/// `buddy set`
/// A [Command] to get cli suggestion based on prompt
/// {@endtemplate}
class SetCommand extends Command<int> {
  /// {@macro set_command}
  SetCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'secret',
        abbr: 's',
        help: 'Sets path to the secret.env file',
        valueHelp: 'path',
      )
      ..addOption(
        'key',
        abbr: 'k',
        help: 'Create a secret.env and set the provided API key in the file',
        valueHelp: 'api key',
      )
      ..addOption(
        'model',
        abbr: 'm',
        help: 'sets the default AI model',
        valueHelp: 'model name',
      );
  }

  @override
  String get description =>
      'Sets the configuration values or create new one if it does not exist.';

  @override
  String get name => 'set';

  final Logger _logger;

  @override
  Future<int> run() async {
    final path = argResults?['secret'];
    final key = argResults?['key'];
    final model = argResults?['model'];

    if (argResults == null ||
        argResults?.options == null ||
        argResults!.options.isEmpty) {
      return ExitCode.usage.code;
    }

    configuration ??= await ConfigService.loadConfig(_logger).getOrThrow();

    if (key != null) {
      String? secretEnvPath;
      if (path != null) {
        /// if path and key are both provided, create a new secret.env file with the key in the provided path and update config file
        secretEnvPath = p.join(path.toString(), 'secret.env');
      } else {
        secretEnvPath = p.join(defaultDir!, 'secret.env');
      }
      final secretEnvFile = File(secretEnvPath);
      await secretEnvFile.writeAsString('openrouter_key = "$key"\n');
      await ConfigService.saveConfig(_logger,
          newConfig: configuration!.copyWith(secretEnvPath: secretEnvPath));
      _logger.info(
          'Created secret.env and set API key successfully at $secretEnvPath');
    }

    if (path != null && key == null) {
      await ConfigService.saveConfig(_logger,
          newConfig: configuration!.copyWith(secretEnvPath: path.toString()));
    }

    if (model != null) {
      await ConfigService.saveConfig(_logger,
          newConfig: configuration!.copyWith(defaultModel: model.toString()));
    }

    return ExitCode.success.code;
  }
}
