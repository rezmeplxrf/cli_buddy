
import 'package:buddy_chat/scr/presentation/widget/chat_input.dart';
import 'package:buddy_chat/scr/presentation/widget/message_list.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: BuildMessageList()),
        BuildInputWidget(),
      ],
    );
  }
}
