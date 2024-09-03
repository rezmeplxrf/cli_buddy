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
String fallbackModel = 'openai/gpt-4o-mini';
int? defaultMaxMessages = 20;
String? customPath;

class ConfigService {
  static Map<String, dynamic>? _configData;

  static Future<void> _loadConfigFile(Logger logger) async {
    if (_configData != null) {
      return;
    }
    final configDir = SysInfoService.getConfigDirectory();
    if (configDir == null) {
      logger.err('Unsupported OS');
      return;
    }

    final configFilePath = customPath ?? p.join(configDir, 'buddy.config');
    final configFile = File(configFilePath);
    if (!configFile.existsSync()) {
      logger.err(
          "Config file not found. Please create 'buddy.config' file and add the necessary configurations.");
      return;
    }

    try {
      final configContent = await configFile.readAsString();
      _configData = jsonDecode(configContent) as Map<String, dynamic>;
    } catch (e) {
      logger
        ..err('Error parsing config file')
        ..detail(e.toString());
    }
  }

  static Future<String?> loadOpenrouterKey(
    Logger logger,
  ) async {
    await _loadConfigFile(logger);
    if (_configData == null) {
      return null;
    }

    final secretEnvPath = _configData!['secret_env_path'] as String?;
    if (secretEnvPath == null) {
      logger.err('secret_env_path not found in buddy.config file');
      return null;
    }

    try {
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
        ..err('Error loading .env file')
        ..detail(e.toString());
      return null;
    }
  }

  static Future<String?> loadDefaultModel(
    Logger logger,
  ) async {
    await _loadConfigFile(
      logger,
    );
    if (_configData == null) {
      return null;
    }

    final defaultModel = _configData!['default_model'] as String?;
    if (defaultModel == null) {
      logger.warn(
          'default_model not found in buddy.config file. We will use fallback model which is $fallbackModel');
    }
    return defaultModel;
  }

  static Future<int?> loadMaxMessagesSent(
    Logger logger,
  ) async {
    await _loadConfigFile(
      logger,
    );
    await _loadConfigFile(logger);
    if (_configData == null) {
      return null;
    }

    final maxMessagesSent = _configData!['max_messages_sent'] as int?;

    return maxMessagesSent ?? defaultMaxMessages;
  }

  static Future<Parameters?> loadDefaultParameters(
    Logger logger,
  ) async {
    await _loadConfigFile(
      logger,
    );
    await _loadConfigFile(logger);
    if (_configData == null) {
      return null;
    }

    try {
      final parameters = Parameters.fromJson(_configData!);
      return parameters;
    } catch (e) {
      logger
        ..err('Error parsing parameters from config file')
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
      return;
    }
    try {
      final configContent = await configFile.readAsString();
      final jsonMap = jsonDecode(configContent) as Map<String, dynamic>;

      final shouldSaveSession = jsonMap['save_session'] as bool? ?? true;
      if (shouldSaveSession) {
        final appDir = SysInfoService.getConfigDirectory();
        if (appDir != null) {
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
          'Error while saving session',
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
