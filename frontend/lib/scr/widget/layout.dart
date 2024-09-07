import 'package:flutter/material.dart';
import 'package:frontend/scr/widget/chat.dart';
import 'package:frontend/scr/widget/panel.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy Chat'),
      ),
      body: const Row(
        children: [
          ChatPanel(),
          Expanded(child: ChatScreen())
        ],
      ),
    );
  }
}
