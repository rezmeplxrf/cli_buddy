import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/scr/constant/global.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

void main() {
  runApp(ProviderScope(
    observers: [
      TalkerRiverpodObserver(
        talker: talker,
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
