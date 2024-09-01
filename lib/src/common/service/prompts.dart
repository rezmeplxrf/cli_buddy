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
If multiple steps required try to combine them together using &&.
Provide only plain text without Markdown formatting.
Do not provide markdown formatting such as ```.
''';
    return prompt;
  }

  static String describeCMD() {
    const describeShellPrompt = '''
Provide a terse, single sentence description of the given shell command.
Describe each argument and option of the command.
Provide short responses in about 80 words.
APPLY MARKDOWN formatting when possible.''';

    return describeShellPrompt;
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

  static String ask() {
    final os = SysInfoService.os;
    final shell = SysInfoService.shell;

    final askPrompt = '''
You are programming and system administration assistant.
You are managing $os operating system with $shell shell.
Provide short responses in about 100 words, unless you are specifically asked for more details.
If you need to store any data, assume it will be stored in the conversation.
APPLY MARKDOWN formatting when possible.''';
    return askPrompt;
  }
}
