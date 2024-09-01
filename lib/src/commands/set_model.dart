import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template set_model_command}
///
/// `buddy set-model`
/// A [Command] to set the default model
/// {@endtemplate}
class SetModelCommand extends Command<int> {
  /// {@macro set_model_command}
  SetModelCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addOption(
      'model',
      abbr: 'm',
      help: 'Name of the default model',
      valueHelp: 'model',
    );
  }

  @override
  String get description => 'Sets the default model';

  @override
  String get name => 'set-model';

  final Logger _logger;

  @override
  Future<int> run() async {
    final model = argResults?['model'];
    if (model == null) {
      _logger.err('Please provide a model name using --model or -m');
      return ExitCode.usage.code;
    }

    final file = File('buddy.config');

    if (!file.existsSync()) {
      _logger.info('Config file not found. Creating a new one.');
      await file.create(recursive: true);
    }

    await file.writeAsString('default_model=$model\n', mode: FileMode.append);
    _logger.info('Model saved successfully: $model');
    return ExitCode.success.code;
  }
}
