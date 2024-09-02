import 'dart:io';

import 'package:process_run/shell.dart';

class ActionService {
  factory ActionService() => _instance;
  ActionService._internal();
  static final ActionService _instance = ActionService._internal();

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
    /// remove Markdown code block just in case
    final cleanedCommand = command.replaceAll('```', '');

    /// using && won't work with shell.run in a single run
    final commands =
        cleanedCommand.split('&&').map((cmd) => cmd.trim()).toList();

    final shell = Shell(throwOnError: false);
    try {
      for (final cmd in commands) {
        await shell.run(cmd);
      }
    } catch (e) {
      throw Exception('Error running command: $e');
    }
  }
}
