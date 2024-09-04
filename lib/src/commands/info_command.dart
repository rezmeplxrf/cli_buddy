import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/domain/open_router.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:cli_buddy/src/common/service/render.dart';
import 'package:cli_buddy/src/common/service/session.dart';
import 'package:mason_logger/mason_logger.dart';

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
            'search for AI models by name, provider, model type (text, image, etc)',
        valueHelp: 'String',
      )
      ..addOption('order',
          abbr: 'o',
          help: 'order by the given value',
          valueHelp: 'String',
          allowed: [
            'name',
            'context',
            'prompt',
            'completion',
            'image'
          ],
          allowedHelp: {
            'name': 'Order by name',
            'context': 'Order by context length (from highest to lowest)',
            'prompt': 'Order by prompt pricing  (from highest to lowest)',
            'completion':
                'Order by completion pricing  (from highest to lowest)',
            'image': 'Order by image pricing  (from highest to lowest)',
          })
      ..addFlag(
        'credits',
        abbr: 'c',
        help: 'show the credits of OpenRouter',
        negatable: false,
      )
      ..addFlag(
        'list',
        abbr: 'l',
        help: 'list the all AI models in OpenRouter',
        negatable: false,
      )
      ..addOption(
        'parameters',
        abbr: 'p',
        help: "query the AI model's parameters",
        valueHelp: 'model id',
      )
      ..addOption('sessions',
          abbr: 's',
          help:
              'List the saved chat histories in the default session folder in a readable format or view the specific chat history ',
          valueHelp: 'String or Int',
          allowedHelp: {
            'list':
                'List the saved chat hbuddistories in the default session folder in a table format',
            'message id':
                'View the specific chat history in a table. Required value is id of the session',
          });
  }

  @override
  String get description => 'Search for AI models in OpenRouter';

  @override
  String get name => 'info';

  final Logger _logger;

  @override
  Future<int> run() async {
    final progress = _logger.progress('Waiting for Response');
    final query = argResults?['query'] as String?;
    final credits = argResults?['credits'] as bool?;
    final parameter = argResults?['parameters'] as String?;
    final all = argResults?['list'] as bool?;
    final sessions = argResults?['sessions'] as String?;
    final order = argResults?['order'] as String?;

    if (query == null && credits == null && all == null && parameter == null) {
      _logger.err('No options/flags provided');
      progress.fail();
      return ExitCode.usage.code;
    }
    if (credits != null && credits) {
      final result = await openRouter.checkCredits();
      final data = result.getOrNull();
      if (data != null) {
        final table = RenderService.creditInfo(data);
        _logger.info('\n$table');
      } else {
        _logger.err('Failed to get credits');
      }
    }

    if (query != null) {
      final result = await openRouter.getModelList();
      final data = result.getOrNull();
      if (data == null) {
        _logger.err('Failed to get model list');
      } else {
        final lowerCaseModel = query.toLowerCase().trim();
        final filteredData = data.where((e) {
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
          _logger
            ..info('\n$table')
            ..info(yellow.wrap(
                '* all prices (prompt, completion, image) are per million tokens in USD'))
            ..info(lightGreen.wrap('* Total Models: ${filteredData.length}'));
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
        _logger
          ..info('\n$table')
          ..info(yellow.wrap(
              '* all prices (prompt, completion, image) are per million tokens in USD'))
          ..info(lightGreen.wrap('* Total Models: ${data.length}'));
      } else {
        _logger.err('Failed to retrieve model list');
      }
    }

    if (sessions != null) {
      final savedSessions = await SessionService.listSessions(
        _logger,
      );
      _logger.info('Total saved sessions: ${savedSessions?.length ?? 0}');
      if (argResults?['sessions'] == 'list') {
        if (savedSessions == null) {
          _logger.err('No sessions found');
        } else {
          final table = RenderService.sessionList(savedSessions);
          _logger.info('\n$table');
        }
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
          _logger.info('\n$table');
        }
      }
    }
    if (parameter != null) {
      final result = await openRouter.getParameterInfo(model: parameter.trim());
      final data = result.getOrNull();
      if (data != null) {
        final table = RenderService.parameterInfoTable(parameter: data);
        _logger.info('\n$table');
      } else {
        _logger.err('Failed to get parameter info. Check the model id');
      }
    }
    progress.complete('Done');
    return ExitCode.success.code;
  }
}

List<ORModelList> _applyOrder(List<ORModelList> data, String order) {
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
