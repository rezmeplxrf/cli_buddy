
import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'dart:math';
import 'package:buddy_gui/domain/domain.dart';
import 'package:buddy_gui/service/global.dart';
import 'package:buddy_gui/domain/config.dart';

class ConfigService {
  static final configService = ConfigService._internal();
  factory ConfigService() => configService;
  ConfigService._internal();
  Configuration? currentConfig;
  List<StreamSubscription?> subscriptions = [];

  Future<Configuration?> fetchConfig() async {
    try {
      final response = await dio.get('$baseUrl/config');
      final fetchedConfig = Configuration.fromJson(response.data);
      return fetchedConfig;
    } catch (e) {
      print('Error fetching config: $e');
      window.alert('Error fetching config: $e');
      return null;
    }
  }

  void showConfigPopup() async {
    final result = await fetchConfig();
    if (result != null) {
      currentConfig = result;
    }

    final popup = DivElement()..setInnerHtml('''
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
<div class="bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[90vh] flex flex-col">
    <div class="p-6 border-b">
      <h2 class="text-2xl font-bold text-gray-800">Edit Configuration</h2>
    </div>
    <div class="p-6 overflow-y-auto flex-grow">
      <form id="configForm">
        ${_createConfigInputs()}
      </form>
    </div>
    <div class="p-6 border-t flex justify-end space-x-4">
      <button id="cancelBtn" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 transition-colors duration-200">Cancel</button>
      <button id="saveBtn" class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors duration-200">Save</button>
    </div>
  </div>
  ''', treeSanitizer: NodeTreeSanitizer.trusted);

    document.body?.append(popup);

    final checkboxes = popup.querySelectorAll('div[type="checkboxWrapper"]');
    if (checkboxes.isNotEmpty) {
      for (var checkbox in checkboxes) {
        final input = checkbox.querySelector('input') as InputElement?;
        final toggle = checkbox as DivElement?;
        final dot = toggle?.querySelector('.dot') as DivElement?;

        // Set initial state
        if (input?.checked ?? false) {
          dot?.style.transform = 'translateX(100%)';
          toggle?.classes.add('bg-green-500');
          toggle?.classes.remove('bg-gray-600');
        }

        // Add click event listener
       subscriptions.add(toggle?.onClick.listen((_) {
          input?.checked = !(input.checked ?? false);
          if (input?.checked ?? false) {
            dot?.style.transform = 'translateX(100%)';
            toggle.classes.add('bg-green-500');
            toggle.classes.remove('bg-gray-600');
          } else {
            dot?.style.transform = 'translateX(0)';
            toggle.classes.remove('bg-green-500');
            toggle.classes.add('bg-gray-600');
          }
        }));
      }
    }
subscriptions.addAll([
    (popup.querySelector('#cancelBtn') as ButtonElement).onClick.listen((_) {
      popup.remove();
    }),

    (popup.querySelector('#saveBtn') as ButtonElement).onClick.listen((_) {
      saveConfig(popup);
      popup.remove();
    })
  ]);
  }

