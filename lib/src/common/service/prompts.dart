import 'sys_info.dart';

const defaultCommandPrompt = '''
If there is a lack of details, provide most logical solution.
Ensure the output is a valid shell command.
If multiple steps required try to combine them together in one command.
Provide only plain text without Markdown formatting.
Do not provide markdown formatting such as ```.''';

const defaultExplainPrompt = '''
Provide short and concise explanation of your previous response about command or code.
Provide only plain text without Markdown formatting.
Do not provide markdown formatting such as ```.''';

const defaultCodePrompt = """
Provide only code as output without any description.
Provide only code in plain text format without Markdown formatting.
Do not include symbols such as ``` or ```python.
If there is a lack of details, provide most logical solution.
You are not allowed to ask for more details.
For example if the prompt is "Hello world Python", you should return "print('Hello world')".""";

const defaultChatPrompt = '''
You are a helpful assistant.
Provide concise response unless asked for more details.''';

const defaultValidatePrompt = '''
Your job is to verify if the provided code by the previous AI assistant is valid.
Provide concise response unless asked for more details.''';

String cmdPromptCache = defaultCommandPrompt;
String explainPromptCache = defaultExplainPrompt;
String codePromptCache = defaultCodePrompt;
String chatPromptCache = defaultChatPrompt;

class PromptService {
  factory PromptService() => _instance;
  PromptService._internal();
  static final PromptService _instance = PromptService._internal();

  static String _info() {
    final os = SysInfoService.os;
    final shell = SysInfoService.shell;
    final info = "User's system information - OS: $os with $shell shell.";
    return info;
  }

  static String cmdOnly() {
    final prompt = '${_info()}\n$cmdPromptCache';
    return prompt;
  }

  static String explain() {
    return explainPromptCache;
  }

  static String codeOnly() {
    return codePromptCache;
  }

  static String chat() {
    final prompt = '${_info()}\n$chatPromptCache';
    return prompt;
  }
}
