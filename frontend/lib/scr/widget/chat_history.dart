import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/scr/component/error.dart';
import 'package:frontend/scr/component/loading.dart';
import 'package:frontend/scr/controller/session.dart';

class ChatHistory extends ConsumerWidget {
  const ChatHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionListControllerProvider);
    return sessions.when(
      data: (sessions) => ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final firstMessage =
              session.messages.isNotEmpty ? session.messages.first : null;
          final firstMessageText =
              firstMessage != null ? firstMessage.content : 'N/A';
          final truncatedMessage = firstMessageText.length > 30
              ? '${firstMessageText.substring(0, 30)}...'
              : firstMessageText;

          return ListTile(
            title: Text(truncatedMessage),
            onTap: () => ref
                .read(currentSessionControllerProvider.notifier)
                .setSession(session),
            trailing: const Icon(Icons.arrow_forward),
          );
        },
      ),
      error: (e, st) => DefaultErrorWidget(
        error: e.toString(),
        stackTrace: st,
        retry: () => ref.refresh(sessionListControllerProvider),
      ),
      loading: () => const DefaultLoadingWidget(),
    );
  }
}
