import 'dart:io';

import 'package:cli_buddy/src/common/models/exception.dart';
import 'package:cli_buddy/src/common/models/session.dart';
import 'package:cli_buddy/src/common/service/global.dart';
import 'package:cli_buddy/src/common/service/prompts.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/shell.dart';
import 'package:result_dart/result_dart.dart';

class ActionService {
  factory ActionService() => _instance;
  ActionService._internal();
  static final ActionService _instance = ActionService._internal();
  static void setLogger(Logger? logger) => _logger = logger;
  static final shell = Shell(throwOnError: false);

  static Logger? _logger;

  static Future<void> copy(String content) async {
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

    try {
      for (final cmd in commandList) {
        await shell.run(cmd);
      }
    } catch (e) {
      throw Exception('Error running command: $e');
    }
  }

  static Result<String, CustomException> retrieveFile(String fileName) {
    try {
      final file = File(fileName);

      if (!file.existsSync()) {
        return CustomException(
                message: 'File not found: $fileName',
                stack: 'ActionService.retrieveFile')
            .toFailure();
      }

      final content = file.readAsStringSync();
      return content.toSuccess();
    } catch (e) {
      return CustomException(
          message: 'Failed to load: $fileName',
          stack: 'ActionService.retrieveFile',
          details: {'error': '$e'}).toFailure();
    }
  }

  static Future<bool> saveToFile(String fileName, String content,
      {required bool shouldAutoOvewrite}) async {
    try {
      final file = File(fileName);

      if (file.existsSync() && !shouldAutoOvewrite) {
        final shouldOverwrite = _logger?.confirm(
          'File already exists. Do you want to overwrite it?',
        );
        if (shouldOverwrite == null || !shouldOverwrite) {
          return false;
        }
      }

      await file.writeAsString(content);
      _logger?.info('Output saved to $fileName');
      return true;
    } catch (e) {
      _logger?.err('$e');
      rethrow;
    }
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
    final newResult = await openRouter.invoke(
        session: newSession, shouldDebug: shouldDebug, markdown: false);
    return newResult;
  }

  static Future<void> openWeb(
      {Logger? logger, String? port, String? address}) async {
    if (port == null || address == null) {
      throw Exception('If isLocal is true, port and address must be provided');
    }
    final shell = Shell();

    if (Platform.isMacOS) {
      await shell.run('open $hostedWeb');
    } else if (Platform.isLinux) {
      try {
        await shell.run('xdg-open $hostedWeb');
      } catch (e) {
        logger?.info('xdg-open failed, trying gnome-open...');
        try {
          await shell.run('gnome-open $hostedWeb');
        } catch (e) {
          logger?.info('gnome-open failed, trying kde-open...');
          try {
            await shell.run('kde-open $hostedWeb');
          } catch (e) {
            logger?.err('All methods failed to open the URL on Linux: $e');
          }
        }
      }
    } else if (Platform.isWindows) {
      await shell.run('start $hostedWeb');
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
