import 'dart:convert';

import 'package:buddy_chat/scr/application/config.dart';
import 'package:buddy_chat/scr/constant/global.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:buddy_chat/scr/presentation/reusable/error.dart';
import 'package:buddy_chat/scr/presentation/reusable/loading.dart';
import 'package:buddy_chat/scr/presentation/widget/model_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfigureButton extends ConsumerWidget {
  const ConfigureButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(children: [
        Expanded(
            child: FilledButton(
                onPressed: () {
                  context.push('/config');
                },
                child: const Text('Configuration')))
      ]),
    );
  }
}

class ConfigurationPage extends HookConsumerWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(configServiceProvider);

    final showAdvancedSettings = useState(false);
    final showPromptSettings = useState(false);
    return configAsync.when(
      data: (config) {
        final selectedModel = useState<ORModel?>(null);
        final openrouterAPIkeycontroler =
            useTextEditingController(text: config?.openrouterKey);

        final ollamaEndpointController =
            useTextEditingController(text: config?.ollamaEndpoint);
        final ollamaDefaultModelController =
            useTextEditingController(text: config?.ollamaDefaultModel);

        final saveOnlineController =
            useState<bool>(config?.saveOnline ?? false);
        final apiProviderController =
            useState<APIProvider?>(config?.apiProvider);
        final localEndpointController =
            useTextEditingController(text: config?.localEndpoint);

        final saveSessionController = useState(config?.saveSession);
        final maxMessagesController =
            useState<double?>(config?.maxMessages.toDouble());

        final temperatureController = useState<double?>(config?.temperature);
        final maxTokensController =
            useState<double?>(config?.maxTokens?.toDouble());
        final topPController = useState<double?>(config?.topP?.toDouble());
        final topKController = useState<double?>(config?.topK?.toDouble());
        final frequencyPenaltyController =
            useState<double?>(config?.frequencyPenalty);
        final presencePenaltyController =
            useState<double?>(config?.presencePenalty);
        final repetitionPenaltyController =
            useState<double?>(config?.repetitionPenalty);
        final minPController = useState<double?>(config?.minP);
        final topAController = useState<double?>(config?.topA);
        final seedController =
            useTextEditingController(text: config?.seed?.toString());
        final logitBiasController =
            useTextEditingController(text: config?.logitBias?.toString());
        final logprobsController = useState<bool>(config?.logprobs ?? false);
        final topLogprobsController =
            useState<double?>(config?.topLogprobs?.toDouble());
        final responseFormatController =
            useState<bool>(config?.responseFormat != null);
        final stopController =
            useTextEditingController(text: config?.stop?.toString());
        final cmdPromptController =
            useTextEditingController(text: config?.cmdPrompt);
        final explainPromptController =
            useTextEditingController(text: config?.explainPrompt);
        final codePromptController =
            useTextEditingController(text: config?.codePrompt);
        final chatPromptController =
            useTextEditingController(text: config?.chatPrompt);
        final validatePromptController =
            useTextEditingController(text: config?.validatePrompt);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Configuration'),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPadding(
                        child: ListTile(
                      title: const Text('API Provider'),
                      trailing: DropdownButton<APIProvider>(
                          value: apiProviderController.value,
                          items: APIProvider.values
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name)))
                              .toList(),
                          onChanged: (value) {
                            apiProviderController.value = value;
                          }),
                    )),
                    if (apiProviderController.value != APIProvider.ollama)
                      _buildPadding(
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text('Openrouter ApiKey'),
                              const Spacer(),
                              SizedBox(
                                width: 460,
                                child: TextField(
                                  controller: openrouterAPIkeycontroler,
                                  decoration: const InputDecoration(
                                    labelText: 'ApiKey',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    _buildPadding(
                      child: ListTile(
                        title: Row(
                          children: [
                            const Text('Local Endpoint'),
                            const Spacer(),
                            SizedBox(
                              width: 460,
                              child: TextField(
                                controller: localEndpointController,
                                decoration: const InputDecoration(
                                  labelText: 'Local Endpoint',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (apiProviderController.value == APIProvider.ollama)
                      _buildPadding(
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text('Ollama Endpoint'),
                              const Spacer(),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: ollamaEndpointController,
                                  decoration: const InputDecoration(
                                    labelText: 'Ollama Endpoint',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (apiProviderController.value == APIProvider.ollama)
                      _buildPadding(
                        child: const ListTile(
                          title: Row(
                            children: [
                              Text('Default Model'),
                              Spacer(),
                              // TODO: ollama default model dropdown menu,
                            ],
                          ),
                        ),
                      )
                    else
                      _buildPadding(
                        child: ListTile(
                          title: Row(
                            children: [
                              const Text('Default Model'),
                              const Spacer(),
                              SelectOpenRouterModelDropdown(
                                  selectedModelForConfiguration: selectedModel),
                            ],
                          ),
                        ),
                      ),
                    _buildPadding(
                      child: SwitchListTile(
                        title: const Text('Save Session'),
                        value: saveSessionController.value ?? true,
                        onChanged: (value) {
                          saveSessionController.value = value;
                        },
                      ),
                    ),
                    _buildPadding(
                      child: SwitchListTile(
                        title: const Text('Save Online'),
                        value: saveOnlineController.value,
                        onChanged: (value) {
                          saveOnlineController.value = value;
                        },
                      ),
                    ),
                    _buildPadding(
                      child: SwitchListTile(
                        title: const Text('Json Format'),
                        value: responseFormatController.value,
                        onChanged: (value) {
                          logprobsController.value = value;
                        },
                      ),
                    ),
                  
                    _buildPadding(
                      child: _BuildMaxMessageSlider(
                        value: maxMessagesController.value ?? 20,
                        onChanged: (value) =>
                            maxMessagesController.value = value,
                      ),
                    ),
                    _buildPadding(
                      child: _BuildNullableSlider(
                        label: 'Temperature',
                        value: temperatureController.value,
                        min: 0,
                        max: 2,
                        onChanged: (value) =>
                            temperatureController.value = value,
                      ),
                    ),
                    _buildPadding(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  showAdvancedSettings.value =
                                      !showAdvancedSettings.value;
                                },
                                child: const Text('Show Advanced Options')),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      alignment: Alignment.bottomLeft,
                      duration: const Duration(milliseconds: 200),
                      child: (showAdvancedSettings.value)
                          ? Column(children: [
                              _buildPadding(
                                child: _BuildMaxCompletiontokenSlider(
                                  value: maxTokensController.value,
                                  onChanged: (value) =>
                                      maxTokensController.value = value,
                                  selectedModel: selectedModel,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Top P',
                                  value: topPController.value,
                                  min: 0,
                                  max: 1,
                                  onChanged: (value) =>
                                      topPController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Top K',
                                  value: topKController.value,
                                  min: 0,
                                  max: 100,
                                  onChanged: (value) =>
                                      topKController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Frequency Penalty',
                                  value: frequencyPenaltyController.value,
                                  min: -2,
                                  max: 2,
                                  onChanged: (value) =>
                                      frequencyPenaltyController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Presence Penalty',
                                  value: presencePenaltyController.value,
                                  min: -2,
                                  max: 2,
                                  onChanged: (value) =>
                                      presencePenaltyController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Repetition Penalty',
                                  value: repetitionPenaltyController.value,
                                  min: 0,
                                  max: 2,
                                  onChanged: (value) =>
                                      repetitionPenaltyController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Min P',
                                  value: minPController.value,
                                  min: 0,
                                  max: 1,
                                  onChanged: (value) =>
                                      minPController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableSlider(
                                  label: 'Top A',
                                  value: topAController.value,
                                  min: 0,
                                  max: 1,
                                  onChanged: (value) =>
                                      topAController.value = value,
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableTextField(
                                  controller: seedController,
                                  label: 'Seed',
                                ),
                              ),
                              _buildPadding(
                                child: _BuildNullableTextField(
                                  controller: logitBiasController,
                                  label: 'Logit Bias',
                                ),
                              ),
                              _buildPadding(
                                child: SwitchListTile(
                                  title: const Text('Logprobs'),
                                  value: logprobsController.value,
                                  onChanged: (value) {
                                    logprobsController.value = value;
                                  },
                                ),
                              ),
                              if (logprobsController.value)
                                _buildPadding(
                                  child: _BuildNullableSlider(
                                    label: 'Top Logprobs',
                                    value: topLogprobsController.value,
                                    min: 0,
                                    max: 20,
                                    onChanged: (value) =>
                                        topLogprobsController.value = value,
                                  ),
                                ),
                              _buildPadding(
                                child: _BuildNullableTextField(
                                  controller: stopController,
                                  label: 'Stop',
                                ),
                              ),
                            ])
                          : const SizedBox(),
                    ),
                    _buildPadding(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  showPromptSettings.value =
                                      !showPromptSettings.value;
                                },
                                child: const Text('Edit Core Prompts')),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 200),
                      child: (showPromptSettings.value)
                          ? Column(
                              children: [
                                _buildPadding(
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: 6,
                                    textInputAction: TextInputAction.newline,
                                    controller: cmdPromptController,
                                    buildCounter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        required maxLength}) {
                                      return Text('$currentLength');
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Cmd Prompt',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                _buildPadding(
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: 6,
                                    textInputAction: TextInputAction.newline,
                                    controller: explainPromptController,
                                    buildCounter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        required maxLength}) {
                                      return Text('$currentLength');
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Explain Prompt',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                _buildPadding(
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: 6,
                                    controller: codePromptController,
                                    textInputAction: TextInputAction.newline,
                                    buildCounter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        required maxLength}) {
                                      return Text('$currentLength');
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Code Prompt',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                _buildPadding(
                                  child: TextField(
                                    textInputAction: TextInputAction.newline,
                                    controller: chatPromptController,
                                    minLines: 1,
                                    maxLines: 6,
                                    buildCounter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        required maxLength}) {
                                      return Text('$currentLength');
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Chat Prompt',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                _buildPadding(
                                  child: TextField(
                                    textInputAction: TextInputAction.newline,
                                    controller: validatePromptController,
                                    minLines: 1,
                                    maxLines: 6,
                                    buildCounter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        required maxLength}) {
                                      return Text('$currentLength');
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Validate Prompt',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                final updatedConfig = Configuration(
                                  openrouterKey: openrouterAPIkeycontroler.text,
                                  ollamaDefaultModel:
                                      ollamaDefaultModelController.text,
                                  ollamaEndpoint: ollamaEndpointController.text,
                                  saveOnline: saveOnlineController.value,
                                  apiProvider: apiProviderController.value ??
                                      config?.apiProvider ??
                                      APIProvider.openrouter,
                             
                                  localEndpoint: localEndpointController.text,
                                  saveSession: saveSessionController.value ??
                                      config?.saveSession ??
                                      true,
                                  maxMessages:
                                      maxMessagesController.value?.toInt() ??
                                          config?.maxMessages ??
                                          20,
                                  openrouterDefaultModel:
                                      selectedModel.value?.id ??
                                          config?.openrouterDefaultModel ??
                                          fallbackModel,
                                  temperature:
                                      temperatureController.value ?? 0.3,
                                  maxTokens: maxTokensController.value?.toInt(),
                                  topP: topPController.value?.toInt(),
                                  topK: topKController.value?.toInt(),
                                  frequencyPenalty:
                                      frequencyPenaltyController.value,
                                  presencePenalty:
                                      presencePenaltyController.value,
                                  repetitionPenalty:
                                      repetitionPenaltyController.value,
                                  minP: minPController.value,
                                  topA: topAController.value,
                                  seed: int.tryParse(seedController.text),
                                  logitBias: logitBiasController.text.isNotEmpty
                                      ? Map<String, int>.from(
                                          jsonDecode(logitBiasController.text)
                                              as Map<String, dynamic>)
                                      : null,
                                  logprobs: logprobsController.value,
                                  topLogprobs:
                                      topLogprobsController.value?.toInt(),
                                  responseFormat: responseFormatController.value
                                      ? {'type': 'json_object'}
                                      : null,
                                  stop: stopController.text.isNotEmpty
                                      ? List<dynamic>.from(
                                          jsonDecode(stopController.text)
                                              as List<dynamic>)
                                      : null,
                                  cmdPrompt: cmdPromptController.text,
                                  explainPrompt: explainPromptController.text,
                                  codePrompt: codePromptController.text,
                                  chatPrompt: chatPromptController.text,
                                  validatePrompt: validatePromptController.text,
                                );

                                await ref
                                    .read(configServiceProvider.notifier)
                                    .setConfig(updatedConfig);
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Save',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (e, st) => DefaultErrorWidget(
        error: e.toString(),
        stackTrace: st,
        retry: () => ref.invalidate(configServiceProvider),
      ),
      loading: () => const DefaultLoadingWidget(150),
    );
  }

  Widget _buildPadding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: child,
    );
  }
}

class _BuildNullableTextField extends HookWidget {
  const _BuildNullableTextField(
      {required this.controller, required this.label});
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(controller.text.trim().isNotEmpty);

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked.value,
              onChanged: (checked) {
                isChecked.value = checked ?? false;
              },
            ),
            Text(label),
          ],
        ),
        if (isChecked.value)
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
      ],
    );
  }
}

