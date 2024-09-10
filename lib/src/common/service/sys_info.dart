import 'dart:io';
import 'package:path/path.dart' as p;

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

  static String get sdkPath =>
      p.dirname(p.dirname(Platform.resolvedExecutable));

  static String? getConfigDirectory() {
    String? configDir;
    if (Platform.isWindows) {
      configDir = Platform.environment['APPDATA'];
    } else if (Platform.isMacOS) {
      configDir = p.join(
          Platform.environment['HOME']!, 'Library', 'Application Support');
    } else if (Platform.isLinux) {
      configDir = p.join(Platform.environment['HOME']!);
    }

    if (configDir != null) {
      return p.join(configDir, 'buddy');
    } else {
      return throw UnsupportedError('Unsupported OS');
    }
  }
}
