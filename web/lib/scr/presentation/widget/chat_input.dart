import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/application/send_message.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/constant/helper.dart';
import 'package:buddy_chat/scr/data/websocket.dart';
import 'package:buddy_chat/scr/presentation/widget/autocomplete_setting_dialog.dart';
import 'package:buddy_chat/scr/presentation/widget/editor.dart';
import 'package:buddy_chat/scr/presentation/widget/model_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuildInputWidget extends HookConsumerWidget {
  const BuildInputWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editController = useTextEditingController();
    final modelDropdownPopKey = GlobalKey();
    final isAIResponding = ref.watch(isAIRespondingProvider);
    final characterLength = useState<int>(0);
    final autoCompleteConfigAsync = ref.watch(autoCompleteControllerProvider);
    final autoCompleteConfig = useState<bool>(false);
    final selectedOverrideModel = ref.watch(selectedOverridingModelProvider);
    autoCompleteConfigAsync.whenData((config) {
      if (config?.enabled != null) {
        autoCompleteConfig.value = config!.enabled;
      }
    });

    void send() {
      if (editController.text.trim().isNotEmpty) {
        ref
            .read(sendMessageServiceProvider)
            .sendMessage(text: editController.text);
        editController
          ..clear()
          ..clearComposing();
      }
    }
 final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.08 * screenWidth, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: Row(
                children: [
                  _buildIconButton(
                    tooltip: 'Number of characters',
                    icon: Text(characterLength.value.toString()),
                    onPressed: () {},
                  ),
                  _buildIconButton(
                    tooltip: 'Attach File',
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {},
                  ),
                  _buildIconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () {},
                    tooltip: 'Attach Link',
                  ),
                  _buildIconButton(
                    key: modelDropdownPopKey,
                    icon: const Icon(Icons.change_circle_outlined),
                    onPressed: () {
                      final renderBox = modelDropdownPopKey.currentContext
                          ?.findRenderObject() as RenderBox?;
                      if (renderBox == null) return;
                      final position = renderBox
                          .localToGlobal(renderBox.size.center(Offset.zero));
                      final size = renderBox.size;

                      showMenu(
                          menuPadding: EdgeInsets.zero,
                          context: context,
                          position: RelativeRect.fromLTRB(
                            position.dx,
                            position.dy - 80,
                            position.dx + size.width,
                            position.dy,
                          ),
                          items: [
                            const PopupMenuItem<void>(
                              padding: EdgeInsets.zero,
                              enabled: false,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SelectOpenRouterModelDropdown()),
                            )
                          ]);
                    },
                    tooltip: (selectedOverrideModel.valueOrNull != null)
                        ? Helper.capitalizeFirstLetter(
                            selectedOverrideModel.value!.name)
                        : 'Select AI Model',
                  ),
                  Checkbox(
                      value: autoCompleteConfig.value,
                      onChanged: (value) async {
                        if (value == null) return;
                        Global.talker.debug('value: $value');
                        final existingConfig = await ref
                            .read(autoCompleteControllerProvider.future);
                        final updatedConfig = existingConfig?.copyWith(
                          enabled: value,
                        );
                        await ref
                            .read(autoCompleteControllerProvider.notifier)
                            .set(updatedConfig);
                        autoCompleteConfig.value = value;
                      }),
                  if (autoCompleteConfig.value)
                    _buildIconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        showDialog<void>(
                            context: context,
                            builder: (context) {
                              return const AutoCompleteSettingDialog();
                            });
                      },
                      tooltip: 'Auto Complete Settings',
                    ),
                ],
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Editor(
                    debounceTime: 800,
                    onEnter: send,
                    textController: editController,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 30,
                  icon: Icon(
                    isAIResponding ? Icons.stop : Icons.clear_outlined,
                  ),
                  onPressed: () {
                    if (isAIResponding) {
                      ref.read(webSocketRespositoryProvider.notifier).cancel();
                    } else {
                      editController
                        ..text = ''
                        ..clearComposing();
                    }
                  },
                ),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 30,
                  icon: const Icon(Icons.send),
                  onPressed: send,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required VoidCallback? onPressed,
    required Widget icon,
    required String tooltip,
    Key? key,
  }) {
    return IconButton(
      key: key,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.all(15),
      iconSize: 20,
      tooltip: tooltip,
      icon: icon,
      onPressed: onPressed,
    );
  }
}
