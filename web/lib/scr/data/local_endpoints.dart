import 'dart:convert';

import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_endpoints.g.dart';

@riverpod
FutureOr<List<ChatSession>> listSession(
  ListSessionRef ref,
) async {
  final response = await Global.dio.get<String>(
    '$baseUrl/session-list',
  );
  if (response.statusCode != 200) {
    throw Exception('Error fetching session lis - ${response.data}');
  }
  if (response.data == null) {
    return [];
  }
  final data = jsonDecode(response.data!) as List<dynamic>;
  final sessions = data
      .map((json) => ChatSession.fromJson(json as Map<String, dynamic>))
      .toList();
  return sessions;
}

// /save-session
@riverpod
FutureOr<void> saveSessionToLocal(SaveSessionToLocalRef ref,
    {required ChatSession newSession}) async {
  final response = await Global.dio.post<String>(
    '$baseUrl/save-session',
    data: newSession.toJson(),
  );
  if (response.statusCode != 200) {
    throw Exception('Error requesting validation - ${response.data}');
  }
}

@riverpod
FutureOr<List<SysPrompt>> getSysPrompts(
  GetSysPromptsRef ref,
) async {
  final response = await Global.dio.get<String>(
    '$baseUrl/prompts',
  );
  if (response.statusCode != 200) {
    throw Exception('Error fetching session lis - ${response.data}');
  }
  final data = jsonDecode(response.data!) as List<dynamic>;
  final sessions = data
      .map((json) => SysPrompt.fromJson(json as Map<String, dynamic>))
      .toList();
  return sessions;
}

@riverpod
FutureOr<bool> setSysPrompts(SetSysPromptsRef ref,
    {required List<SysPrompt> sysPrompts}) async {
  final response =
      await Global.dio.post<String>('$baseUrl/prompts', data: jsonEncode(sysPrompts));
  if (response.statusCode != 200) {
    throw Exception('Error fetching session lis - ${response.data}');
  }
  return true;
}

@riverpod
FutureOr<int> removeSession(RemoveSessionRef ref, {required int id}) async {
  final response = await Global.dio.post<String>(
    '$baseUrl/remove-session',
    data: {'sessionId': id},
  );
  if (response.statusCode != 200) {
    throw Exception('Error removing session $id');
  }
  return id;
}

@riverpod
FutureOr<void> removeAllSessions(RemoveAllSessionsRef ref) async {
  final response = await Global.dio.post<String>(
    '$baseUrl/remove-all',
    data: {'clearSessions': true},
  );
  if (response.statusCode != 200) {
    throw Exception('Error removing all sessions');
  }
  return;
}

@riverpod
FutureOr<String> makeFile(MakeFileRef ref,
    {required String path, required String code}) async {
  final response = await Global.dio.post<String>(
    '$baseUrl/make-file',
    data: {'path': path, 'code': code},
  );
  if (response.statusCode != 200) {
    throw Exception('Error making file at $path');
  }
  return path;
}

@riverpod
FutureOr<Configuration> getConfig(GetConfigRef ref) async {
  final link = ref.keepAlive();
  final response = await Global.dio.get<String>(
    '$baseUrl/config',
  );
  if (response.statusCode != 200) {
    link.close();
    throw Exception('Error getting config');
  }
  ref.onDispose(link.close);
  final config = Configuration.fromJson(jsonDecode(response.data!) as Map<String, dynamic>);
  return config;
}

@riverpod
FutureOr<Configuration> setConfig(SetConfigRef ref,
    {required Configuration newConfig}) async {
  final response = await Global.dio.post<String>(
    '$baseUrl/config',
    data: newConfig.toJson(),
  );
  if (response.statusCode != 200) {
    throw Exception('Error setting config');
  }
  ref.invalidate(getConfigProvider);
  final config = Configuration.fromJson(jsonDecode(response.data!) as Map<String, dynamic>);
  return config;
}
