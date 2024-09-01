import 'package:args/command_runner.dart';
import 'package:cli_buddy/src/common/domain/common_llm.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template suggest_command}
///
/// `buddy suggest`
/// A [Command] to get cli suggestion based on prompt
/// {@endtemplate}
class SuggestionCommand extends Command<int> {
  /// {@macro suggest_command}
  SuggestionCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addFlag(
      'desc',
      abbr: 'c',
      help: 'Also describe the command',
      negatable: false,
    );
  }

  @override
  String get description => 'Suggests a command based on prompt';

  @override
  String get name => 'suggest';

  final Logger _logger;

  @override
  Future<int> run() async {
    final args = argResults?.arguments;
    if (args == null || args.isEmpty) {
      _logger.info('Usage: $name <prompt>');
      return ExitCode.usage.code;
    }
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final sysMsg = Message(
        role: Role.system,
        content: PromptsService.cmdOnly(),
        timestamp: currentTime);
    final userMsg =
        Message(role: Role.user, content: args.first, timestamp: currentTime);
    final session = ChatSession(messages: [sysMsg, userMsg], model: '');
    // if (argResults?['cyan'] == true) {
    //   output = lightCyan.wrap(output)!;
    // }
    // _logger.info(output);
    return ExitCode.success.code;
  }
}
