import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:mason_logger/mason_logger.dart';

String? openrouterKey;
String? defaultModel;

class ConfigService {
  static Future<String?> readOpenrouterKey(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          'Config file not found. Please set the path using `set-path` command.');
      return null;
    }

    final configContent = await configFile.readAsLines();
    String? secretEnvPath;
    for (final line in configContent) {
      if (line.startsWith('secret_env_path=')) {
        secretEnvPath = line.split('=')[1];
        break;
      }
    }

    if (secretEnvPath == null) {
      logger.err('secret_env_path not found in buddy.config file');
      return null;
    }

    final env = DotEnv(includePlatformEnvironment: true)..load([secretEnvPath]);
    final keyExists = env.isDefined('openrouter_key');
    String? key;
    if (keyExists) {
      key = env['openrouter_key'];
    } else {
      logger.err('openrouter_key not found in .env file');
    }
    env.clear();
    return key;
  }

  static Future<String?> readDefaultModel(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          'Config file not found. Please set the path using `set-path` command.');
      return null;
    }

    final configContent = await configFile.readAsLines();
    String? defaultModel;
    for (final line in configContent) {
      if (line.startsWith('default_model=')) {
        defaultModel = line.split('=')[1];
        break;
      }
    }

    if (defaultModel == null) {
      logger.err('default_model not found in buddy.config file');
    }
    return defaultModel;
  }
}
