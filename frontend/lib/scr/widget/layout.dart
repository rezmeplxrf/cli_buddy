import 'package:flutter/material.dart';
import 'package:frontend/scr/widget/chat_history.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatHistory(),
              ],
            ),
          ),
        ),
        Expanded(child: Text('body'))
      ],
    );
  }
}
