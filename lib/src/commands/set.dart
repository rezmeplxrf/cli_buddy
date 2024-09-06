import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/session.dart';
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
        help: 'Specify the path to the secret.env file in the buddy.config.',
        valueHelp: 'String',
      )
      ..addOption(
        'api-key',
        abbr: 'k',
        help:
            "Set the API key in the secret.env file. If the file doesn't exist, it will be created.",
        valueHelp: 'String',
      )
      ..addFlag(
        'remove-sessions',
        abbr: 'r',
        help: 'Remove all saved sessions.',
      )
      ..addOption(
        'model',
        abbr: 'm',
        help: 'Set the default AI model to be used.',
        valueHelp: 'String',
      )
      ..addOption(
        'save-session',
        abbr: 'e',
        help: 'Enable or disable session saving.',
        valueHelp: 'bool',
        allowed: ['true', 'false'],
      )
      ..addOption(
        'max-messages',
        abbr: 'a',
        help: 'Set the maximum number of messages to retain.',
        valueHelp: 'int',
      )
      ..addOption(
        'temperature',
        abbr: 't',
        help: 'Set the temperature for AI responses (controls randomness).',
        valueHelp: 'double',
      )
      ..addOption(
        'max-tokens',
        abbr: 'x',
        help: 'Set the maximum number of tokens per response.',
        valueHelp: 'int',
      )
      ..addOption(
        'top-p',
        help: 'Set the top-p sampling parameter.',
        valueHelp: 'int',
      )
      ..addOption(
        'top-k',
        help: 'Set the top-k sampling parameter.',
        valueHelp: 'int',
      )
      ..addOption(
        'freq-penalty',
        help: 'Set the frequency penalty for repetitive responses.',
        valueHelp: 'double',
      )
      ..addOption(
        'presence-penalty',
        help: 'Set the presence penalty for repetitive responses.',
        valueHelp: 'double',
      )
      ..addOption(
        'repetition-penalty',
        help: 'Set the penalty for repeating the same phrases.',
        valueHelp: 'double',
      )
      ..addOption(
        'min-p',
        help: 'Set the minimum probability parameter.',
        valueHelp: 'double',
      )
      ..addOption(
        'top-a',
        help: 'Set the top-a sampling parameter.',
        valueHelp: 'double',
      )
      ..addOption(
        'seed',
        help: 'Set the seed for random number generation.',
        valueHelp: 'int',
      )
      ..addOption(
        'logit-bias',
        help: 'Set the logit bias for specific tokens.',
        valueHelp: 'Map',
      )
      ..addOption(
        'logprobs',
        help: 'Set the number of log probabilities to return.',
        valueHelp: 'int',
      )
      ..addOption(
        'top-logprobs',
        help: 'Set the number of top log probabilities to return.',
        valueHelp: 'int',
      )
      ..addOption(
        'response-format',
        help: 'Set the format for AI responses.',
        valueHelp: 'Map',
      )
      ..addOption(
        'stop-seq',
        help:
            'Set the sequences where the AI should stop generating responses.',
        valueHelp: 'List<int>',
      )
      ..addOption(
        'cmd-prompt',
        help:
            'Set the command prompt template which is used as a system message.',
        valueHelp: 'String',
      )
      ..addOption(
        'explain-prompt',
        help:
            'Set the explanation prompt template which is used as a system message.',
        valueHelp: 'String',
      )
      ..addOption(
        'code-prompt',
        help:
            'Set the code generation prompt template which is used as a system message.',
        valueHelp: 'String',
      )
      ..addOption(
        'chat-prompt',
        help: 'Set the chat prompt template which is used as a system message.',
        valueHelp: 'String',
      );
  }

  @override
  String get description =>
      'Set or update configuration values. Creates new configurations if they do not exist.';

  @override
  String get name => 'set';

  final Logger _logger;

  @override
  Future<int> run() async {
    final progress = _logger.progress('');
    final path = argResults?['secret-path']?.toString().trim();
    final key = argResults?['api-key']?.toString().trim();
    final model = argResults?['model']?.toString().trim();
    final saveSession =
        bool.tryParse(argResults?['save-session'] as String? ?? '');
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
            as Map<String, int>
        : null;
    final logprobs = bool.tryParse(argResults?['logprobs'] as String? ?? '');
    final topLogprobs =
        int.tryParse(argResults?['top-logprobs'] as String? ?? '');
    final formatArg = argResults?['response-format'] as String?;
    final responseFormat = (formatArg != null)
        ? jsonDecode(formatArg) as Map<String, dynamic>
        : null;
    final stopArg = argResults?['stop-seq'] as String?;
    final stop =
        (stopArg != null) ? jsonDecode(stopArg) as List<dynamic> : null;
    final cmdPrompt = argResults?['cmd-prompt']?.toString().trim();
    final explainPrompt = argResults?['explain-prompt']?.toString().trim();
    final codePrompt = argResults?['code-prompt']?.toString().trim();
    final chatPrompt = argResults?['chat-prompt']?.toString().trim();
    final removeSessions = argResults?['remove-sessions'] as bool?;

    if (argResults == null ||
        argResults?.options == null ||
        argResults!.options.isEmpty) {
      progress.fail();
      return ExitCode.usage.code;
    }

    if (removeSessions != null && removeSessions) {
      final confirm =
          _logger.confirm('Are you sure you want to remove all sessions?');
      if (confirm) {
        final result = await SessionService.removeSessions();
        if (result) {
          progress.complete('Done');
          return ExitCode.success.code;
        } else {
          progress.fail('Failed');
          return ExitCode.tempFail.code;
        }
      } else {
        progress.cancel();
        return ExitCode.success.code;
      }
    }

    if (key != null && key.isNotEmpty) {
      configuration ??= await ConfigService.loadConfig().getOrThrow();
      if (configuration == null) {
        _logger.err('Configuration not found');
        return ExitCode.unavailable.code;
      }
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
    if (_isAnyConfigOptionProvided([
      model,
      saveSession,
      maxMessages,
      temperature,
      maxTokens,
      topP,
      topK,
      frequencyPenalty,
      presencePenalty,
      repetitionPenalty,
      minP,
      topA,
      seed,
      logitBias,
      logprobs,
      topLogprobs,
      responseFormat,
      stop,
      cmdPrompt,
      explainPrompt,
      codePrompt,
      chatPrompt,
    ])) {
      configuration ??= await ConfigService.loadConfig().getOrThrow();
      final newConfig = configuration!.copyWith(
        defaultModel: _logUpdate('model', model, configuration!.defaultModel),
        saveSession:
            _logUpdate('save-session', saveSession, configuration!.saveSession),
        maxMessages:
            _logUpdate('max-messages', maxMessages, configuration!.maxMessages),
        temperature:
            _logUpdate('temperature', temperature, configuration!.temperature),
        maxTokens:
            _logUpdate('max-tokens', maxTokens, configuration!.maxTokens),
        topP: _logUpdate('top-p', topP, configuration!.topP),
        topK: _logUpdate('top-k', topK, configuration!.topK),
        frequencyPenalty: _logUpdate(
            'freq-penalty', frequencyPenalty, configuration!.frequencyPenalty),
        presencePenalty: _logUpdate('presence-penalty', presencePenalty,
            configuration!.presencePenalty),
        repetitionPenalty: _logUpdate('repetition-penalty', repetitionPenalty,
            configuration!.repetitionPenalty),
        minP: _logUpdate('min-p', minP, configuration!.minP),
        topA: _logUpdate('top-a', topA, configuration!.topA),
        seed: _logUpdate('seed', seed, configuration!.seed),
        logitBias:
            _logUpdate('logit-bias', logitBias, configuration!.logitBias),
        logprobs: _logUpdate('logprobs', logprobs, configuration!.logprobs),
        topLogprobs:
            _logUpdate('top-logprobs', topLogprobs, configuration!.topLogprobs),
        responseFormat: _logUpdate(
            'response-format', responseFormat, configuration!.responseFormat),
        stop: _logUpdate('stop-seq', stop, configuration!.stop),
        cmdPrompt:
            _logUpdate('cmd-prompt', cmdPrompt, configuration!.cmdPrompt),
        explainPrompt: _logUpdate(
            'explain-prompt', explainPrompt, configuration!.explainPrompt),
        codePrompt:
            _logUpdate('code-prompt', codePrompt, configuration!.codePrompt),
        chatPrompt:
            _logUpdate('chat-prompt', chatPrompt, configuration!.chatPrompt),
      );

      await ConfigService.saveConfig(newConfig: newConfig);
    }
    progress.complete('Done');
    return ExitCode.success.code;
  }

  T _logUpdate<T>(String fieldName, T? newValue, T currentValue) {
    if (newValue != null && newValue != currentValue) {
      _logger.info('\n${yellow.wrap('Updating $fieldName to $newValue')}');
      return newValue;
    }
    return currentValue;
  }
}

bool _isAnyConfigOptionProvided(List<dynamic> options) {
  for (final option in options) {
    if (option != null) {
      return true;
    }
  }
  return false;
}
