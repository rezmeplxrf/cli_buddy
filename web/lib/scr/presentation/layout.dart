import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/data/websocket.dart';
import 'package:buddy_chat/scr/presentation/chat.dart';
import 'package:buddy_chat/scr/presentation/panel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(webSocketRespositoryProvider);
    ref.watch(configServiceProvider).whenData((config) {
      baseUrl = 'http://${config?.localEndpoint}';
      wsUrl = 'ws://${config?.localEndpoint}/ws';
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buddy Chat'),
        ),
        body: const Row(
          children: [ChatListPanel(), Expanded(child: ChatScreen())],
        ),
      ),
    );
  }
}
