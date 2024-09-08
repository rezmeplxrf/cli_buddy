import 'package:flutter/material.dart';
import 'package:frontend/scr/constant/global.dart';
import 'package:frontend/scr/service/config.dart';
import 'package:frontend/scr/widget/chat.dart';
import 'package:frontend/scr/widget/panel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(configServiceProvider).whenData((config) {
      baseUrl = 'http://${config!.ipAddress}:${config.port}';
      wsUrl = 'ws://${config.ipAddress}:${config.port}/ws';
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy Chat'),
      ),
      body: const Row(
        children: [ChatPanel(), Expanded(child: ChatScreen())],
      ),
    );
  }
}
