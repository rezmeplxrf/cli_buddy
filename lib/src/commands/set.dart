import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';

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
        'secret-path',
        abbr: 's',
        help: 'Set path to the secret.env file in the buddy.config',
        valueHelp: 'String',
      )
      ..addFlag(
        'config',
        abbr: 'c',
        help:
            'Load the current config file and display the values if does not exist, create a new one',
        negatable: false,
      )
      ..addOption(
        'api-key',
        abbr: 'k',
        help:
            "Set API key in the secret.env file. If secret.env doesn't exist, create a new secret.env",
        valueHelp: 'String',
      )
      ..addOption(
        'model',
        abbr: 'm',
        help: 'Set the default AI model',
        valueHelp: 'String',
      )
      ..addOption(
        'save-session',
        abbr: 'e',
        help: 'Set save session flag',
        valueHelp: 'bool',
      )
      ..addOption(
        'max-messages',
        abbr: 'a',
        help: 'Set max messages',
        valueHelp: 'int',
      )
      ..addOption(
        'temperature',
        abbr: 't',
        help: 'Set temperature',
        valueHelp: 'double',
      )
      ..addOption(
        'max-tokens',
        abbr: 'x',
        help: 'Set max tokens',
        valueHelp: 'int',
      )
      ..addOption(
        'top-p',
        help: 'Set top_p',
        valueHelp: 'int',
      )
      ..addOption(
        'top-k',
        help: 'Set top_k',
        valueHelp: 'int',
      )
      ..addOption(
        'freq-penalty',
        help: 'Set frequency penalty',
        valueHelp: 'double',
      )
      ..addOption(
        'presence-penalty',
        help: 'Set presence penalty',
        valueHelp: 'double',
      )
      ..addOption(
        'repetition-penalty',
        help: 'Set repetition penalty',
        valueHelp: 'double',
      )
      ..addOption(
        'min-p',
        help: 'Set min_p',
        valueHelp: 'double',
      )
      ..addOption(
        'top-a',
        help: 'Set top_a',
        valueHelp: 'double',
      )
      ..addOption(
        'seed',
        help: 'Set seed',
        valueHelp: 'int',
      )
      ..addOption(
        'logit-bias',
        help: 'Set logit bias',
        valueHelp: 'Map',
      )
      ..addOption(
        'logprobs',
        help: 'Set logprobs',
        valueHelp: 'int',
      )
      ..addOption(
        'top-logprobs',
        help: 'Set top logprobs',
        valueHelp: 'int',
      )
      ..addOption(
        'response-format',
        help: 'Set response format',
        valueHelp: 'Map',
      )
      ..addOption(
        'stop-seq',
        help: 'Set stop sequences',
        valueHelp: 'List<int>',
      )
      ..addOption(
        'cmd-prompt',
        help: 'Set command prompt',
        valueHelp: 'String',
      )
      ..addOption(
        'explain-prompt',
        help: 'Set explain prompt',
        valueHelp: 'String',
      )
      ..addOption(
        'code-prompt',
        help: 'Set code prompt',
        valueHelp: 'String',
      )
      ..addOption(
        'chat-prompt',
        help: 'Set chat prompt',
        valueHelp: 'String',
      );
  }

  @override
  String get description =>
      'Sets the configuration values or create new one if it does not exist.';

  @override
  String get name => 'set';

  final Logger _logger;

  @override
  Future<int> run() async {
    final progress = _logger.progress('Waiting for Response');
    final path = argResults?['secret-path'] as String?;
    final key = argResults?['api-key'] as String?;
    final model = argResults?['model'] as String?;
    final saveSession = argResults?['save-session'] == 'true';
    final maxMessages =
        int.tryParse(argResults?['max-messages'] as String? ?? '');
    final temperature =
        double.tryParse(argResults?['temperature'] as String? ?? '');
    final maxTokens = int.tryParse(argResults?['max-tokens'] as String? ?? '');
    final topP = int.tryParse(argResults?['top-p'] as String? ?? '');
    final topK = int.tryParse(argResults?['top-k'] as String? ?? '');
    final frequencyPenalty =
        double.tryParse(argResults?['freq-penalty'] as String? ?? '');
    final presencePenalty =
        double.tryParse(argResults?['presence-penalty'] as String? ?? '');
    final repetitionPenalty =
        double.tryParse(argResults?['repetition-penalty'] as String? ?? '');
    final minP = double.tryParse(argResults?['min-p'] as String? ?? '');
    final topA = double.tryParse(argResults?['top-a'] as String? ?? '');
    final seed = int.tryParse(argResults?['seed'] as String? ?? '');
    final logitBias = argResults?['logit-bias'] != null
        ? jsonDecode(argResults!['logit-bias'] as String)
            as Map<String, dynamic>
        : null;
    final logprobs = int.tryParse(argResults?['logprobs'] as String? ?? '');
    final topLogprobs =
        int.tryParse(argResults?['top-logprobs'] as String? ?? '');
    final formatArg = argResults?['response-format'] as String?;
    final responseFormat = (formatArg != null)
        ? jsonDecode(formatArg) as Map<String, dynamic>
        : null;
    final stopArg = argResults?['stop-seq'] as String?;
    final stop =
        (stopArg != null) ? jsonDecode(stopArg) as List<dynamic> : null;
    final cmdPrompt = argResults?['cmd-prompt'] as String?;
    final explainPrompt = argResults?['explain-prompt'] as String?;
    final codePrompt = argResults?['code-prompt'] as String?;
    final chatPrompt = argResults?['chat-prompt'] as String?;

    if (argResults == null ||
        argResults?.options == null ||
        argResults!.options.isEmpty) {
      progress.fail();
      return ExitCode.usage.code;
    }

    configuration ??= await ConfigService.loadConfig().getOrThrow();
    if (argResults?['config'] == true) {
      _logger.info(jsonEncode(configuration));
      progress.complete();
      return ExitCode.success.code;
    }

    if (key != null) {
      String? secretEnvPath;
      if (path != null) {
        /// if path and key are both provided,
        /// create a new secret.env file with the key in the provided path and update config file
        secretEnvPath = p.join(path, 'secret.env');
      } else {
        secretEnvPath = p.join(defaultDir!, 'secret.env');
      }
      final secretEnvFile = File(secretEnvPath);
      await secretEnvFile.writeAsString('openrouter_key = "$key"\n');
      await ConfigService.saveConfig(
          newConfig: configuration!.copyWith(secretEnvPath: secretEnvPath));
      _logger.info(
          'Created secret.env and set API key successfully at $secretEnvPath');
    } else if (path != null && key == null) {
      await ConfigService.saveConfig(
          newConfig: configuration!.copyWith(secretEnvPath: path));
    }

    final newConfig = configuration!.copyWith(
      defaultModel: model ?? configuration!.defaultModel,
      saveSession: saveSession,
      maxMessages: maxMessages ?? configuration!.maxMessages,
      temperature: temperature ?? configuration!.temperature,
      maxTokens: maxTokens ?? configuration!.maxTokens,
      topP: topP ?? configuration!.topP,
      topK: topK ?? configuration!.topK,
      frequencyPenalty: frequencyPenalty ?? configuration!.frequencyPenalty,
      presencePenalty: presencePenalty ?? configuration!.presencePenalty,
      repetitionPenalty: repetitionPenalty ?? configuration!.repetitionPenalty,
      minP: minP ?? configuration!.minP,
      topA: topA ?? configuration!.topA,
      seed: seed ?? configuration!.seed,
      logitBias: logitBias ?? configuration!.logitBias,
      logprobs: logprobs ?? configuration!.logprobs,
      topLogprobs: topLogprobs ?? configuration!.topLogprobs,
      responseFormat: responseFormat ?? configuration!.responseFormat,
      stop: stop ?? configuration!.stop,
      cmdPrompt: cmdPrompt ?? configuration!.cmdPrompt,
      explainPrompt: explainPrompt ?? configuration!.explainPrompt,
      codePrompt: codePrompt ?? configuration!.codePrompt,
      chatPrompt: chatPrompt ?? configuration!.chatPrompt,
    );

    await ConfigService.saveConfig(newConfig: newConfig);
    progress.complete();
    return ExitCode.success.code;
  }
}
