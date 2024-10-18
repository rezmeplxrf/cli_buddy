import 'dart:async';

import 'package:buddy_chat/scr/application/send_message.dart';
import 'package:buddy_chat/scr/application/session.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/constant/helper.dart';
import 'package:buddy_chat/scr/domain/open_router.dart';
import 'package:buddy_chat/scr/domain/session.dart';
import 'package:buddy_chat/scr/presentation/reusable/error.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/editor.dart';
import 'package:buddy_chat/scr/presentation/widget/markdown.dart';
import 'package:buddy_chat/scr/presentation/widget/validate_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class BuildMessageList extends HookConsumerWidget {
  const BuildMessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSessionAync = ref.watch(currentSessionControllerProvider);
    final scrollController = useScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
    });
    return Padding(
      padding: const EdgeInsets.all(12),
      child: currentSessionAync.when(
          data: (session) {
            Global.talker.debug(
                'Current session: ${session?.messages.last.content.length}');
            if (session == null) return null;

            return ListView.builder(
              controller: scrollController,
              physics:  const RangeMaintainingScrollPhysics(),
              itemCount: session.messages.length,
              itemBuilder: (context, index) {
                final message = session.messages[index];

                return _BuildMessageItem(
                    message: message,
                    session: session,
                    scrollController: scrollController);
              },
            );
          },
          error: (e, st) => DefaultErrorWidget(
                error: e.toString(),
                stackTrace: st,
                retry: () {
                  ref.invalidate(currentSessionControllerProvider);
                },
              ),
          loading: () => const DefaultLoadingWidget(200)),
    );
  }
}

class _BuildMessageItem extends HookConsumerWidget {
  const _BuildMessageItem(
      {required this.message,
      required this.session,
      required this.scrollController});
  final Message message;
  final ChatSession session;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showValidation = useState(false);
    final isEditing = useState(false);
    final dateTime = DateFormat.yMMMd().add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(message.timestamp).toLocal());
    final textController = useTextEditingController(text: message.content);

    useEffect(() {
      textController.text = message.content;
      return;
    }, [message.content]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Helper.capitalizeFirstLetter(message.role.name),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (message.role != Role.user)
                Text(
                  ' (${message.overriddenModelId ?? session.modelId})',
                ),
              if (message.usage != null)
                _BuildUsageWidget(usage: message.usage!)
            ],
          ),
          Text(
            dateTime,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
          ),
          if (!isEditing.value)
            BuildMarkdownWidget(message: message)
          else
            Editor(
              debounceTime: 1200,
              textController: textController,
            ),
          if (message.role == Role.assistant &&
              message.content.contains(errorMessagePart))
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await ref.read(sendMessageServiceProvider).retry(
                            currentSession: session, messageToRemove: message);
                      } catch (e) {
                        await EasyLoading.showError(e.toString(),
                            duration: const Duration(seconds: 5));
                      }
                    },
                    label: const Text('Retry'),
                    icon: const Icon(Icons.replay)),
              ),
            ),
          if ((message.role == Role.assistant && message.usage != null) ||
              (message.role == Role.user &&
                  message.content.trim().isNotEmpty) ||
              (message.role == Role.system))
            _BuildButtons(
              isEditing: isEditing,
              currentSession: session,
              message: message,
              showValidation: showValidation,
              textController: textController,
            ),
          if (message.validation != null && showValidation.value) ...[
            _BuildValidationContainer(
              message: message,
              showValidation: showValidation,
            ),
          ],
          const Divider()
        ],
      ),
    );
  }
}

class _BuildValidationContainer extends StatelessWidget {
  const _BuildValidationContainer({
    required this.message,
    required this.showValidation,
  });

