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
  factory ConfigService() => _instance;
  ConfigService._internal();
  static final ConfigService _instance = ConfigService._internal();
  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;
  static Future<Result<Configuration, CustomException>> loadConfig() async {
    defaultDir ??= SysInfoService.getConfigDirectory();

    final configFilePath = p.join(defaultDir!, 'buddy.config');
    final configFile = File(configFilePath);
    final clickableLink =
        '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
    _logger?.info('\nConfig file: ${blue.wrap(clickableLink)}\n');

    try {
      Configuration? config;
      if (!configFile.existsSync()) {
        final clickableLink =
            '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
        _logger
            ?.info('Created a new config file at ${blue.wrap(clickableLink)}');
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

      return config.toSuccess();
    } catch (e) {
      _logger?.err(e.toString());
      return CustomException(
        message: 'Something went wrong while loading config file',
        stack: 'ConfigService.loadConfigFile',
        details: {'error': e.toString()},
      ).toFailure();
    }
  }

  static Future<void> saveConfig({required Configuration newConfig}) async {
    defaultDir ??= SysInfoService.getConfigDirectory();

    final configFilePath = p.join(defaultDir!, 'buddy.config');
    final configFile = File(configFilePath);

    try {
      final configJson = jsonEncode(newConfig.toJson());
      await configFile.writeAsString(configJson);

      _logger?.info('Config updated');

      // Reload the configuration
      await loadConfig();
    } catch (e) {
      _logger?.err(e.toString());
    }
  }

  static Future<Result<String, CustomException>> loadOpenrouterKey() async {
    configuration ??= await loadConfig().getOrThrow();

    final secretEnvPath = configuration?.secretEnvPath;
    if (secretEnvPath == null) {
      _logger?.err('secret_env_path not found in buddy.config file');
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
      _logger?.err(e.toString());
      return CustomException(
        message: 'Error while loading api key',
        stack: 'ConfigService.loadOpenrouterKey',
        details: {'error': e.toString()},
      ).toFailure();
    } finally {
      env.clear();
    }
  }
}
