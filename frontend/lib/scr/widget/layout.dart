import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/scr/widget/chat_history.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy Chat'),
      ),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: 0.2.sw,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatHistory(),
              ],
            ),
          ),
          const Expanded(child: Center(child: Text('body')))
        ],
      ),
    );
  }
}