class _BuildMaxCompletiontokenSlider extends HookWidget {
  const _BuildMaxCompletiontokenSlider({
    required this.value,
    required this.onChanged,
    required this.selectedModel,
  });
  final double? value;
  final ValueChanged<double?> onChanged;

  final ValueNotifier<ORModel?> selectedModel;

  @override
  Widget build(BuildContext context) {
    final max = useState<int>(10000);
    final isChecked = useState(value != null);

    useEffect(() {
      if (selectedModel.value != null) {
        max.value = selectedModel.value?.topProvider?.maxCompletionTokens ??
            selectedModel.value?.contextLength ??
            10000;
      }
      return null;
    }, [selectedModel.value]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked.value,
              onChanged: (checked) {
                isChecked.value = checked ?? false;
                if (!isChecked.value) {
                  onChanged(null);
                }
              },
            ),
            Text(
                'Max Completion Tokens ${value != null ? '(${value?.toInt()})' : ''}'),
          ],
        ),
        if (isChecked.value)
          Slider(
            value: value ?? 1,
            min: 1,
            max: max.value.toDouble(),
            divisions: (max.value.toDouble() - 1) ~/ 0.1,
            label: value?.toStringAsFixed(2),
            onChanged: onChanged,
          ),
      ],
    );
  }
}

class _BuildNullableSlider extends HookWidget {
  const _BuildNullableSlider(
      {required this.label,
      required this.value,
      required this.min,
      required this.max,
      required this.onChanged});
  final double? value;
  final ValueChanged<double?> onChanged;
  final double min;
  final double max;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(value != null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked.value,
              onChanged: (checked) {
                isChecked.value = checked ?? false;

                if (!isChecked.value) {
                  onChanged(null);
                }
              },
            ),
            Text(
                '$label ${value != null ? '(${value?.toStringAsFixed(1)})' : ''}'),
          ],
        ),
        if (isChecked.value)
          Slider(
            value: value ?? min,
            min: min,
            max: max,
            divisions: (max - min) ~/ 0.1,
            label: value?.toStringAsFixed(2),
            onChanged: onChanged,
          ),
      ],
    );
  }
}

class _BuildMaxMessageSlider extends StatelessWidget {
  const _BuildMaxMessageSlider({required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Max Messages (${value.toInt()})'),
        Slider(
          value: value,
          min: 1,
          max: 1000,
          divisions: (1000 - 1) ~/ 0.1,
          label: '${value.toInt()}',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
