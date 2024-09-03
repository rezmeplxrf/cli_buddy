import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';

class SessionService {
  factory SessionService() => _instance;
  SessionService._internal();
  static final SessionService _instance = SessionService._internal();

  static Future<List<ChatSession>?> listSessions(
    Logger logger,
  ) async {
    defaultDir ??= SysInfoService.getConfigDirectory();

    try {
      final sessionsPath = p.join(defaultDir!, 'sessions');
      final sessionsDirectory = Directory(sessionsPath);

      if (!sessionsDirectory.existsSync()) {
        logger.warn('Sessions directory does not exist.');
        return [];
      }

      final sessionFiles = sessionsDirectory
          .listSync()
          .where((file) => file is File && file.path.endsWith('.json'))
          .cast<File>();

      final sessions = <ChatSession>[];
      for (final sessionFile in sessionFiles) {
        final sessionContent = await sessionFile.readAsString();
        final sessionJson = jsonDecode(sessionContent) as Map<String, dynamic>;
        final chatSession = ChatSession.fromJson(sessionJson);
        sessions.add(chatSession);
      }
      return sessions;
    } catch (e) {
      logger
        ..err('Error loading sessions from files.')
        ..detail(e.toString());
      return null;
    }
  }

  static Future<void> saveSession(
    Logger logger, {
    required ChatSession session,
  }) async {
    configuration ??= await ConfigService.loadConfig(logger).getOrThrow();
    defaultDir ??= SysInfoService.getConfigDirectory();

    try {
      if (configuration!.saveSession) {
        if (defaultDir != null) {
          final sessionsPath = p.join(defaultDir!, 'sessions');
          final sessionFilePath = p.join(sessionsPath, '${session.id}.json');
          final sessionDir = Directory(sessionsPath);
          if (!sessionDir.existsSync()) {
            sessionDir.createSync(recursive: true);
          } else {
            final sessionFile = File(sessionFilePath);
            await sessionFile.writeAsString(jsonEncode(session.toJson()));
          }
        }
      }
    } catch (e) {
      logger
        ..err(
          'Error while saving session',
        )
        ..detail(e.toString());
    }
  }

  static Future<ChatSession?> loadSession(Logger logger,
      {required int id}) async {
    configuration ??= await ConfigService.loadConfig(logger).getOrThrow();
    defaultDir ??= SysInfoService.getConfigDirectory();

    try {
      final sessionsPath = p.join(defaultDir!, 'sessions');
      final sessionFilePath = p.join(sessionsPath, '$id.json');

      final sessionFile = File(sessionFilePath);
      if (!sessionFile.existsSync()) {
        logger.err('Session file not found: $sessionFilePath');
        return null;
      }

      final sessionContent = await sessionFile.readAsString();
      return ChatSession.fromJson(
          jsonDecode(sessionContent) as Map<String, dynamic>);
    } catch (e) {
      logger
        ..err(
          'Error loading session from file',
        )
        ..detail(e.toString());
      return null;
    }
  }
}
