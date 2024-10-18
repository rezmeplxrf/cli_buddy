import 'package:buddy_chat/scr/application/query.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';


class ModelInfoDialog extends ConsumerWidget {
  const ModelInfoDialog({
    required this.model,
    super.key,
  });

  final ORModel model;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterInfoAsync =
        ref.watch(parameterQueryServiceProvider(modelId: model.id));
final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      child: Stack(
        children: [
          Container(
            width: 0.7 * screenWidth,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  MarkdownBlock(
                    data: model.description,
                  ),
                  AnimatedSize(
                    alignment: Alignment.bottomLeft,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: parameterInfoAsync.when(
                        data: (ParameterInfo? info) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                _buildSectionTitle(
                                    context, 'Supported Parameters'),
                                Text(
                                    '${info?.supportedParameters?.join(', ')}'),
                                const SizedBox(height: 16),
                                if (info != null) ...[
                                  _buildSectionTitle(
                                      context, 'Default Parameters'),
                                  Wrap(
                                    spacing: 4,
                                    children: [
                                      for (final widget
                                          in _formatNonNullFields(info))
                                        widget
                                    ],
                                  )
                                ],
                              ],
                            ),
                        error: (e, st) => const SizedBox(),
                        loading: () => const DefaultLoadingWidget(20)),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          _buildSectionTitle(context, 'Pricing'),
                          _buildSectionTitle(context, 'Context'),
                        ]),
                        TableRow(children: [
                          _buildPricingInfo(model.pricing),
                          _buildTopProviderInfo(model.topProvider),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 16),
                          SizedBox(height: 16),
                        ]),
                        TableRow(children: [
                          _buildSectionTitle(context, 'Architecture'),
                          _buildSectionTitle(context, 'Per Request Limits'),
                        ]),
                        TableRow(children: [
                          _buildArchitectureInfo(model.architecture),
                          _buildPerRequestLimitsInfo(model.perRequestLimits),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  List<Text> _formatNonNullFields(ParameterInfo info) {
    final fields = <String, dynamic>{
      'frequency_penalty_p10': info.frequencyPenaltyP10,
      'frequency_penalty_p50': info.frequencyPenaltyP50,
      'frequency_penalty_p90': info.frequencyPenaltyP90,
      'min_p_p10': info.minPP10,
      'min_p_p50': info.minPP50,
      'min_p_p90': info.minPP90,
      'presence_penalty_p10': info.presencePenaltyP10,
      'presence_penalty_p50': info.presencePenaltyP50,
      'presence_penalty_p90': info.presencePenaltyP90,
      'repetition_penalty_p10': info.repetitionPenaltyP10,
      'repetition_penalty_p50': info.repetitionPenaltyP50,
      'repetition_penalty_p90': info.repetitionPenaltyP90,
      'temperature_p10': info.temperatureP10,
      'temperature_50': info.temperatureP50,
      'temperature_p90': info.temperatureP90,
      'top_a_p10': info.topAP10,
      'top_a_p50': info.topAP50,
      'top_a_p90': info.topAP90,
      'top_k_p10': info.topKP10,
      'top_k_p50': info.topKP50,
      'top_k_p90': info.topKP90,
      'top_p_p10': info.topPP10,
      'top_p_p50': info.topPP50,
      'top_p_p90': info.topPP90,
    };

    // return List of Text widget' each field as its own Text widget
    return fields.entries
        .where((entry) => entry.value != null)
        .map((entry) => Text('${entry.key}: ${entry.value}'))
        .toList();
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildPricingInfo(Pricing? pricing) {
    if (pricing == null) return const Text('No pricing information available.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Prompt: ${pricing.prompt != null ? '${pricing.prompt} USD' : 'N/A'}'),
        Text(
            'Completion: ${pricing.completion != null ? '${pricing.completion} USD' : 'N/A'}'),
        Text(
            'Image: ${pricing.image != null && double.tryParse(pricing.image ?? '0')! > 0 ? '${pricing.image} USD' : 'N/A'}'),
        Text(
            'Request: ${pricing.request != null && double.tryParse(pricing.request ?? '0')! > 0 ? '${pricing.request} USD' : 'N/A'}'),
      ],
    );
  }

  Widget _buildArchitectureInfo(Architecture? architecture) {
    if (architecture == null) {
      return const Text('No architecture information available.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Modality: ${architecture.modality ?? 'N/A'}'),
        Text('Tokenizer: ${architecture.tokenizer ?? 'N/A'}'),
        Text('Instruct Type: ${architecture.instructType ?? 'N/A'}'),
      ],
    );
  }

  Widget _buildTopProviderInfo(TopProvider? topProvider) {
    if (topProvider == null) {
      return const Text('No top provider information available.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Context Length: ${topProvider.contextLength ?? 'N/A'}'),
        Text(
            'Max Completion Tokens: ${topProvider.maxCompletionTokens ?? 'N/A'}'),
        Text('Is Moderated: ${topProvider.isModerated ?? 'N/A'}'),
      ],
    );
  }

  Widget _buildPerRequestLimitsInfo(PerRequestLimits? perRequestLimits) {
    if (perRequestLimits == null) {
      return const Text('No per request limits information available.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prompt Tokens: ${perRequestLimits.promptTokens ?? 'N/A'}'),
        Text(
            'Completion Tokens: ${perRequestLimits.completionTokens ?? 'N/A'}'),
      ],
    );
  }
}
