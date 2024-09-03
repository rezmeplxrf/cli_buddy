import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/config.dart';
import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:dotenv/dotenv.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';

String? openrouterKey;
Configuration? configuration;
String? defaultDir;
String fallbackModel = 'openai/gpt-4o';
Parameters? parametersCache;

class ConfigService {
  static Future<Result<Configuration, CustomException>> loadConfig(
      Logger logger) async {
    defaultDir = SysInfoService.getConfigDirectory();

    final configFilePath = p.join(defaultDir!, 'buddy.config');
    final configFile = File(configFilePath);

    try {
      Configuration? config;
      if (!configFile.existsSync()) {
        final clickableLink =
            '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
        logger.info('Created a new config file at $clickableLink');
        config = Configuration.fromJson({});
      } else {
        final configContent = await configFile.readAsString();
        config = Configuration.fromJson(
            jsonDecode(configContent) as Map<String, dynamic>);
      }
      parametersCache = Parameters.fromJson(config.toJson());
      cmdPromptCache = config.cmdPrompt ?? defaultCommandPrompt;
      explainPromptCache = config.explainPrompt ?? defaultExplainPrompt;
      codePromptCache = config.codePrompt ?? defaultCodePrompt;
      chatPromptCache = config.chatPrompt ?? defaultChatPrompt;
      logger.info('Current Parameters: ${parametersCache?.toJson()}');
      return config.toSuccess();
    } catch (e) {
      logger.err(e.toString());
      return CustomException(
        message: 'Something went wrong while loading config file',
        stack: 'ConfigService.loadConfigFile',
        details: {'error': e.toString()},
      ).toFailure();
    }
  }

  static Future<void> saveConfig(Logger logger,
      {required Configuration newConfig}) async {
    defaultDir = SysInfoService.getConfigDirectory();

    final configFilePath = p.join(defaultDir!, 'buddy.config');
    final configFile = File(configFilePath);

    try {
      final configJson = jsonEncode(newConfig.toJson());
      await configFile.writeAsString(configJson);

      final clickableLink =
          '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
      logger.info('Updated: $clickableLink');

      // Reload the configuration
      await loadConfig(logger);
    } catch (e) {
      logger.err(e.toString());
    }
  }

  static Future<Result<String, CustomException>> loadOpenrouterKey(
    Logger logger,
  ) async {
    configuration ??= await loadConfig(logger).getOrThrow();

    final secretEnvPath = configuration?.secretEnvPath;
    if (secretEnvPath == null) {
      logger.err('secret_env_path not found in buddy.config file');
      return CustomException(
              message: 'secret_env_path not found',
              stack: 'ConfigService.loadOpenrouterKey')
          .toFailure();
    }
    final env = DotEnv(includePlatformEnvironment: true)..load([secretEnvPath]);
    try {
      final keyExists = env.isDefined('openrouter_key');

      if (keyExists) {
        final key = env['openrouter_key'];
        if (key == null) {
          return CustomException(
                  message: 'Api key is not found',
                  stack: 'ConfigService.loadOpenrouterKey')
              .toFailure();
        } else {
          return key.toSuccess();
        }
      } else {
        return CustomException(
                message: 'Api key is not found',
                stack: 'ConfigService.loadOpenrouterKey')
            .toFailure();
      }
    } catch (e) {
      return CustomException(
        message: 'Error while loading api key',
        stack: 'ConfigService.loadOpenrouterKey',
        details: {'error': e.toString()},
      ).toFailure();
    } finally {
      env.clear();
    }
  }

  static Future<void> saveSession(
    Logger logger, {
    required ChatSession session,
  }) async {
    configuration ??= await loadConfig(logger).getOrThrow();
    defaultDir = SysInfoService.getConfigDirectory();

    try {
      if (configuration!.saveSession) {
        if (defaultDir != null) {
          final sessionsPath = p.join(defaultDir!, 'sessions');
          final sessionFilePath = p.join(sessionsPath, '${session.id}.json');
          final sessionDir = Directory(sessionsPath);
          if (!sessionDir.existsSync()) {
            sessionDir.createSync(recursive: true);
          } else {
            final sessionFile = File(sessionFilePath);
            await sessionFile.writeAsString(jsonEncode(session.toJson()));
          }
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
    configuration ??= await loadConfig(logger).getOrThrow();
    defaultDir = SysInfoService.getConfigDirectory();

    try {
      final sessionsPath = p.join(defaultDir!, 'sessions');
      final sessionFilePath = p.join(sessionsPath, '$id.json');

      final sessionFile = File(sessionFilePath);
      if (!sessionFile.existsSync()) {
        logger.err('Session file not found: $sessionFilePath');
        return null;
      }

      final sessionContent = await sessionFile.readAsString();
      return ChatSession.fromJson(
          jsonDecode(sessionContent) as Map<String, dynamic>);
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
