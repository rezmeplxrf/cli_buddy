import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/scr/component/dialog.dart';
import 'package:frontend/scr/component/error.dart';
import 'package:frontend/scr/component/loading.dart';
import 'package:frontend/scr/controller/session.dart';

class ChatPanel extends StatelessWidget {
  const ChatPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 0.2.sw,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Chat History'),
          SizedBox(height: 10),
          Expanded(child: _ChatHistoryListView()),
          _NewChatButton(),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
                      .read(sessionServiceProvider.notifier)
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
    final sessions = ref.watch(sessionServiceProvider);
    return sessions.when(
      data: (sessions) => ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final firstMessage =
              session.messages.isNotEmpty ? session.messages.first : null;
          final firstMessageText =
              firstMessage != null ? firstMessage.content : 'N/A';
          // convert timestamp into yyyy/mm/dd
          final localizedTime =
              DateTime.fromMillisecondsSinceEpoch(session.id).toLocal();
          final formattedtime =
              '${localizedTime.year}/${localizedTime.month}/${localizedTime.day} ${localizedTime.hour}:${localizedTime.minute}';
          return ListTile(
            title: Text(firstMessageText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10.sp)),
            subtitle: Text(formattedtime,
                style: TextStyle(fontSize: 8.sp, color: Colors.grey.shade600)),
            onTap: () => ref
                .read(currentSessionControllerProvider.notifier)
                .setSession(session),
            trailing: CircleAvatar(
              radius: 12,
              child: Text(
                session.messages.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
            ),
          );
        },
      ),
      error: (e, st) => DefaultErrorWidget(
        error: e.toString(),
        stackTrace: st,
        retry: () => ref.invalidate(sessionServiceProvider),
      ),
      loading: () => const DefaultLoadingWidget(),
    );
  }
}
