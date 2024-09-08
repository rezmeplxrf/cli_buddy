import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/scr/model/config.dart';
import 'package:frontend/scr/model/session.dart';
import 'package:frontend/scr/service/config.dart';
import 'package:frontend/scr/service/session.dart';
import 'package:frontend/scr/widget/component/error.dart';
import 'package:frontend/scr/widget/component/helper.dart';
import 'package:frontend/scr/widget/component/loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSessionAync = ref.watch(currentSessionControllerProvider);
    return currentSessionAync.when(
        data: (session) {
          return Column(
            children: [
              Expanded(child: _BuildMarkDownList(messages: session!.messages)),
              const _BuildInputComponent(),
            ],
          );
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

class _BuildInputComponent extends HookConsumerWidget {
  const _BuildInputComponent();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    void send() {
      final text = textController.text.trim();
      if (text.isNotEmpty) {
        //TODO: Implement the send action here
        textController.clear();
      }
    }

    final focusNode = useFocusNode(onKeyEvent: (node, event) {
      if (event.logicalKey.keyLabel == 'Enter' &&
          !HardwareKeyboard.instance.isShiftPressed) {
        if (event is KeyDownEvent) {
          send();
        }
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              enableInteractiveSelection: true,
              controller: textController,
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                // counter: Row(
                //   children: [
                //     IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                //     IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                //     IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                //     IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                //     Text('${textController.text.length}'),
                //   ],
                // ),
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) {
                return Row(
                  children: [
                    const _SysPromptsDropdown(),
                    Text('$currentLength'),
                  ],
                );
              },
              onSubmitted: (text) {
                send();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: send,
          ),
        ],
      ),
    );
  }
}

class _BuildMarkDownList extends StatelessWidget {
  const _BuildMarkDownList({required this.messages});
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config =
        isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final role = message.role.toString().split('.').last;
        final dateTime =
            DateTime.fromMillisecondsSinceEpoch(message.timestamp).toLocal();
        final formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Helper.capitalizeFirstLetter(role)} - $formattedDate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              _BuildMarkdownWidget(
                  message: message, config: config, isDark: isDark),
              const Divider()
            ],
          ),
        );
      },
    );
  }
}

class _BuildMarkdownWidget extends StatelessWidget {
  const _BuildMarkdownWidget({
    required this.message,
    required this.config,
    required this.isDark,
  });

  final Message message;
  final MarkdownConfig config;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    _CodeWrapperWidget codeWrapper(
        Widget child, String text, String? language) {
      return _CodeWrapperWidget(child, text, language, isDark);
    }

    return MarkdownWidget(
      data: message.content,
      shrinkWrap: true,
      config: config.copy(configs: [
        if (isDark)
          PreConfig.darkConfig.copy(wrapper: codeWrapper)
        else
          const PreConfig().copy(wrapper: codeWrapper),
        LinkConfig(
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          onTap: (url) {
            launchUrl(Uri.parse(url));
          },
        )
      ]),
    );
  }
}

class _CodeWrapperWidget extends HookWidget {
  const _CodeWrapperWidget(this.child, this.text, this.language, this.isDark);
  final Widget child;
  final String text;
  final String? language;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final hasCopied = useState<bool>(false);
    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (language != null && language!.isNotEmpty)
                  SelectionContainer.disabled(
                      child: Container(
                    margin: const EdgeInsets.only(right: 2),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            width: 0.5,
                            color: isDark ? Colors.white : Colors.black)),
                    child: Text(language!),
                  )),
                InkWell(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: !hasCopied.value
                        ? const Icon(Icons.copy_rounded)
                        : const Icon(Icons.check),
                  ),
                  onTap: () async {
                    if (hasCopied.value) return;
                    await Clipboard.setData(ClipboardData(text: text));
                    Future.delayed(const Duration(seconds: 2), () {
                      hasCopied.value = false;
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _SysPromptsDropdown extends HookConsumerWidget {
  const _SysPromptsDropdown();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promptsAsync = ref.watch(sysPromptServiceProvider);
    final configAsync = ref.watch(configServiceProvider);
    final errorMsg = useState<String?>(null);
    return Row(
      children: [
        promptsAsync.when(
          data: (prompts) {
            final defaultPrompt = configAsync.maybeWhen(
              data: (config) {
                return SysPrompt(
                  name: 'Default',
                  prompt: config?.chatPrompt ?? 'You are a Helpful Assistant',
                );
              },
              orElse: () => null,
            );

            final uniquePrompts = <SysPrompt>{...prompts};
            if (defaultPrompt != null) {
              uniquePrompts.add(defaultPrompt);
            }

            return DropdownMenu<SysPrompt>(
              hintText: 'System prompt',
              errorText: errorMsg.value,
              searchCallback:
                  (List<DropdownMenuEntry<SysPrompt>> entries, String query) {
                if (query.isEmpty) {
                  return null;
                }
                final index = entries.indexWhere(
                    (DropdownMenuEntry<SysPrompt> entry) =>
                        entry.label == query);

                return index != -1 ? index : null;
              },
              initialSelection: defaultPrompt,
              onSelected: (value) {
                if (value != null) {
                  ref.read(selectedSysPromptProvider.notifier).set(value);
                  errorMsg.value = null;
                } else {
                  errorMsg.value = 'Invalid prompt';
                }
              },
              dropdownMenuEntries: uniquePrompts.map((prompt) {
                return DropdownMenuEntry<SysPrompt>(
                    label: prompt.name,
                    value: prompt,
                    trailingIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {},
                        icon: const Icon(Icons.edit)));
              }).toList(),
            );
          },
          loading: DefaultLoadingWidget.new,
          error: (error, stack) => Text('Error: $error'),
        ),
        const AddPrompt(),
      ],
    );
  }
}

class AddPrompt extends HookConsumerWidget {
  const AddPrompt({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aliasController = useTextEditingController();
    final promptController = useTextEditingController();
    Future<bool> send() async {
      final prompt = promptController.text.trim();
      final alias = aliasController.text.trim();
      if (alias.isNotEmpty && prompt.isNotEmpty) {
        final existingPrompts = await ref.read(sysPromptServiceProvider.future);
        final newPrompts = [
          ...existingPrompts,
          SysPrompt(name: alias, prompt: prompt)
        ];
        await ref
            .read(sysPromptServiceProvider.notifier)
            .setPrompts(newPrompts);
        return true;
      } else {
        return false;
      }
    }

    final focusNode = useFocusNode(onKeyEvent: (node, event) {
      if (event.logicalKey.keyLabel == 'Enter' &&
          !HardwareKeyboard.instance.isShiftPressed) {
        if (event is KeyDownEvent) {
          send();
        }
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    });
    return IconButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 0.7.sw,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 5),
                      child: Text('System Prompt'),
                    ),
                    TextField(
                      minLines: 1,
                      maxLength: 30,
                      controller: aliasController,
                      decoration: const InputDecoration(
                        labelText: 'Alias',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      focusNode: focusNode,
                      minLines: 3,
                      controller: promptController,
                      buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          required maxLength}) {
                        return Text('$currentLength');
                      },
                      decoration: const InputDecoration(
                        labelText: 'Prompt',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 8,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await send();
                            if (result && context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
