import 'package:flutter/material.dart';
import 'package:frontend/scr/component/error.dart';
import 'package:frontend/scr/component/loading.dart';
import 'package:frontend/scr/controller/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSessionAync = ref.watch(currentSessionControllerProvider);
    return currentSessionAync.when(
        data: (session) {
          return Center(child: Text('session: ${session?.id}'));
        },
        error: (e, st) => DefaultErrorWidget(
              error: e.toString(),
              stackTrace: st,
              retry: () {
                ref.invalidate(currentSessionControllerProvider);
              },
            ),
        loading: () => const DefaultLoadingWidget());
  }
}
