import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

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
        'config',
        abbr: 'c',
        help:
            'Sets path to the existing buddy.config file. Note that custom path will not persist so it must be provided each time. Also if the file does not exist, new one will be created at the default path.',
        valueHelp: 'path',
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
      'Sets the path of the existing secret.env file, creates a new one with the API key, or sets the default model ';

  @override
  String get name => 'set';

  final Logger _logger;

  @override
  Future<int> run() async {
    final path = argResults?['secret'];
    final key = argResults?['key'];
    final configPath = argResults?['config'];
    final model = argResults?['model'];

    if (path == null && key == null && model == null) {
      _logger.err(
          'Please provide a path using --secret or -s, a key using --key or -k, or a model using --model or -m');
      return ExitCode.usage.code;
    }
    if (path != null && key != null) {
      _logger.warn('--secret will be ignored since --key is provided');
    }

    final configDir = SysInfoService.getConfigDirectory();
    if (configDir == null) {
      _logger.err('Unsupported OS');
      return ExitCode.osError.code;
    }

    final configFilePath = configPath ?? p.join(configDir, 'buddy.config');
    final configFile = File(configFilePath as String);
    // ANSI escape code for clickable link (some terminals don't support this)
    final clickableLink =
        '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
    Map<String, dynamic> config;

    if (configFile.existsSync()) {
      final content = await configFile.readAsString();
      try {
        config = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        _logger.err(
            'Failed to parse config file. Please ensure it is valid JSON.');
        return ExitCode.data.code;
      }
    } else {
      _logger.info(
          'Config file not found. Creating a new config file at $clickableLink');
      config = {
        'secret_env_path': 'secret.env',
        'default_model': 'openai/gpt-4o-mini',
        'max_tokens': null,
        'temperature': 0.3,
        'top_p': null,
        'top_k': null,
        'frequency_penalty': null,
        'presence_penalty': null,
        'repetition_penalty': null,
        'min_p': null,
        'top_a': null,
        'seed': null,
        'logit_bias': null,
        'logprobs': null,
        'top_logprobs': null,
        'response_format': null,
        'stop': null
      };
      // Create the file with the default configuration
      final updatedContent = const JsonEncoder.withIndent('  ').convert(config);
      await configFile.writeAsString(updatedContent);
    }

    if (key != null) {
      final secretEnvPath = p.join(configDir, 'secret.env');
      final secretEnvFile = File(secretEnvPath);

      await secretEnvFile.writeAsString('openrouter_key = "$key"\n');
      config['secret_env_path'] = secretEnvPath;

      _logger.info(
          'Created secret.env and set API key successfully at $secretEnvPath');
    } else if (path != null) {
      config['secret_env_path'] = path;
      _logger.info(
          'Saved Path to the secret.env ($path) successfully at $clickableLink');
    }
    if (model != null) {
      config['default_model'] = model;
      _logger
          .info('Saved Default Model ($model) successfully at $clickableLink');
    }

    final updatedContent = const JsonEncoder.withIndent('  ').convert(config);
    await configFile.writeAsString(updatedContent);

    return ExitCode.success.code;
  }
}
