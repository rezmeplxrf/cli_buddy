import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/application/controller.dart';
import 'package:buddy_chat/scr/application/query.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/model_info.dart';
import 'package:buddy_chat/scr/presentation/widget/model_table.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectOpenRouterModelDropdown extends HookConsumerWidget {
  const SelectOpenRouterModelDropdown({
    this.selectedModelForConfiguration,
    this.initialSelectOverride,
    super.key,
  });
  final ValueNotifier<ORModel?>? selectedModelForConfiguration;
  final String? initialSelectOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAync = ref.watch(modelInfoServiceProvider);
    final selectedModelOverride = ref.watch(selectedOverridingModelProvider);
    final configAsync = ref.watch(configServiceProvider);
    final errorMsg = useState<String?>(null);
    final controller = useTextEditingController();

    return modelsAync.when(
      data: (models) {
        final defaultModelStr = configAsync.maybeWhen(
          data: (config) {
            final currentProvider = config?.apiProvider;

            switch (currentProvider) {
              case APIProvider.openrouter:
                return config?.openrouterDefaultModel;

              case APIProvider.ollama:
                return config?.ollamaDefaultModel;

              default:
                break;
            }
            return null;
          },
          orElse: () => fallbackModel,
        );

        final uniqueModels = models.toSet();
        final defaultORModel = (initialSelectOverride == null)
            ? uniqueModels
                .firstWhereOrNull((model) => model.id == defaultModelStr)
            : uniqueModels
                .firstWhereOrNull((model) => model.id == initialSelectOverride);

        final initialSelection = selectedModelForConfiguration?.value ??
            defaultORModel ??
            selectedModelOverride.value;
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    useRootNavigator: true,
                    showDragHandle: true,
                    isScrollControlled: true,
                    constraints: BoxConstraints(minWidth: screenWidth),
                    context: context,
                    builder: (context) => const ModelInfoTable(),
                  );
                },
                icon: const Icon(Icons.info_outline)),
            IconButton(
                onPressed: () {
                  ref.read(selectedOverridingModelProvider.notifier).set(null);
                  controller.clear();
                },
                icon: const Icon(Icons.clear_outlined)),
            DropdownMenu<ORModel?>(
              hintText: 'Select model',
              menuHeight: 0.4 * screenHeight,
              errorText: errorMsg.value,
              enableFilter: true,
              filterCallback: (entries, filter) {
                final trimmedFilter = filter.trim().toLowerCase();
                if (trimmedFilter.isEmpty) {
                  return entries;
                }
                final isUniqueModel = uniqueModels.any(
                    (model) => model.id.trim().toLowerCase() == trimmedFilter);

                if (isUniqueModel) {
                  return entries;
                }

                return entries
                    .where((DropdownMenuEntry<ORModel?> entry) =>
                        entry.label.toLowerCase().contains(trimmedFilter) ||
                        (entry.value != null &&
                            entry.value!.id
                                .toLowerCase()
                                .contains(trimmedFilter)))
                    .toList();
              },
              searchCallback:
                  (List<DropdownMenuEntry<ORModel?>> entries, String query) {
                if (query.isEmpty) {
                  return null;
                }
                final lowerCaseQuery = query.toLowerCase();
                final index = entries.indexWhere(
                    (DropdownMenuEntry<ORModel?> entry) =>
                        entry.label.toLowerCase().contains(lowerCaseQuery) ||
                        (entry.value != null &&
                            entry.value!.id
                                .toLowerCase()
                                .contains(lowerCaseQuery)));

                return index != -1 ? index : null;
              },
              initialSelection: initialSelection,
              controller: controller,
              onSelected: (value) async {
                if (value != null) {
                  errorMsg.value = null;
                  if (selectedModelForConfiguration != null) {
                    selectedModelForConfiguration!.value = value;
                  } else if (initialSelectOverride != null) {
                    final existingConfig =
                        await ref.read(autoCompleteControllerProvider.future);

                    final updatedConfig = existingConfig?.copyWith(
                      modelId:  value.id,
                        );
                       await ref
                        .read(autoCompleteControllerProvider.notifier)
                        .set(updatedConfig);

                
                  } else {
                    // if this dropdown widget is used for model override
                    ref
                        .read(selectedOverridingModelProvider.notifier)
                        .set(value);
                  }
                } else {
                  errorMsg.value = 'Invalid Model Id';
                }
              },
              dropdownMenuEntries: uniqueModels.map((model) {
                return DropdownMenuEntry<ORModel>(
                    label: model.name,
                    value: model,
                    trailingIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (context) {
                                return ModelInfoDialog(model: model);
                              });
                        },
                        icon: const Icon(Icons.info_outline)));
              }).toList(),
            ),
          ],
        );
      },
      loading: () => const DefaultLoadingWidget(40),
      error: (_, __) => const Text('Error occurred'),
    );
  }
}