  final Message message;
  final ValueNotifier<bool> showValidation;
  @override
  Widget build(BuildContext context) {
    if (message.validation == null) return const SizedBox.shrink();
    final dateTime = DateFormat.yMMMd().add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(message.validation!.timestamp)
            .toLocal());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Row(
          children: [
            Text(
              Helper.capitalizeFirstLetter(Role.reviewer.name),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (message.usage != null)
              _BuildUsageWidget(usage: message.validation!.usage!)
          ],
        ),
        Text(
          dateTime,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BuildMarkdownWidget(
            message: Message(
                role: Role.reviewer,
                content: message.validation!.result,
                timestamp: message.validation!.timestamp,
                usage: message.validation!.usage),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  showValidation.value = false;
                },
                child: const Text('Hide Validation'),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _BuildUsageWidget extends StatelessWidget {
  const _BuildUsageWidget({required this.usage});
  final Usage usage;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 9, color: Theme.of(context).colorScheme.secondary);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(' - Prompt Tokens: ${usage.promptTokens} | ', style: textStyle),
          Text('Completion Tokens: ${usage.completionTokens} | ',
              style: textStyle),
          Text('Total Tokens: ${usage.totalTokens} | ', style: textStyle),
          Text('Response Time: ${usage.responseTime}s', style: textStyle),
        ],
      ),
    );
  }
}

class _BuildButtons extends HookConsumerWidget {
  const _BuildButtons(
      {required this.message,
      required this.isEditing,
      required this.currentSession,
      required this.showValidation,
      required this.textController});
  final Message message;
  final ChatSession currentSession;
  final ValueNotifier<bool> showValidation;
  final ValueNotifier<bool> isEditing;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCopied = useState<bool>(false);
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Wrap(
        spacing: 3,
        children: [
          _buildIconButton(
              tooltip: 'Copy',
              onPressed: () async {
                if (hasCopied.value) return;
                hasCopied.value = true;
                await Clipboard.setData(ClipboardData(text: message.content));
                Future.delayed(const Duration(seconds: 2), () {
                  hasCopied.value = false;
                });
              },
              icon: Icon(hasCopied.value ? Icons.check : Icons.copy_outlined)),
          if (isEditing.value)
            _buildIconButton(
              tooltip: 'Cancel Edit',
              onPressed: () {
                isEditing.value = false;
              },
              icon: const Icon(Icons.clear_outlined),
            ),
          _buildIconButton(
              tooltip: isEditing.value ? 'Save' : 'Edit',
              onPressed: () {
                if (isEditing.value) {
                  if (textController.text.trim().isNotEmpty) {
                    ref.read(sendMessageServiceProvider).sendEditedMessage(
                        currentSession: currentSession,
                        messageToEdit: message,
                        editedContent: textController.text);
                  }
                  isEditing.value = false;
                } else {
                  isEditing.value = true;
                }
              },
              icon: Icon(
                  isEditing.value ? Icons.save_outlined : Icons.edit_outlined)),
          if (message.role == Role.assistant) ...[
            _buildIconButton(
              tooltip: 'Refresh',
              onPressed: () async {
                try {
                  await ref.read(sendMessageServiceProvider).retry(
                      currentSession: currentSession, messageToRemove: message);
                } catch (e) {
                  await EasyLoading.showError(e.toString());
                }
              },
              icon: const Icon(Icons.refresh_outlined),
            ),
            _buildIconButton(
                tooltip: 'Validate',
                onPressed: () async {
                  final validateRequest = await showDialog<ValidateRequest?>(
                      context: context,
                      builder: (context) {
                        return ValidateDialog(
                            currentSession: currentSession,
                            targetMessage: message);
                      });
                  if (validateRequest == null) return;
                  try {
                    showValidation.value = true;
                    await ref
                        .read(currentSessionControllerProvider.notifier)
                        .requestValidation(request: validateRequest);
                  } catch (e) {
                    await EasyLoading.showError(e.toString(),
                        duration: const Duration(seconds: 5));
                  }
                },
                icon: const Icon(Icons.check_outlined)),
            if (message.validation != null)
              _buildIconButton(
                  tooltip: 'Show Validation',
                  onPressed: () {
                    showValidation.value = !showValidation.value;
                  },
                  icon: Icon(showValidation.value
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined)),
          ]
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required VoidCallback? onPressed,
    required Widget icon,
    required String tooltip,
  }) {
    return IconButton(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      visualDensity: VisualDensity.compact,
      iconSize: 20,
      tooltip: tooltip,
      icon: icon,
      onPressed: onPressed,
    );
  }
}
