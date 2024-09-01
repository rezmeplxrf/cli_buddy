import 'dart:io';

class SysInfoService {
  factory SysInfoService() => _instance;
  SysInfoService._internal();
  static final SysInfoService _instance = SysInfoService._internal();

  /// Get current OS
  static String get os => Platform.operatingSystem;

  /// Get system language
  static String get language => Platform.localeName;

  /// Get current shell
  static String get shell {
    if (Platform.isWindows) {
      return Platform.environment['ComSpec'] ?? 'Unknown';
    } else {
      return Platform.environment['SHELL'] ?? 'Unknown';
    }
  }
}
