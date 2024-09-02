import 'package:cli_buddy/src/common/service/sys_info.dart';

void main() {
  print('Operating System: ${SysInfoService.os}');
  print('Language: ${SysInfoService.language}');
  print('Current Shell: ${SysInfoService.shell}');
  print('SDK Path: ${SysInfoService.sdkPath}');
}
