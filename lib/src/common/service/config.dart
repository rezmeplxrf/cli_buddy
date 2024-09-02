import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:dotenv/dotenv.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

String? openrouterKey;
String? defaultModel;
Parameters? defaultParameters;
String fallbackModel = 'openai/gpt-4o-2024-08-06';

class ConfigService {
  static Future<String?> loadOpenrouterKey(Logger logger) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          "Config file not found. Please create 'secret.env' file and add openrouter_key and run `buddy set -s <path/to/secret.env>`");
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
          "Config file not found. Please create 'buddy.config' and set the path using `set -c` command.");
      return null;
    }

    try {
      final configContent = await configFile.readAsString();
      final jsonMap = jsonDecode(configContent) as Map<String, dynamic>;

      final defaultModel = jsonMap['default_model'] as String?;
      if (defaultModel == null) {
        logger.warn(
            'default_model not found in buddy.config file. We will use fallback model which is $fallbackModel');
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
          "Config file not found. Please create 'buddy.config' and set the path using `set -c` command.");
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

  static Future<void> saveSession(
    Logger logger, {
    required ChatSession session,
  }) async {
    final configFile = File('buddy.config');
    if (!configFile.existsSync()) {
      logger.err(
          "Config file not found. Please create 'buddy.config' and set the path using `set -c` command.");
      return;
    }
    try {
      final configContent = await configFile.readAsString();
      final jsonMap = jsonDecode(configContent) as Map<String, dynamic>;

      final shouldSaveSession = jsonMap['save_session'] as bool? ?? true;
      if (shouldSaveSession) {
        final appDir = SysInfoService.getConfigDirectory();
        if (appDir == null) {
          logger.err('Unsupported OS');
          return;
        } else {
          final sessionsPath = p.join(appDir, 'sessions');
          final sessionFilePath = p.join(sessionsPath, '${session.id}.json');

          final sessionDir = Directory(sessionsPath);
          if (!sessionDir.existsSync()) {
            sessionDir.createSync(recursive: true);
          }

          final sessionFile = File(sessionFilePath);
          await sessionFile.writeAsString(jsonEncode(session.toJson()));
          return;
        }
      }
    } catch (e) {
      logger
        ..err(
          'Error saving session to file',
        )
        ..detail(e.toString());
    }
  }

  static Future<ChatSession?> loadSession(Logger logger,
      {required int id}) async {
    try {
      final appDir = SysInfoService.getConfigDirectory();
      if (appDir == null) {
        logger.err('Unsupported OS');
        return null;
      } else {
        final sessionsPath = p.join(appDir, 'sessions');
        final sessionFilePath = p.join(sessionsPath, '$id.json');

        final sessionFile = File(sessionFilePath);
        if (!sessionFile.existsSync()) {
          logger.err('Session file not found: $sessionFilePath');
          return null;
        }

        final sessionContent = await sessionFile.readAsString();
        final sessionJson = jsonDecode(sessionContent) as Map<String, dynamic>;
        return ChatSession.fromJson(sessionJson);
      }
    } catch (e) {
      logger
        ..err(
          'Error loading session from file',
        )
        ..detail(e.toString());
      return null;
    }
  }
}
