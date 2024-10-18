
import 'package:buddy_chat/scr/application/session.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:buddy_chat/scr/presentation/reusable/dialog.dart';
import 'package:buddy_chat/scr/presentation/reusable/error.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/configuration.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ChatListPanel extends StatelessWidget {
  const ChatListPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(2),
      width: 0.2 * screenWidth,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Chat History'),
          SizedBox(height: 10),
          Expanded(child: _ChatHistoryListView()),
          _NewChatButton(),
          ConfigureButton(),
          _ClearAllButton()
        ],
      ),
    );
  }
}

class _NewChatButton extends ConsumerWidget {
  const _NewChatButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(children: [
        Expanded(
            child: FilledButton(
                onPressed: () async {
                  ref.invalidate(currentSessionControllerProvider);
                },
                child: const Text('New Chat')))
      ]),
    );
  }
}

class _ClearAllButton extends ConsumerWidget {
  const _ClearAllButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(
          child: FilledButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Theme.of(context).colorScheme.error),
              ),
              onPressed: () async {
                final result = await showConfirmationDialog(
                  context,
                  message: 'Are you sure you want to clear all chat history?',
                );
                if (result != null && result) {
                  await ref
                      .read(sessionListControllerProvider.notifier)
                      .removeAllSessions();
                }
              },
              child: const Text('Clear')),
        )
      ]),
    );
  }
}

class _ChatHistoryListView extends ConsumerWidget {
  const _ChatHistoryListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionListControllerProvider);
    return sessions.when(
      data: (sessions) => ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final firstMessage = session.messages.isNotEmpty
              ? session.messages.firstWhereOrNull((e) => e.role == Role.user)
              : null;
          final firstMessageText =
              firstMessage != null ? firstMessage.content : 'N/A';
          // convert timestamp into yyyy/mm/dd
          final localizedTime =
              DateTime.fromMillisecondsSinceEpoch(session.id).toLocal();
          final formattedtime =
              DateFormat.yMMMd().add_jm().format(localizedTime);
          return ListTile(
            title: Text(firstMessageText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10)),
            subtitle: Text(formattedtime,
                style: TextStyle(fontSize: 8, color: Colors.grey.shade600)),
            onTap: () => ref
                .read(currentSessionControllerProvider.notifier)
                .setSession(session),
                
            trailing: CircleAvatar(
              radius: 12,
              child: Text(
                session.messages.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
      ),
      error: (e, st) => DefaultErrorWidget(
        error: e.toString(),
        stackTrace: st,
        retry: () => ref.invalidate(sessionListControllerProvider),
      ),
      loading: () => const DefaultLoadingWidget(50),
    );
  }
}
