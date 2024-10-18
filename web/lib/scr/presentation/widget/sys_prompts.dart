import 'dart:async';

import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/domain/config.dart';
import 'package:buddy_chat/scr/presentation/reusable/dialog.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/model_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SysPromptsDropdown extends HookConsumerWidget {
  const SysPromptsDropdown({this.selectedSysPrompt, super.key});
  final ValueNotifier<SysPrompt?>? selectedSysPrompt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promptsAsync = ref.watch(sysPromptServiceProvider);
    final configAsync = ref.watch(configServiceProvider);
    final errorMsg = useState<String?>(null);
    final currentPrompt = ref.watch(selectedSysPromptProvider);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: promptsAsync.when(
            data: (prompts) {
              final defaultPrompt = configAsync.maybeWhen(
                data: (config) {
                  return SysPrompt(
                    name: 'System Prompt',
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
                hintText: 'Select System prompt',
                inputDecorationTheme: Theme.of(context)
                    .inputDecorationTheme
                    .copyWith(
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        outlineBorder: BorderSide.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        activeIndicatorBorder: BorderSide.none,
                        contentPadding: EdgeInsets.zero,
                        alignLabelWithHint: true,
                        filled: false),
                errorText: errorMsg.value,
                enableFilter: true,
                filterCallback: (entries, filter) {
                  final trimmedFilter = filter.trim().toLowerCase();
                  if (trimmedFilter.isEmpty) {
                    return entries;
                  }
                  final isUniquePrompt = uniquePrompts.any((prompt) =>
                      prompt.name.toLowerCase() == trimmedFilter ||
                      prompt.prompt.toLowerCase() == trimmedFilter);

                  if (isUniquePrompt) {
                    return entries;
                  }

                  return entries
                      .where(
                        (DropdownMenuEntry<SysPrompt> entry) =>
                            entry.label.toLowerCase().contains(trimmedFilter) ||
                            entry.value.prompt
                                .toLowerCase()
                                .contains(trimmedFilter),
                      )
                      .toList();
                },
                searchCallback:
                    (List<DropdownMenuEntry<SysPrompt>> entries, String query) {
                  if (query.isEmpty) {
                    return null;
                  }
                  final lowerCaseQuery = query.toLowerCase();
                  final index = entries.indexWhere(
                      (DropdownMenuEntry<SysPrompt> entry) =>
                          entry.label.toLowerCase().contains(lowerCaseQuery) ||
                          entry.value.prompt
                              .toLowerCase()
                              .contains(lowerCaseQuery));

                  return index != -1 ? index : null;
                },
                initialSelection: currentPrompt ?? defaultPrompt,
                onSelected: (value) {
                  if (value != null) {
                    if (selectedSysPrompt == null) {
                      ref.read(selectedSysPromptProvider.notifier).set(value);
                    } else {
                      selectedSysPrompt?.value = value;
                    }
                    errorMsg.value = null;
                  } else {
                    errorMsg.value = 'Invalid Prompt Name';
                  }
                },
                dropdownMenuEntries: uniquePrompts.map((prompt) {
                  return DropdownMenuEntry<SysPrompt>(
                      label: prompt.name,
                      value: prompt,
                      trailingIcon: Row(
                        children: [
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () async {
                                final result = await showDialog<SysPrompt?>(
                                    context: context,
                                    builder: (context) {
                                      return SetSysPromptDialog(
                                        existingName: prompt.name,
                                        existingPrompt: prompt.prompt,
                                      );
                                    });
                                if (result != null) {
                                  final newPrompts = prompts
                                      .where((e) => e.name != prompt.name)
                                      .toList()
                                    ..add(result);
                                  await ref
                                      .read(sysPromptServiceProvider.notifier)
                                      .setPrompts(newPrompts);
                                }
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () async {
                                final result = await showConfirmationDialog(
                                    context,
                                    message:
                                        'Are you sure you want to delete this prompt?');
                                if (result != null && result) {
                                  final newPrompts = prompts
                                      .where((e) => e.name != prompt.name)
                                      .toList();
                                  await ref
                                      .read(sysPromptServiceProvider.notifier)
                                      .setPrompts(newPrompts);
                                  ref
                                      .read(selectedSysPromptProvider.notifier)
                                      .set(uniquePrompts.last);
                                }
                              },
                              icon: const Icon(Icons.clear)),
                        ],
                      ));
                }).toList(),
              );
            },
            loading: () => const DefaultLoadingWidget(40),
            error: (_, __) => const Text('Error occurred'),
          ),
        ),
        const AddPrompt(),
      ],
    );
  }
}

class SetSysPromptDialog extends HookConsumerWidget {
  const SetSysPromptDialog({
    required this.existingName,
    required this.existingPrompt,
    super.key,
  });
  final String existingName;

  final String existingPrompt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promptController = useTextEditingController(text: existingPrompt);
    final nameController = useTextEditingController(text: existingName);

    final enableModelSelection = useState<bool>(false);
    final errorMsg1 = useState<String?>(null);
    final errorMsg2 = useState<String?>(null);
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
        child: Container(
      padding: const EdgeInsets.all(20),
      width: 0.7 * screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Custom System Prompt',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            TextField(
              buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) {
                return Text('$currentLength');
              },
              minLines: 1,
              decoration: InputDecoration(
                errorText: errorMsg1.value,
                labelText: 'Alias',
              ),
              textInputAction: TextInputAction.next,
              controller: nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) {
                return Text('$currentLength');
              },
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                errorText: errorMsg2.value,
                labelText: 'Prompt',
              ),
              controller: promptController,
              textInputAction: TextInputAction.newline,
            ),
            Row(
              children: [
                Checkbox(
                    value: enableModelSelection.value,
                    onChanged: (value) {
                      enableModelSelection.value = value ?? false;
                    }),
                if (enableModelSelection.value)
                  const SelectOpenRouterModelDropdown()
                else
                  const Text('Use a specified model for this prompt')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      if (nameController.text.trim().isEmpty) {
                        errorMsg1.value = 'Name is required';
                        return;
                      } else if (promptController.text.trim().isEmpty) {
                        errorMsg2.value = 'Prompt is required';
                      } else {
                        errorMsg1.value = null;
                        errorMsg2.value = null;
                      }
                      final selectedModelOverride = await ref
                          .read(selectedOverridingModelProvider.future);
                      if (context.mounted) {
                        Navigator.of(context).pop(SysPrompt(
                            name: nameController.text,
                            prompt: promptController.text,
                            modelId: (enableModelSelection.value &&
                                    selectedModelOverride != null)
                                ? selectedModelOverride.id
                                : null));
                      }
                    },
                    child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class AddPrompt extends ConsumerWidget {
  const AddPrompt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> save(SysPrompt newPrompt) async {
      final existingPrompts = await ref.read(sysPromptServiceProvider.future);
      final newPrompts = {...existingPrompts, newPrompt}.toList();
      await ref.read(sysPromptServiceProvider.notifier).setPrompts(newPrompts);
    }

    return IconButton(
      tooltip: 'Add System Prompt',
      visualDensity: VisualDensity.compact,
      onPressed: () async {
        final result = await showDialog<SysPrompt>(
          context: context,
          builder: (BuildContext context) {
            return const SetSysPromptDialog(
              existingName: '',
              existingPrompt: '',
            );
          },
        );
        if (result != null) {
          unawaited(save(result));
        }
      },
      icon: const Icon(Icons.add),
    );
  }
}
