import 'package:cli_buddy/src/common/service/sys_info.dart';

class PromptService {
  factory PromptService() => _instance;
  PromptService._internal();
  static final PromptService _instance = PromptService._internal();

  static String cmdOnly() {
    final os = SysInfoService.os;
    final shell = SysInfoService.shell;

    final prompt = '''
Provide only $shell commands for $os without any description.
If there is a lack of details, provide most logical solution.
Ensure the output is a valid shell command.
If multiple steps required try to combine them together in one command.
Provide only plain text without Markdown formatting.
Do not provide markdown formatting such as ```.
''';
    return prompt;
  }

  static String explain() {
    const explainPrompt = '''
Provide short and concise explanation of your previous response about command or code.
Provide only plain text without Markdown formatting.
Do not provide markdown formatting such as ```
''';
    return explainPrompt;
  }

  static String codeOnly() {
    const codeOnlyPrompt = """
Provide only code as output without any description.
Provide only code in plain text format without Markdown formatting.
Do not include symbols such as ``` or ```python.
If there is a lack of details, provide most logical solution.
You are not allowed to ask for more details.
For example if the prompt is "Hello world Python", you should return "print('Hello world')".""";

    return codeOnlyPrompt;
  }

  static String chat() {
    final os = SysInfoService.os;
    final shell = SysInfoService.shell;

    final askPrompt = '''
User's system information - OS: $os with $shell shell.
Provide concise response unless asked for more details.
Avoid using any markdown formatting such as ```, *, #.
''';
    return askPrompt;
  }
}
