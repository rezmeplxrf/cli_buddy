import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:buddy_chat/scr/presentation/widget/model_dropdown.dart';
import 'package:buddy_chat/scr/presentation/widget/sys_prompts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ValidateDialog extends HookConsumerWidget {
  const ValidateDialog({
    required this.currentSession,
    required this.targetMessage,
    super.key,
  });
  final ChatSession currentSession;
  final Message targetMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPrompt = ref.watch(selectedSysPromptProvider);
    final selectedSysPrompt = useState<SysPrompt?>(currentPrompt);

    final useCustomModel = useState<bool>(false);
    final usePredefinedSysPrompt = useState<bool>(false);
    final customPrompt = ref.watch(customValidationPromptProvider);
    final customPromptController = useTextEditingController();
    final configAsync = ref.watch(configServiceProvider);
    final labelTextStyle = Theme.of(context)
        .textTheme
        .labelMedium
        ?.copyWith(color: Theme.of(context).colorScheme.primary);

    useEffect(() {
      if (customPrompt != null) {
        customPromptController.text = customPrompt;
      } else {
        configAsync.whenData((config) {
          if (config?.validatePrompt != null) {
            customPromptController.text = config!.validatePrompt!;
          }
        });
      }
      return;
    }, [customPrompt]);

    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(20),
      title: const Center(child: Text('Validation Prompt')),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () async {
              final selectedModelOverride =
                  await ref.read(selectedOverridingModelProvider.future);
              if (selectedModelOverride == null && useCustomModel.value) {
                await EasyLoading.showError(
                    'Needs to select a model from dropdown menu if the checkbox for the model is selected');
                return;
              } else if (selectedSysPrompt.value == null &&
                  usePredefinedSysPrompt.value) {
                await EasyLoading.showError(
                    'Needs to select a system prompt from dropdown menu if the checkbox for the system prompt is selected');
                return;
              } else if (!usePredefinedSysPrompt.value &&
                  customPromptController.text.trim().isEmpty) {
                await EasyLoading.showError(
                    'Needs to enter a custom prompt if the checkbox for the custom prompt is not selected');
                return;
              }

              final request = ValidateRequest(
                  targetMessage: targetMessage,
                  sysPrompt: Message(
                      role: Role.system,
                      content: (!usePredefinedSysPrompt.value)
                          ? customPromptController.text
                          : selectedSysPrompt.value!.prompt,
                      timestamp: DateTime.now().millisecondsSinceEpoch),
                  currentSession: currentSession,
                  modelId: (useCustomModel.value)
                      ? selectedModelOverride?.id ?? currentSession.modelId
                      : currentSession.modelId);
              if (customPromptController.text.trim().isNotEmpty &&
                  !usePredefinedSysPrompt.value) {
                await ref
                    .read(customValidationPromptProvider.notifier)
                    .set(customPromptController.text);
              }
              if (context.mounted) {
                Navigator.of(context).pop(request);
              }
            },
            child: const Text('Validate')),
      ],
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Model to use for this validation',
                  style: labelTextStyle),
            ),
            Row(
              children: [
                Checkbox(
                    value: useCustomModel.value,
                    onChanged: (checked) {
                      useCustomModel.value = checked ?? false;
                    }),
                if (useCustomModel.value)
                  const SelectOpenRouterModelDropdown()
                else
                  const Text('Check to use different model')
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('System Prompt to use for this validation',
                  style: labelTextStyle),
            ),
            Row(
              children: [
                Checkbox(
                    value: usePredefinedSysPrompt.value,
                    onChanged: (checked) {
                      usePredefinedSysPrompt.value = checked ?? false;
                    }),
                if (usePredefinedSysPrompt.value)
                  SysPromptsDropdown(
                    selectedSysPrompt: selectedSysPrompt,
                  )
                else
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      controller: customPromptController,
                      minLines: 1,
                      maxLines: 6,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
