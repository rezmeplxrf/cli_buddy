import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/app.dart';
import 'package:frontend/scr/constant/global.dart';
import 'package:system_theme/system_theme.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();

  runApp(ProviderScope(
    observers: [
      TalkerRiverpodObserver(
        talker: talker,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final color = SystemTheme.accentColor.accent.toAccentColor();
    return FluentApp(
      title: 'Buddy Chat',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      color: color,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      theme: FluentThemeData(
        accentColor: color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      home: const Layout(),
      locale: const Locale('en', 'US'),
    );
  }
}
