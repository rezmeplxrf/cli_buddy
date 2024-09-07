import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/scr/constant/theme.dart';
import 'package:frontend/scr/widget/layout.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(
    observers: [
      TalkerRiverpodObserver(),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      designSize: const Size(1200, 800),
      minTextAdapt: true,
      builder: (ctx, child) {
    return MaterialApp(
      title: 'Buddy Chat',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      home: const Layout(),
      locale: const Locale('en', 'US'),
    );
  });
  }
}
