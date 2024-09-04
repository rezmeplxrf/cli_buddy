import 'dart:io';

import 'package:cli_buddy/src/common/domain/exception.dart';
import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';
import 'package:result_dart/result_dart.dart';

class ActionService {
  factory ActionService() => _instance;
  ActionService._internal();
  static final ActionService _instance = ActionService._internal();
  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;

  static Future<void> copy(String content) async {
    final shell = Shell();

    if (Platform.isWindows) {
      // Windows
      await shell.run('echo $content | clip');
    } else if (Platform.isMacOS) {
      // macOS
      final process = await Process.start('pbcopy', []);
      process.stdin.write(content);
      await process.stdin.close();
      await process.exitCode;
    } else if (Platform.isLinux) {
      // Linux
      try {
        final process =
            await Process.start('xclip', ['-selection', 'clipboard']);
        process.stdin.write(content);
        await process.stdin.close();
        await process.exitCode;
      } catch (e) {
        final process = await Process.start('xsel', ['--clipboard', '--input']);
        process.stdin.write(content);
        await process.stdin.close();
        await process.exitCode;
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static Future<void> run(
    String command,
  ) async {
    /// using && won't work with shell.run in a single run so need to run each command separately
    final commandList = command.split('&&').map((cmd) => cmd.trim()).toList();

    final shell = Shell(throwOnError: false);
    try {
      for (final cmd in commandList) {
        await shell.run(cmd);
      }
    } catch (e) {
      throw Exception('Error running command: $e');
    }
  }

  static Future<void> saveToFile(String fileName, String content) async {
    final file = File(fileName);

    if (file.existsSync()) {
      final shouldOverwrite = _logger?.confirm(
        'File already exists. Do you want to overwrite it?',
      );

      if (shouldOverwrite == null || !shouldOverwrite) {
        return;
      }
    }

    await file.writeAsString(content);
    _logger?.info('Output saved to $fileName');
  }

  static Future<Result<ChatSession, CustomException>> explain(
      ChatSession session,
      {required bool shouldDebug}) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final newMsg = Message(
        role: Role.user,
        content: PromptService.explain(),
        timestamp: currentTime);

    final newSession =
        session.copyWith(messages: [...session.messages, newMsg]);
    final newResult =
        await openRouter.invoke(session: newSession, shouldDebug: shouldDebug, markdown: false);
    return newResult;
  }
}
