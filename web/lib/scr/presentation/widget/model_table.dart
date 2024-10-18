import 'package:buddy_chat/scr/application/query.dart';
import 'package:buddy_chat/scr/constant/helper.dart';
import 'package:buddy_chat/scr/domain/open_router.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/model_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SortField {
  name,
  contextLength,
  pricingPrompt,
  pricingCompletion,
  pricingImage,
  pricingRequest,
  architectureModality,
  architectureTokenizer,
  architectureInstructType,
  topProviderContextLength,
  topProviderMaxCompletionTokens,
  topProviderIsModerated,
  perRequestLimitsPromptTokens,
  perRequestLimitsCompletionTokens
}

class ModelInfoTable extends HookConsumerWidget {
  const ModelInfoTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAsync = ref.watch(modelInfoServiceProvider);
    final sortField = useState<SortField>(SortField.name);
    final sortAscending = useState<bool>(true);
    final verticalScrollController = useScrollController();
    final isAtTop = useState(false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final position = isAtTop.value
              ? 0.0
              : verticalScrollController.position.maxScrollExtent;
          verticalScrollController
              .animateTo(
                position,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              )
              .then((_) => isAtTop.value = !isAtTop.value);
        },
        child: Icon(!isAtTop.value ? Icons.arrow_downward : Icons.arrow_upward),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: modelsAsync.when(
          data: (List<ORModel> models) {
            final sortedModels = [...models]..sort((a, b) {
                int compare;
                switch (sortField.value) {
                  case SortField.name:
                    compare = a.name.compareTo(b.name);
                  case SortField.contextLength:
                    compare =
                        (a.contextLength ?? 0).compareTo(b.contextLength ?? 0);

                  case SortField.pricingPrompt:
                    compare =
                        a.pricing?.prompt?.compareTo(b.pricing?.prompt ?? '') ??
                            0;
                  case SortField.pricingCompletion:
                    compare = a.pricing?.completion
                            ?.compareTo(b.pricing?.completion ?? '') ??
                        0;
                  case SortField.pricingImage:
                    compare =
                        a.pricing?.image?.compareTo(b.pricing?.image ?? '') ??
                            0;
                  case SortField.pricingRequest:
                    compare = a.pricing?.request
                            ?.compareTo(b.pricing?.request ?? '') ??
                        0;
                  case SortField.architectureModality:
                    compare = a.architecture?.modality
                            ?.compareTo(b.architecture?.modality ?? '') ??
                        0;
                  case SortField.architectureTokenizer:
                    compare = a.architecture?.tokenizer
                            ?.compareTo(b.architecture?.tokenizer ?? '') ??
                        0;
                  case SortField.architectureInstructType:
                    compare = a.architecture?.instructType
                            ?.compareTo(b.architecture?.instructType ?? '') ??
                        0;
                  case SortField.topProviderContextLength:
                    compare = (a.topProvider?.contextLength ?? 0)
                        .compareTo(b.topProvider?.contextLength ?? 0);
                  case SortField.topProviderMaxCompletionTokens:
                    compare = (a.topProvider?.maxCompletionTokens ?? 0)
                        .compareTo(b.topProvider?.maxCompletionTokens ?? 0);
                  case SortField.topProviderIsModerated:
                    compare = a.topProvider?.isModerated ?? false ? 1 : 0;
                  case SortField.perRequestLimitsPromptTokens:
                    compare = a.perRequestLimits?.promptTokens?.compareTo(
                            b.perRequestLimits?.promptTokens ?? '') ??
                        0;
                  case SortField.perRequestLimitsCompletionTokens:
                    compare = a.perRequestLimits?.completionTokens?.compareTo(
                            b.perRequestLimits?.completionTokens ?? '') ??
                        0;
                }
                return sortAscending.value ? compare : -compare;
              });

            return SingleChildScrollView(
              controller: verticalScrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: const Text('Name'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.name;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Prompt'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.pricingPrompt;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Completion'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.pricingCompletion;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Image'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.pricingImage;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Request'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.pricingRequest;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Modality'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.architectureModality;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Tokenizer'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.architectureTokenizer;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Instruct Type'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.architectureInstructType;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Context Length'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.topProviderContextLength;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Max Completion Tokens'),
                      onSort: (columnIndex, _) {
                        sortField.value =
                            SortField.topProviderMaxCompletionTokens;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Prompt Tokens\nRequest Limit'),
                      onSort: (columnIndex, _) {
                        sortField.value =
                            SortField.perRequestLimitsPromptTokens;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Completion Tokens\nRequest Limit'),
                      onSort: (columnIndex, _) {
                        sortField.value =
                            SortField.perRequestLimitsCompletionTokens;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                    DataColumn(
                      label: const Text('Is Moderated'),
                      onSort: (columnIndex, _) {
                        sortField.value = SortField.topProviderIsModerated;
                        sortAscending.value = !sortAscending.value;
                      },
                    ),
                  ],
                  rows: sortedModels.map((model) {
                    return DataRow(cells: [
                      DataCell(
                        Text(model.name),
                        onTap: () {
                          showDialog<void>(
                              context: context,
                              builder: (context) {
                                return ModelInfoDialog(model: model);
                              });
                        },
                      ),
                      DataCell(
                          Text(Helper.pricingFormat(model.pricing?.prompt))),
                      DataCell(Text(
                          Helper.pricingFormat(model.pricing?.completion))),
                      DataCell(Text((model.pricing?.image != null &&
                              double.tryParse(model.pricing!.image ?? '0.0')! >
                                  0 &&
                              !model.name.toLowerCase().contains('free'))
                          ? Helper.pricingFormat(model.pricing?.image)
                          : 'N/A')),
                      DataCell(Text((model.pricing?.request != null &&
                              double.tryParse(
                                      model.pricing!.request ?? '0.0')! >
                                  0)
                          ? Helper.pricingFormat(model.pricing?.request)
                          : 'N/A')),
                      DataCell(Text(model.architecture?.modality ?? 'N/A')),
                      DataCell(Text(model.architecture?.tokenizer ?? 'N/A')),
                      DataCell(Text(model.architecture?.instructType ?? 'N/A')),
                      DataCell(Text(
                          model.topProvider?.contextLength?.toString() ??
                              'N/A')),
                      DataCell(Text(
                          model.topProvider?.maxCompletionTokens?.toString() ??
                              'N/A')),
                      DataCell(
                          Text(model.perRequestLimits?.promptTokens ?? 'N/A')),
                      DataCell(Text(
                          model.perRequestLimits?.completionTokens ?? 'N/A')),
                      DataCell(Text(
                          model.topProvider?.isModerated?.toString() ?? 'N/A')),
                    ]);
                  }).toList(),
                ),
              ),
            );
          },
          loading: () => const DefaultLoadingWidget(40),
          error: (_, __) => const Text('Error occurred'),
        ),
      ),
    );
  }
}