  String _createConfigInputs() {
    final inputs = StringBuffer();
    inputs.writeln('<div class="grid grid-cols-1 md:grid-cols-2 gap-6">');

    final config = currentConfig;
    if (config == null) return '';

    void addInput(String key, String label, String type, dynamic value,
        {bool isTextArea = false,
        bool isCheckbox = false,
        double? min,
        double? max,
        int? minInt,
        int? maxInt}) {
      if (isTextArea) {
        inputs.writeln('</div>'); // Close the grid for prompt fields
        inputs.writeln('''

    <div class="col-span-full mb-6 md:mb-06">
      <label class="block text-gray-700 text-sm font-bold mb-2" for="$key">
        $label
      </label>
      <textarea class="w-full px-3 py-2 text-gray-700 border rounded-lg focus:outline-none focus:border-blue-500"
                id="$key" rows="4" placeholder="${_getExampleValue(key)}">${value ?? ''}</textarea>
      <p class="text-red-500 text-xs italic" id="${key}Error"></p>
    </div>

  ''');
        inputs.writeln(
            '<div class="grid grid-cols-1 md:grid-cols-2 gap-6">'); // Reopen the grid
      } else if (isCheckbox) {
        inputs.writeln('''
<div class="col-span-2 flex items-center py-4 border-t border-b border-gray-200">
  <label class="flex-grow text-gray-700 text-sm font-bold" for="$key">
    <div class="text-gray-700 font-medium">$label</div>
  </label>
  <div type="checkboxWrapper" class="w-14 h-8 ${value == true ? 'bg-green-500' : 'bg-gray-600'} rounded-full relative cursor-pointer flex items-center">
    <div class="dot absolute left-1 top-1 bg-white w-6 h-6 rounded-full transition-transform duration-300 ease-in-out" style="transform: ${value == true ? 'translateX(100%)' : 'translateX(0)'}">
      <input type="checkbox" id="$key" class="sr-only" ${value == true ? 'checked' : ''} />
    </div>
  </div>
</div>
    ''');
      } else {
        final isInt = value is int;
        final step = isInt ? 'step="1"' : 'step="0.1"';
        final minAttr = min != null ? 'min="$min"' : '';
        final maxAttr = max != null ? 'max="$max"' : '';
        final minIntAttr = minInt != null ? 'min="$minInt"' : '';
        final maxIntAttr = maxInt != null ? 'max="$maxInt"' : '';
        inputs.writeln('''
      <div class="col-span-1">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="$key">
          $label
        </label>
        <input class="w-full px-3 py-2 text-gray-700 border rounded-lg focus:outline-none focus:border-blue-500"
               id="$key" type="$type" value="${value?.toString() ?? ''}" $step $minAttr $maxAttr $minIntAttr $maxIntAttr placeholder="${_getExampleValue(key)}">
        <p class="text-red-500 text-xs italic" id="${key}Error"></p>
      </div>
    ''');
      }
    }

    // Add your input fields here
    addInput(
        'secret_env_path', 'Secret Env Path', 'text', config.secretEnvPath);
    addInput('max_messages', 'Max Messages', 'number', config.maxMessages,
        minInt: 1);
    addInput('default_model', 'Default Model', 'text', config.defaultModel);
    addInput('temperature', 'Temperature', 'number', config.temperature,
        min: 0.0, max: 2.0);
    addInput('max_tokens', 'Max Tokens', 'number', config.maxTokens, minInt: 1);
    addInput('top_p', 'Top P', 'number', config.topP, min: 0.0, max: 1.0);
    addInput('top_k', 'Top K', 'number', config.topK, minInt: 0);
    addInput('frequency_penalty', 'Frequency Penalty', 'number',
        config.frequencyPenalty,
        min: -2.0, max: 2.0);
    addInput('presence_penalty', 'Presence Penalty', 'number',
        config.presencePenalty,
        min: -2.0, max: 2.0);
    addInput('repetition_penalty', 'Repetition Penalty', 'number',
        config.repetitionPenalty,
        min: 0.0, max: 2.0);
    addInput('min_p', 'Min P', 'number', config.minP, min: 0.0, max: 1.0);
    addInput('top_a', 'Top A', 'number', config.topA, min: 0.0, max: 1.0);
    addInput('seed', 'Seed', 'number', config.seed);
    addInput('logit_bias', 'Logit Bias', 'text', jsonEncode(config.logitBias));
    addInput('top_logprobs', 'Top Logprobs', 'number', config.topLogprobs,
        minInt: 0, maxInt: 20);
    addInput('stop', 'Stop', 'text', config.stop?.join(', '));
    addInput('logprobs', 'Logprobs', 'checkbox', config.logprobs,
        isCheckbox: true);
    addInput('save_session', 'Save Session', 'checkbox', config.saveSession,
        isCheckbox: true);
    addInput('response_format', 'Response Format', 'checkbox',
        config.responseFormat != null,
        isCheckbox: true);
    addInput('cmd_prompt', 'Cmd Prompt', 'text', config.cmdPrompt,
        isTextArea: true);
    addInput('explain_prompt', 'Explain Prompt', 'text', config.explainPrompt,
        isTextArea: true);
    addInput('code_prompt', 'Code Prompt', 'text', config.codePrompt,
        isTextArea: true);
    addInput('chat_prompt', 'Chat Prompt', 'text', config.chatPrompt,
        isTextArea: true);

    inputs.writeln('</div>'); // Close the final grid
    return inputs.toString();
  }

