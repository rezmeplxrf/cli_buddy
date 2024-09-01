import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:dotenv/dotenv.dart';
import 'package:mason_logger/mason_logger.dart';

String? openrouterKey;
String? defaultModel;
Parameters? defaultParameters;

class ConfigService {
  static Future<String?> loadOpenrouterKey(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          "Config file not found. Please create 'buddy.config' and set the path using `set-path` command.");
      return null;
    }

    try {
      final configContent = await configFile.readAsString();
      final jsonMap = jsonDecode(configContent) as Map<String, dynamic>;

      final secretEnvPath = jsonMap['secret_env_path'] as String?;
      if (secretEnvPath == null) {
        logger.err('secret_env_path not found in buddy.config file');
        return null;
      }

      final env = DotEnv(includePlatformEnvironment: true)
        ..load([secretEnvPath]);
      final keyExists = env.isDefined('openrouter_key');
      String? key;
      if (keyExists) {
        key = env['openrouter_key'];
      } else {
        logger.err('openrouter_key not found in .env file');
      }
      env.clear();
      return key;
    } catch (e) {
      logger
        ..err('Error parsing secret_env_path from config file')
        ..detail(e.toString());
      return null;
    }
  }

  static Future<String?> loadDefaultModel(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          "Config file not found. Please create 'buddy.config' and set the path using `set-path` command.");
      return null;
    }

    try {
      final configContent = await configFile.readAsString();
      final jsonMap = jsonDecode(configContent) as Map<String, dynamic>;

      final defaultModel = jsonMap['default_model'] as String?;
      if (defaultModel == null) {
        logger.err('default_model not found in buddy.config file');
      }
      return defaultModel;
    } catch (e) {
      logger
        ..err('Error parsing default_model from config file')
        ..detail(e.toString());
      return null;
    }
  }

  static Future<Parameters?> loadDefaultParameters(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          "Config file not found. Please create 'buddy.config' and set the path using `set-path` command.");
      return null;
    }

    try {
      final configContent = await configFile.readAsString();
      final jsonMap = jsonDecode(configContent);

      final parameters = Parameters.fromJson(jsonMap as Map<String, dynamic>);
      return parameters;
    } catch (e) {
      logger
        ..err(
          'Error parsing parameters from config file',
        )
        ..detail(e.toString());
      return null;
    }
  }
}
