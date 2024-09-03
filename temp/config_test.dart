import 'dart:convert';
import 'dart:io';

import 'package:cli_buddy/src/common/domain/config.dart';
import 'package:cli_buddy/src/common/service/sys_info.dart';
import 'package:path/path.dart' as p;

void main() async {
  final config = await _loadConfigFile();
  print(config);
}

Future<Configuration?> _loadConfigFile() async {
  final configDir = SysInfoService.getConfigDirectory();

  final configFilePath = p.join(configDir!, 'buddy.config');
  final configFile = File(configFilePath);

  if (!configFile.existsSync()) {
    return null;
  }

  try {
    final configContent = await configFile.readAsString();
    final newdata = Configuration.fromJson(
        jsonDecode(configContent) as Map<String, dynamic>);
    return newdata;
  } catch (e) {
    print(e);
    return null;
  }
}
