sudo dart compile exe ./bin/buddy.dart -o ./release/buddy_macos

import 'package:process_run/shell_run.dart';budd
var controller = ShellLinesController();
var shell = Shell(stdout: controller.sink, verbose: false);
controller.stream.listen((event) {
  // Handle output

  // ...
  // If needed kill the shell
  shell.kill();
});
try {
  await shell.run('dart echo.dart some_text');
} on ShellException catch (_) {
  // We might get a shell exception
}