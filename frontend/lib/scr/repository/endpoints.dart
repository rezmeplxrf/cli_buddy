import 'dart:convert';

import 'package:frontend/scr/constant/global.dart';
import 'package:frontend/scr/model/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'endpoints.g.dart';

@riverpod
FutureOr<List<ChatSession>> listSession(
  ListSessionRef ref,
) async {
  final response = await dio.get<List<dynamic>>(
    '$baseUrl/session-list',
  );
  if (response.statusCode != 200) {
    throw Exception('Error fetching session lis - ${response.data}');
  }
 
 
  final sessions = response.data!
      .map((json) => ChatSession.fromJson(json as Map<String, dynamic>))
      .toList();
  return sessions;
}

@riverpod
FutureOr<List<SysPrompt>> getSysPrompts(
  GetSysPromptsRef ref,
) async {
  final response = await dio.get<List<dynamic>>(
    '$baseUrl/prompts',
  );
  if (response.statusCode != 200) {
    throw Exception('Error fetching session lis - ${response.data}');
  }
  final sessions = response.data!
      .map((json) => SysPrompt.fromJson(json as Map<String, dynamic>))
      .toList();
  return sessions;
}

@riverpod
FutureOr<bool> setSysPrompts(SetSysPromptsRef ref,
    {required List<SysPrompt> sysPrompts}) async {
  final response = await dio.post<List<dynamic>>('$baseUrl/prompts',
      data: jsonEncode(sysPrompts));
  if (response.statusCode != 200) {
    throw Exception('Error fetching session lis - ${response.data}');
  }

  return true;
}

@riverpod
FutureOr<int> removeSession(RemoveSessionRef ref, {required int id}) async {
  final response = await dio.post<Map<String, dynamic>>(
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
  final response = await dio.post<Map<String, dynamic>>(
    '$baseUrl/remove-all',
  );
  if (response.statusCode != 200) {
    throw Exception('Error removing all sessions');
  }
  return;
}

@riverpod
FutureOr<String> makeFile(MakeFileRef ref,
    {required String path, required String code}) async {
  final response = await dio.post<Map<String, dynamic>>(
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
  final response = await dio.get<Map<String, dynamic>>(
    '$baseUrl/config',
  );
  if (response.statusCode != 200) {
    throw Exception('Error getting config');
  }
  final config = Configuration.fromJson(response.data!);
  return config;
}

@riverpod
FutureOr<Configuration> setConfig(SetConfigRef ref,
    {required Configuration newConfig}) async {
  final response = await dio.post<Map<String, dynamic>>(
    '$baseUrl/config',
    data: newConfig.toJson(),
  );
  if (response.statusCode != 200) {
    throw Exception('Error setting config');
  }
  final config = Configuration.fromJson(response.data!);
  return config;
}
