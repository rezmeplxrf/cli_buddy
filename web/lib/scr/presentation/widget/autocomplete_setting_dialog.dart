import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/domain/config.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/model_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AutoCompleteSettingDialog extends HookConsumerWidget {
  const AutoCompleteSettingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiProvider = useState<APIProvider?>(APIProvider.openrouter);

    final existingConfigAsync = ref.watch(autoCompleteControllerProvider);
    final promptController = useTextEditingController();

    existingConfigAsync.whenData((existingConfig) {
      promptController.text =
          existingConfig?.sysSrompt ?? defaultAutoCompletePrompt;
    });

    return existingConfigAsync.when(
      loading: () => const DefaultLoadingWidget(30),
      error: (error, stackTrace) => Text(error.toString()),
      data: (existingConfig) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Auto Complete Settings'),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('API Provider'),
                    DropdownMenu<APIProvider>(
                      enableSearch: false,
                      initialSelection:
                          existingConfig?.apiProvider ?? apiProvider.value,
                      onSelected: (value) =>
                          apiProvider.value = value ?? APIProvider.openrouter,
                      dropdownMenuEntries: APIProvider.values
                          .map((e) => DropdownMenuEntry<APIProvider>(
                                value: e,
                                label: e.name,
                              ))
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('Model'),
                    SelectOpenRouterModelDropdown(
                      initialSelectOverride: existingConfig?.modelId ?? '',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  minLines: 1,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Prompt',
                  ),
                  controller: promptController,
                )
              ]),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  final updatedConfig = existingConfig?.copyWith(
                      apiProvider:
                          apiProvider.value ?? existingConfig.apiProvider,
                      sysSrompt: (promptController.text.trim().isNotEmpty)
                          ? promptController.text
                          : existingConfig.sysSrompt,
                      enabled: true);
                  Global.talker.debug('updatedConfig: $updatedConfig');

                  ref
                      .read(autoCompleteControllerProvider.notifier)
                      .set(updatedConfig);
                  Navigator.of(context).pop();
                },
                child: const Text('Save')),
          ],
        );
      },
    );
  }
}