  String _getExampleValue(String key) {
    switch (key) {
      case 'secret_env_path':
        return '/path/to/secret.env';
      case 'save_session':
        return 'true';
      case 'max_messages':
        return '20';
      case 'default_model':
        return 'openai/gpt-4o';
      case 'temperature':
        return '0.3';
      case 'max_tokens':
        return '2000';
      case 'top_p':
        return '0.9';
      case 'top_k':
        return '40';
      case 'frequency_penalty':
        return '0.5';
      case 'presence_penalty':
        return '0.5';
      case 'repetition_penalty':
        return '1.0';
      case 'min_p':
        return '0.1';
      case 'top_a':
        return '0.5';
      case 'seed':
        return '42';
      case 'logit_bias':
        return 'json encoded map: tokenId - integer';
      case 'logprobs':
        return '5';
      case 'top_logprobs':
        return '5';
      case 'response_format':
        return 'true';
      case 'stop':
        return '213, 235, 52, 2134';
      case 'cmd_prompt':
        return 'How should AI output shell command';
      case 'explain_prompt':
        return 'How should AI explain to the previous code/cmd';
      case 'code_prompt':
        return 'How should AI output code';
      case 'chat_prompt':
        return 'How should AI respond to';
      default:
        return 'Enter value';
    }
  }

  void saveConfig(DivElement content) async {
    final form = content.querySelector('#configForm') as FormElement;
    var formData = Map<String, dynamic>.fromEntries(
      currentConfig?.toJson().keys.map((key) {
            final element = form.querySelector('#$key');
            if (element is InputElement) {
              if (element.type == 'checkbox') {
                if (key == 'response_format') {
                  return MapEntry(key,
                      element.checked == true ? {'type': 'json_object'} : null);
                }
                return MapEntry(key, element.checked);
              } else if (element.type == 'number') {
                return MapEntry(
                    key,
                    element.value?.trim().isEmpty == true
                        ? null
                        : num.tryParse(element.value!));
              } else {
                return MapEntry(
                    key,
                    element.value?.trim().isEmpty == true
                        ? null
                        : element.value);
              }
            } else if (element is TextAreaElement) {
              return MapEntry(key,
                  element.value?.trim().isEmpty == true ? null : element.value);
            }
            return MapEntry(key, null);
          }) ??
          [],
    );

    // Parse special fields
    if (formData['temperature'] != null && formData['temperature'] < 0) {
      formData['temperature'] = 0;
    }
    final maxMessages = formData['max_messages'] as int?;
    if (formData['max_messages'] != null) {
      formData['max_messages'] = max<int>(0, maxMessages ?? 0);
    }

    final stop = formData['stop'] as String?;

    formData['stop'] = stop?.isNotEmpty == true
        ? stop?.split(',').map((e) => e.trim()).toList()
        : null;
    final logitBiasString = formData['logit_bias']?.toString().trim();
    if (logitBiasString?.isNotEmpty == true) {
      try {
        final correctedLogitBiasString = logitBiasString!.replaceAll("'", '"');
        final parsedMap = jsonDecode(correctedLogitBiasString) as Map;
        formData['logit_bias'] = parsedMap.map((key, value) {
          return MapEntry(key.toString(), int.parse(value.toString()));
        });
      } catch (e) {
        print('Error parsing logit_bias: $e');
        formData['logit_bias'] = null;
      }
    } else {
      formData['logit_bias'] = null;
    }

    // Handle nullable int fields
    for (var field in [
      'max_tokens',
      'top_p',
      'top_k',
      'seed',
      'logprobs',
      'top_logprobs'
    ]) {
      if (formData[field] is String) {
        formData[field] = int.tryParse(formData[field]);
      }
    }

    // Handle nullable double fields
    for (var field in [
      'frequency_penalty',
      'presence_penalty',
      'repetition_penalty',
      'min_p',
      'top_a'
    ]) {
      if (formData[field] is String) {
        formData[field] = double.tryParse(formData[field]);
      }
    }
    try {
      final newConfig = Configuration.fromJson(formData);
      // check if the new config is different from the current config
      if (newConfig == currentConfig) {
        print('Configuration unchanged');
        return;
      }

      final result =
          await dio.post('$baseUrl/config', data: newConfig.toJson());
      if (result.statusCode == 200) {
        final serverConfig = Configuration.fromJson(result.data);
        currentConfig = serverConfig;
        print('Configuration saved successfully');
      }
    } catch (e) {
      print('Error saving configuration: $e');
      window.alert('Error saving configuration: $e');
    }
  }
}