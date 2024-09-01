import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

class SetCommand extends Command<int> {
  SetCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'secret',
        abbr: 's',
        help: 'Path to the secret.env file',
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
            'Path to the existing buddy.config file. Note that custom path will not persist so it must be provided each time. Also if the file does not exist, new one will be created at the default path.',
        valueHelp: 'path',
      );
  }

  @override
  String get description =>
      'Sets the path of the existing secret.env file or creates a new one with the API key';

  @override
  String get name => 'set';

  final Logger _logger;

  @override
  Future<int> run() async {
    final path = argResults?['secret'];
    final key = argResults?['key'];
    final configPath = argResults?['config'];

    if (path == null && key == null) {
      _logger.err(
          'Please provide a path using --secret or -s or a key using --key or -k');
      return ExitCode.usage.code;
    }

    final configDir = _getConfigDirectory();
    if (configDir == null) {
      _logger.err('Unsupported OS');
      return ExitCode.osError.code;
    }

    final configFilePath = configPath ?? p.join(configDir, 'buddy.config');
    final configFile = File(configFilePath as String);

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
          'Config file not found. Creating a new one at ${configFile.path}');
      config = {};
    }

    if (key != null) {
      final secretEnvPath = p.join(configDir, 'secret.env');
      final secretEnvFile = File(secretEnvPath);

      await secretEnvFile.writeAsString('openrouter_key = "$key"\n');
      config['secret_env_path'] = secretEnvPath;

      _logger.info(
          'Created secret.env and set API key successfully at: $secretEnvPath');
    } else if (path != null) {
      config['secret_env_path'] = path;
      _logger.info('Path to the secret.env saved successfully: $path');
    }

    final updatedContent = const JsonEncoder.withIndent('  ').convert(config);
    await configFile.writeAsString(updatedContent);

    return ExitCode.success.code;
  }

  String? _getConfigDirectory() {
    if (Platform.isWindows) {
      return Platform.environment['APPDATA'];
    } else if (Platform.isMacOS) {
      return p.join(
          Platform.environment['HOME']!, 'Library', 'Application Support');
    } else if (Platform.isLinux) {
      return p.join(Platform.environment['HOME']!, '.config');
    } else {
      return null;
    }
  }
}
