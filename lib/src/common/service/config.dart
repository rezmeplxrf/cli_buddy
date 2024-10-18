import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/models/config.dart';
import 'package:cli_buddy/src/common/models/exception.dart';
import 'package:cli_buddy/src/common/models/session.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';

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
        final clickableLink =
            '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
        _logger?.info('Config file: ${blue.wrap(clickableLink)}');
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
      final clickableLink =
          '\x1B]8;;file://${configFile.path}\x1B\\${configFile.path}\x1B]8;;\x1B\\';
      _logger?.info(
          'config updated: ${blue.wrap(clickableLink)}\nYou can check the config by running ${cyan.wrap('buddy info -f')}\n');

      // Reload the configuration
      await loadConfig();
    } catch (e) {
      _logger?.err(e.toString());
    }
  }

  static Future<Result<String, CustomException>> loadOpenrouterKey() async {
    configuration ??= await loadConfig().getOrThrow();

    final openrouterKey = configuration?.openrouterKey;
    if (openrouterKey == null) {
      _logger?.err('openrouterKey is found in buddy.config file');
      return CustomException(
              message: 'openrouterKey not found',
              stack: 'ConfigService.loadOpenrouterKey')
          .toFailure();
    }

    return openrouterKey.toSuccess();
  }
}
