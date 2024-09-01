import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

class SuggestionCommand extends Command<int> {
  SuggestionCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addFlag(
      'cyan',
      abbr: 'c',
      help: 'Prints the same joke, but in cyan',
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
    print(" argResults?.command: : ${argResults?.command}");
    print(" command : ${argResults?.name}");
    print(" arguments : ${argResults?.arguments}");
    print(" options : ${argResults?.options}");
    print(" multi options: ${argResults?.multiOption(name)}");
    print(" rest : ${argResults?.rest}");
    print("flags: ${argResults?.flag(name)}");
    var output = 'Which unicorn has a cold? The Achoo-nicorn!';
    if (argResults?['cyan'] == true) {
      output = lightCyan.wrap(output)!;
    }
    _logger.info(output);
    return ExitCode.success.code;
  }
}
