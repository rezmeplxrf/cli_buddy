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
    final shell = Shell();

    try {
      if (Platform.isWindows) {
        // Windows
        await shell.run('''
          $command}
        ''');
      } else if (Platform.isMacOS || Platform.isLinux) {
        // macOS and Linux
        await shell.run('''
          $command}
        ''');
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      throw Exception('Error running command: $e');
    }
  }
}
