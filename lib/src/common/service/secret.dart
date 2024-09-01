import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:mason_logger/mason_logger.dart';

String? openrouterKey;

class SecretService {
  static Future<String?> readOpenrouterKey(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          'Config file not found. Please set the path using `set-path` command.');
      return null;
    }

    final configContent = await configFile.readAsString();
    final secretEnvPath = configContent.split('=')[1];
    final env = DotEnv(includePlatformEnvironment: true)..load([secretEnvPath]);
    final keyExists = env.isDefined('openrouter_key');
    String? key;
    if (keyExists) {
      key = env['openrouter_key'];
    } else {
      throw Exception('openrouter_key not found in .env file');
    }
    env.clear();
    return key;
  }
}
