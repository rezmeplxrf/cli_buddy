import 'dart:async';

import 'package:args/command_runner.dart';
import '../common/models/open_router.dart';
import '../common/service/config.dart';
import '../common/service/global.dart';
import '../common/service/render.dart';
import '../common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:result_dart/result_dart.dart';

/// {@template info_command}
///
/// `buddy info`
/// A [Command] to search for AI models in OpenRouter
/// {@endtemplate}
class InfoCommand extends Command<int> {
  /// {@macro info_command}
  InfoCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'query',
        abbr: 'q',
        help:
            'Search for AI models by name, provider, or model type (e.g., text, image).',
        valueHelp: 'String',
      )
      ..addOption(
        'order',
        abbr: 'o',
        help: 'Specify the order in which the results should be displayed.',
        valueHelp: 'String',
        allowed: ['name', 'context', 'prompt', 'completion', 'image'],
        allowedHelp: {
          'name': 'Order by model name.',
          'context': 'Order by context length (from highest to lowest).',
          'prompt': 'Order by prompt pricing (from highest to lowest).',
          'completion': 'Order by completion pricing (from highest to lowest).',
          'image': 'Order by image pricing (from highest to lowest).',
        },
      )
      ..addFlag(
        'config',
        abbr: 'f',
        help:
            'Display the current configuration file. If it does not exist, create a new one.',
        negatable: false,
      )
      ..addFlag(
        'credits',
        abbr: 'c',
        help: 'Display the credits available in OpenRouter.',
        negatable: false,
      )
      ..addFlag(
        'list',
        abbr: 'l',
        help: 'List all AI models available in OpenRouter.',
        negatable: false,
      )
      ..addOption(
        'parameters',
        abbr: 'p',
        help: 'Query the parameters of a specific AI model.',
        valueHelp: 'model id',
      )
      ..addOption(
        'sessions',
        abbr: 's',
        help:
            'List saved chat histories in the default session folder or view a specific chat history.',
        valueHelp: 'String or Int',
        allowedHelp: {
          'list': 'List saved chat histories in a table format.',
          'message id': 'View a specific chat history by session ID.',
        },
      );
  }

  @override
  String get description => 'Search for AI models in OpenRouter';

  @override
  String get name => 'info';

  final Logger _logger;

  @override
  Future<int> run() async {
    final progress = _logger.progress('');
    final queryArg = argResults?['query'] as String?;
    final query = queryArg?.trim();
    final credits = argResults?['credits'] as bool?;
    final parameterArg = argResults?['parameters'] as String?;
    final parameter = parameterArg?.trim();
    final all = argResults?['list'] as bool?;
    final sessionsArg = argResults?['sessions'] as String?;
    final sessions = sessionsArg?.trim();
    final orderArg = argResults?['order'] as String?;
    final order = orderArg?.trim();
    final config = argResults?['config'] as bool?;

    if (query == null &&
        credits == null &&
        all == null &&
        parameter == null &&
        sessions == null) {
      _logger.err('No options/flags provided');
      progress.fail();
      return ExitCode.usage.code;
    }

    if (config != null && config) {
      configuration ??= await ConfigService.loadConfig().getOrNull();
      if (configuration != null) {
        final table = RenderService.configurationJson(configuration!);
        _logger.info(table);
      } else {
        _logger.err('Failed to find config file');
      }
    }

    if (credits != null && credits) {
      final result = await openRouter.checkCredits();
      final data = result.getOrNull();
      if (data != null) {
        final table = RenderService.creditInfo(data);
        _logger.info(table);
      } else {
        _logger.err('Failed to get credits');
      }
    }

    if (query != null) {
      final result = await openRouter.getModelList().getOrNull();

      if (result == null) {
        _logger.err('Failed to get model list');
      } else {
        final lowerCaseModel = query.toLowerCase().trim();
        final filteredData = result.where((e) {
          final nameMatches = e.name.toLowerCase().contains(lowerCaseModel);
          final idMatches = e.id.toLowerCase().contains(lowerCaseModel);

          final modalityMatches = e.architecture?.modality
                  ?.toLowerCase()
                  .contains(lowerCaseModel) ??
              false;

          return nameMatches || idMatches || modalityMatches;
        }).toList();

        if (filteredData.isNotEmpty) {
          final modelList = (order != null)
              ? _applyOrder(filteredData, order.trim())
              : filteredData;

          final table = RenderService.modelList(modelList);
          _logger.info(table);
        } else {
          _logger.info('No matching models found');
        }
      }
    }

    if (all != null && all) {
      final result = await openRouter.getModelList();
      final data = result.getOrNull();

      if (data != null) {
        final modelList =
            (order != null) ? _applyOrder(data, order.trim()) : data;

        final table = RenderService.modelList(modelList);
        _logger.info(table);
      } else {
        _logger.err('Failed to retrieve model list');
      }
    }

    if (sessions != null) {
      final savedSessions = await SessionService.listSessions();
      _logger.info('Total saved sessions: ${savedSessions.length}');
      if (argResults?['sessions'] == 'list') {
        final table = RenderService.sessionList(savedSessions);
        _logger.info(table);
      } else {
        final id = int.tryParse(sessions.trim());
        if (id == null) {
          _logger.err('Invalid session id');
          return ExitCode.usage.code;
        }
        final session = await SessionService.loadSession(
          id: id,
        );
        if (session == null) {
          _logger.err('Session with id $id not found');
        } else {
          final table = RenderService.messageList(session);
          _logger.info(table);
        }
      }
    }
    if (parameter != null) {
      final result = await openRouter.getParameterInfo(model: parameter.trim());
      final data = result.getOrNull();
      if (data != null) {
        final table = RenderService.parameterInfoTable(parameter: data);
        _logger.info(table);
      } else {
        _logger.err('Failed to get parameter info. Check the model id');
      }
    }
    progress.complete('Done');
    return ExitCode.success.code;
  }
}

List<ORModel> _applyOrder(List<ORModel> data, String order) {
  switch (order) {
    case 'name':
      data.sort((a, b) => a.name.compareTo(b.name));
    case 'context':
      data.sort(
          (a, b) => (b.contextLength ?? 0).compareTo(a.contextLength ?? 0));
    case 'prompt':
      data.sort((a, b) => _convertToDouble(b.pricing?.prompt)
          .compareTo(_convertToDouble(a.pricing?.prompt)));
    case 'completion':
      data.sort((a, b) => _convertToDouble(b.pricing?.completion)
          .compareTo(_convertToDouble(a.pricing?.completion)));
    case 'image':
      data.sort((a, b) => _convertToDouble(b.pricing?.image)
          .compareTo(_convertToDouble(a.pricing?.image)));
    default:
      break;
  }
  return data;
}

double _convertToDouble(String? value) {
  if (value == null) {
    return 0;
  }
  return double.tryParse(value) ?? 0.0;
}
