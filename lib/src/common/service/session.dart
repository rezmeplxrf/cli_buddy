import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/models/session.dart';
import 'package:cli_buddy/src/common/service/config.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:result_dart/result_dart.dart';

class SessionService {
  factory SessionService() => _instance;
  SessionService._internal();
  static final SessionService _instance = SessionService._internal();

  static void setLogger(Logger? logger) => _logger = logger;
  static List<ChatSession> _sessionsCache = [];
  static Logger? _logger;
  static DateTime? _lastCacheUpdate;

  static Future<List<ChatSession>> listSessions() async {
    defaultDir ??= SysInfoService.getConfigDirectory();

    final sessionsPath = p.join(defaultDir!, 'sessions');
    final sessionsDirectory = Directory(sessionsPath);

    if (!sessionsDirectory.existsSync()) {
      _logger?.warn('Sessions directory does not exist.');
      return [];
    }

    // Check if cache is still valid (e.g., not older than 3 minutes)
    final now = DateTime.now();
    if (_sessionsCache.isEmpty &&
        _lastCacheUpdate != null &&
        now.difference(_lastCacheUpdate!).inMinutes < 3) {
      return _sessionsCache;
    }
    final sessionFiles = sessionsDirectory
        .listSync()
        .where((file) => file is File && file.path.endsWith('.json'))
        .cast<File>();

    final sessions = <ChatSession>[];
    var hasNewSessions = false;

    for (final sessionFile in sessionFiles) {
      try {
        final sessionContent = await sessionFile.readAsString();
        final sessionJson = jsonDecode(sessionContent) as Map<String, dynamic>;
        final chatSession = ChatSession.fromJson(sessionJson);
        sessions.add(chatSession);

        // Check if this session is new or updated
        if (_sessionsCache.isEmpty ||
            !_sessionsCache.any((s) => s.id == chatSession.id)) {
          hasNewSessions = true;
        }
      } catch (e) {
        _logger?.err('Error while loading session: ${sessionFile.path} - $e');
      }
    }

    if (hasNewSessions || _sessionsCache.isEmpty) {
      _sessionsCache = sessions;
      _lastCacheUpdate = now;
    }

    return _sessionsCache;
  }

  static Future<void> saveSession({
    required ChatSession session,
  }) async {
    configuration ??= await ConfigService.loadConfig().getOrThrow();
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
            await sessionFile.writeAsString(jsonEncode(session.toJson()),
                flush: true);
          }
        }
      }
     
      _sessionsCache..removeWhere((s) => s.id == session.id)
      ..add(session);
      _lastCacheUpdate = DateTime.now();
    } catch (e) {
      _logger
        ?..err(
          'Error while saving session',
        )
        ..detail(e.toString());
    }
  }

  static Future<ChatSession?> loadSession({required int id}) async {
    configuration ??= await ConfigService.loadConfig().getOrThrow();
    defaultDir ??= SysInfoService.getConfigDirectory();

    try {
      final sessionsPath = p.join(defaultDir!, 'sessions');
      final sessionFilePath = p.join(sessionsPath, '$id.json');

      final sessionFile = File(sessionFilePath);
      if (!sessionFile.existsSync()) {
        _logger?.err('Session file not found: $sessionFilePath');
        return null;
      }

      final sessionContent = await sessionFile.readAsString();
      return ChatSession.fromJson(
          jsonDecode(sessionContent) as Map<String, dynamic>);
    } catch (e) {
      _logger
        ?..err(
          'Error loading session from file',
        )
        ..detail(e.toString());
      return null;
    }
  }

  static Future<bool> removeSession({required int id}) async {
    defaultDir ??= SysInfoService.getConfigDirectory();
    try {
      final sessionsPath = p.join(defaultDir!, 'sessions');
      final sessionFilePath = p.join(sessionsPath, '$id.json');

      final sessionsFile = File(sessionFilePath);

      if (!sessionsFile.existsSync()) {
        _logger?.err('Sessions directory does not exist.');
        return false;
      } else {
        sessionsFile.deleteSync();
        _sessionsCache.removeWhere((s) => s.id == id);
        _lastCacheUpdate = DateTime.now();
        _logger?.info('Session $id has been removed.');
        return true;
      }
    } catch (e) {
      _logger
        ?..err('Error removing session file.')
        ..detail(e.toString());
      return false;
    }
  }

  static Future<bool> removeSessions() async {
    defaultDir ??= SysInfoService.getConfigDirectory();

    try {
      final sessionsPath = p.join(defaultDir!, 'sessions');
      final sessionsDirectory = Directory(sessionsPath);

      if (!sessionsDirectory.existsSync()) {
        _logger?.err('Sessions directory does not exist.');
        return false;
      }

      final sessionFiles = sessionsDirectory
          .listSync()
          .where((file) => file is File && file.path.endsWith('.json'))
          .cast<File>();

      for (final sessionFile in sessionFiles) {
        await sessionFile.delete();
      }
      _logger?.info('All session files have been removed.');
      _sessionsCache = [];
      _lastCacheUpdate = null;
      return true;
    } catch (e) {
      _logger
        ?..err('Error removing session files.')
        ..detail(e.toString());
      return false;
    }
  }
}
