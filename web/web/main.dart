import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'dart:math';
import 'package:buddy_gui/assets.dart';
import 'package:buddy_gui/domain.dart';
import 'package:collection/collection.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:dio/dio.dart';

void main() {
  init();
}

const String baseUrl = 'http://127.0.0.1:43210';
const String wsUrl = 'ws://127.0.0.1:43210/ws';
final dio = Dio();
final sharedStates = SharedStates();
final sessionService = SessionService();
final configService = ConfigService();
final websocketService = WebSocketService();
final chatService = ChatService();

void init() {
  sharedStates.newChatBtn.onClick
      .listen((_) => sessionService.createNewSession());
  sharedStates.removeAllSessionsBtn.onClick
      .listen((_) => sessionService.removeAllSessions());
  sharedStates.chatInput.onInput
      .listen((_) => chatService.adjustTextareaHeight());
  sharedStates.sendButton.onClick.listen((_) => chatService.sendMessage());
  sharedStates.configBtn.onClick.listen((_) => configService.showConfigPopup());
  sharedStates.chatInput.onKeyDown.listen((event) {
    if (event.keyCode == KeyCode.ENTER && !event.shiftKey) {
      event.preventDefault();
      chatService.sendMessage();
    }
  });

  websocketService.connectWebSocket();
  sessionService.fetchSessions();
  sessionService.createNewSession();
}

class WebSocketService {
  static final _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();
  WebSocket? socket;
  bool isWebSocketConnected = false;
  List<Message> messageQueue = [];

  void connectWebSocket() {
    socket = WebSocket(wsUrl);

    socket?.onOpen.listen((event) {
      print('WebSocket connection established');
      isWebSocketConnected = true;
      updateConnectionStatus;
      processMessageQueue();
    });

    socket?.onClose.listen((event) {
      print('WebSocket connection closed');
      isWebSocketConnected = false;
      updateConnectionStatus;
      Future.delayed(Duration(seconds: 3), () => connectWebSocket());
    });

    socket?.onError.listen((e) {
      print('WebSocket error: $e');
    });

    socket?.onMessage.listen((MessageEvent event) {
      try {
        final data = jsonDecode(event.data as String);
        chatService.handleWebSocketMessage(data);
      } catch (error) {
        print('Error parsing WebSocket message: $error');
      }
    });
  }

  void processMessageQueue() {
    while (messageQueue.isNotEmpty && isWebSocketConnected) {
      final message = messageQueue.removeAt(0);
      socket?.send(jsonEncode(message));
    }
  }

  void sendMessage(Message message) {
    if (isWebSocketConnected) {
      socket?.send(jsonEncode(message));
    } else {
      messageQueue.add(message);
    }
  }

  void updateConnectionStatus() {
    if (isWebSocketConnected) {
      sharedStates.connectionStatus.text = 'Connected';
      sharedStates.connectionStatus.classes.add('bg-green-500');
      sharedStates.connectionStatus.classes.remove('bg-red-500');
    } else {
      sharedStates.connectionStatus.text = 'Disconnected';
      sharedStates.connectionStatus.classes.add('bg-red-500');
      sharedStates.connectionStatus.classes.remove('bg-green-500');
    }
  }
}

class ConfigService {
  static final configService = ConfigService._internal();
  factory ConfigService() => configService;
  ConfigService._internal();
  Configuration? currentConfig;

  Future<Configuration?> fetchConfig() async {
    try {
      final response = await dio.get('$baseUrl/config');
      currentConfig = Configuration.fromJson(response.data);
      return currentConfig;
    } catch (e) {
      print('Error fetching config: $e');
      window.alert('Error fetching config: $e');
      return null;
    }
  }

  void showConfigPopup() async {
    currentConfig = await fetchConfig();
    if (currentConfig == null) {
      print('Configuration not loaded');
      return;
    }

    final popup = DivElement()
      ..className =
          'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4';

    final content = DivElement()
      ..className =
          'bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[90vh] flex flex-col';

    content.setInnerHtml('''
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
  ''', treeSanitizer: NodeTreeSanitizer.trusted);

    popup.append(content);
    document.body?.append(popup);

    // Make checkboxes interactive
    final checkboxes = content.querySelectorAll('div[type="checkboxWrapper"]');
    print('length: ${checkboxes.length}');
    if (checkboxes.isNotEmpty) {
      for (var checkbox in checkboxes) {
        //  output  class: sr-only, attributes: {type: checkbox, id: logprobs, class: sr-only}, id: logprobs
        final input = checkbox.querySelector('input') as InputElement?;
        final toggle = checkbox as DivElement?;
        final dot = toggle?.querySelector('.dot') as DivElement?;
        print('input: $input, toggle: $toggle, dot: $dot');

        // Set initial state
        if (input?.checked ?? false) {
          dot?.style.transform = 'translateX(100%)';
          toggle?.classes.add('bg-green-500');
          toggle?.classes.remove('bg-gray-600');
        }

        // Add click event listener
        toggle?.onClick.listen((_) {
          print('checkbox state: ${input?.checked}');
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
        });
      }
    }

    (content.querySelector('#cancelBtn') as ButtonElement).onClick.listen((_) {
      popup.remove();
    });

    (content.querySelector('#saveBtn') as ButtonElement).onClick.listen((_) {
      saveConfig(content);
      popup.remove();
    });
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

    <div class="gap-6">
    <div class="col-span-full mb-6 md:mb-06">
      <label class="block text-gray-700 text-sm font-bold mb-2" for="$key">
        $label
      </label>
      <textarea class="w-full px-3 py-2 text-gray-700 border rounded-lg focus:outline-none focus:border-blue-500"
                id="$key" rows="4" placeholder="${_getExampleValue(key)}">${value ?? ''}</textarea>
      <p class="text-red-500 text-xs italic" id="${key}Error"></p>
    </div>
    </div>
  ''');
        inputs.writeln(
            '<div class="grid grid-cols-1 md:grid-cols-2 gap-6">'); // Reopen the grid
      } else if (isCheckbox) {
        inputs.writeln('''
      <div class="col-span-2">
        <div class="flex items-center space-x-2">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="$key">
            <div class="text-gray-700 font-medium">$label</div>
          </label>
          
          <div type="checkboxWrapper" class="w-14 h-8 ${value == true ? 'bg-green-500' : 'bg-gray-600'} rounded-full relative cursor-pointer">
            <div class="dot absolute left-1 top-1 bg-white w-6 h-6 rounded-full transition-transform duration-300 ease-in-out" style="transform: ${value == true ? 'translateX(100%)' : 'translateX(0)'}">
             <input type="checkbox" id="$key" class="sr-only" ${value == true ? 'checked' : ''} />
            </div>
        
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
        currentConfig = newConfig;
        print('Configuration saved successfully');
        (content.querySelector('#popup') as DivElement).remove();
      }
    } catch (e) {
      print('Error saving configuration: $e');
      window.alert('Error saving configuration: $e');
    }
  }
}

class SessionService {
  static final _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();
  final sharedStates = SharedStates();
  Future<void> fetchSessions() async {
    try {
      final response = await dio.get('$baseUrl/sessions');

      final data = response.data as List<dynamic>;
      final sessions = data.map((json) => ChatSession.fromJson(json)).toList();

      populateSidebar(sessions);
    } catch (e) {
      print('Error fetching sessions: $e');
    }
  }

  void populateSidebar(List<ChatSession> sessions) {
    sessions.sort((a, b) => b.id - a.id);

    // Create a set of current session IDs for quick lookup
    final currentSessionIds = sessions.map((s) => s.id).toSet();

    // Remove sessions that no longer exist
    sharedStates.sessionList.children.removeWhere((element) {
      final sessionId =
          int.tryParse(element.getAttribute('data-session-id') ?? '');
      return sessionId != null && !currentSessionIds.contains(sessionId);
    });

    // Update existing sessions and add new ones
    for (var i = 0; i < sessions.length; i++) {
      final session = sessions[i];
      final existingElement = sharedStates.sessionList.children
          .firstWhereOrNull((element) =>
              element.getAttribute('data-session-id') == session.id.toString());

      if (existingElement != null) {
        // Update existing session
        updateSessionElement(existingElement as LIElement, session, i);
      } else {
        // Add new session
        final newElement = createSessionElement(session, i);
        if (i == 0) {
          sharedStates.sessionList.children.insert(0, newElement);
        } else {
          final previousElement = sharedStates.sessionList.children
              .firstWhereOrNull((element) =>
                  int.parse(element.getAttribute('data-session-id') ?? '0') <
                  session.id);
          if (previousElement != null) {
            sharedStates.sessionList.children.insert(
                sharedStates.sessionList.children.indexOf(previousElement),
                newElement);
          } else {
            sharedStates.sessionList.children.add(newElement);
          }
        }
      }
    }
  }

  void updateSessionElement(LIElement element, ChatSession session, int index) {
    final firstUserMessage = session.messages.firstWhereOrNull(
      (msg) => msg.role == Role.user,
    );

    final title = firstUserMessage != null
        ? firstUserMessage.content
            .substring(0, min(30, firstUserMessage.content.length))
        : 'New Chat';

    element
      ..setInnerHtml('''
    <div class="session-title font-semibold mb-1">$title${firstUserMessage != null && firstUserMessage.content.length > 30 ? '...' : ''}</div>
    <div class="session-info text-xs text-gray-400"><div>ID: ${session.id}</div>
    <div>Messages: ${session.messages.length}</div><div>Model: ${session.model}</div></div>
  ''', treeSanitizer: NodeTreeSanitizer.trusted)
      ..style.animationDelay = '${index * 0.05}s';
  }

  LIElement createSessionElement(ChatSession session, int index) {
    final li = LIElement()
      ..className =
          'session-item bg-gray-800 hover:bg-gray-700 rounded p-2 cursor-pointer transition-colors duration-200 fade-in'
      ..setAttribute('data-session-id', session.id.toString());

    updateSessionElement(li, session, index);
    li.onClick.listen((_) => selectSession(session.id));

    return li;
  }

  Future<void> selectSession(int sessionId) async {
    try {
      final response = await dio.post(
        '$baseUrl/select-session',
        data: {'sessionId': sessionId},
      );
      final session = ChatSession.fromJson(response.data);
      chatService.displayChat(session);
    } catch (error) {
      print('Error selecting session: $error');
    }
  }

  Future<void> removeAllSessions() async {
    try {
      final response = await dio.post(
        '$baseUrl/remove-all',
      );
      if (response.statusCode == 200) {
        sharedStates.sessionList.children.clear();
        sharedStates.chatContainer.children.clear();
        await createNewSession();
      }
    } catch (e) {
      print('Error removing all sessions: $e');
      window.alert('Error removing all sessions: $e');
    }
  }

  Future<void> createNewSession() async {
    try {
      final response = await dio.post(
        '$baseUrl/new-session',
      );
      final session = ChatSession.fromJson(response.data);
      chatService.displayChat(session);
      sharedStates.isFirstResponse = false;
      fetchSessions();
    } catch (error) {
      print('Error creating new session: $error');
    }
  }
}

class Helper {
  static String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

  static Element createSvgIcon(String svgString) {
    final svgElement =
        Element.html(svgString, treeSanitizer: NodeTreeSanitizer.trusted);
    return svgElement;
  }
}

class SharedStates {
  static final _instance = SharedStates._internal();
  factory SharedStates() => _instance;
  SharedStates._internal();
  final chatContainer = document.querySelector('#chatContainer') as DivElement;
  final chatInput = document.querySelector('#chatInput') as TextAreaElement;
  final newChatBtn = document.querySelector('#newChatBtn') as ButtonElement;
  final removeAllSessionsBtn =
      document.querySelector('#removeAllSessionsBtn') as ButtonElement;
  final sendButton = document.querySelector('#sendButton') as ButtonElement;
  final connectionStatus =
      document.querySelector('#connectionStatus') as DivElement;
  final configBtn = document.querySelector('#configBtn') as ButtonElement;
  final sessionList = document.querySelector('#sessionList') as UListElement;
  var isFirstResponse = false;
  DivElement? currentMessageElement;
  var chunkBuffer = StringBuffer();
  var isFirstChunk = true;
}

class ChatService {
  static final _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  void displayChat(ChatSession session) {
    sharedStates.chatContainer.children.clear();
    for (final message in session.messages) {
      addMessageToChat(message);
    }
  }

  void addMessageToChat(Message message) {
    final div = DivElement()
      ..className =
          'message ${message.role.name}-message bg-white rounded-lg shadow-md p-4 mb-4 fade-in';

    final timestamp = DateTime.fromMillisecondsSinceEpoch(message.timestamp)
        .toLocal()
        .toString();

    div.setInnerHtml('''
    <div class="font-bold text-blue-600 mb-1">${Helper.capitalizeFirstLetter(message.role.name)}</div>
    <div class="text-sm text-gray-500 mb-2">$timestamp</div>
    <div class="prose">${md.markdownToHtml(message.content)}</div>''',
        treeSanitizer: NodeTreeSanitizer.trusted);
    sharedStates.chatContainer
      ..children.add(div)
      ..scrollTop = sharedStates.chatContainer.scrollHeight;
    addCodeBlockButtons(div);
  }

  void startNewMessage() {
    sharedStates.currentMessageElement = DivElement()
      ..className =
          'message assistant-message bg-white rounded-lg shadow-md p-4 mb-4'
      ..setInnerHtml('''
        <div class="font-bold text-blue-600 mb-1">Assistant</div>
        <div class="text-sm text-gray-500 mb-2">${DateTime.now().toLocal()}</div>
        <div class="flex items-center">
            <div class="loading-indicator mr-2"></div>
            <div>Thinking...</div>
        </div>
        <div class="prose"></div>
      ''', treeSanitizer: NodeTreeSanitizer.trusted);
    if (sharedStates.currentMessageElement != null) {
      sharedStates.chatContainer.children
          .add(sharedStates.currentMessageElement!);
      sharedStates.chatContainer.scrollTop =
          sharedStates.chatContainer.scrollHeight;
    }
  }

  void appendChunk(String content) {
    if (sharedStates.currentMessageElement != null) {
      sharedStates.chunkBuffer.write(content);

      final proseDiv = sharedStates.currentMessageElement
          ?.querySelector('.prose') as DivElement?;
      proseDiv?.setInnerHtml(
          md.markdownToHtml(sharedStates.chunkBuffer.toString()),
          validator: NodeValidatorBuilder?.common()..allowHtml5());
      sharedStates.chatContainer.scrollTop =
          sharedStates.chatContainer.scrollHeight;
    }
  }

  void finalizeMessage(Usage? usage) {
    if (sharedStates.currentMessageElement != null) {
      // Update the content with the final message
      final proseDiv = sharedStates.currentMessageElement
          ?.querySelector('.prose') as DivElement?;
      proseDiv?.setInnerHtml(
          md.markdownToHtml(sharedStates.chunkBuffer.toString()),
          validator: NodeValidatorBuilder?.common()..allowHtml5());

      if (usage != null) {
        final usageDiv = DivElement()
          ..className = 'text-sm text-gray-500 mt-2 pt-2 border-t'
          ..setInnerHtml('''
          Prompt Tokens: ${usage.promptTokens ?? 0}, 
          Completion Tokens: ${usage.completionTokens ?? 0}, 
          Total Tokens: ${usage.totalTokens ?? 0},
          Response Time: ${usage.responseTime ?? 0}s
        ''', treeSanitizer: NodeTreeSanitizer.trusted);
        sharedStates.currentMessageElement?.children.add(usageDiv);
      }
      sharedStates.chatContainer.scrollTop =
          sharedStates.chatContainer.scrollHeight;
      if (sharedStates.currentMessageElement != null) {
        addCodeBlockButtons(sharedStates.currentMessageElement!);
      }
    }
    sharedStates.chunkBuffer = StringBuffer();
    sharedStates.currentMessageElement = null;
  }

  void sendMessage() {
    final content = sharedStates.chatInput.value?.trim();
    if (content != null && content.trim().isNotEmpty) {
      final message = Message(
        content: content,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        role: Role.user,
      );

      websocketService.sendMessage(message);
      addMessageToChat(message);
      sharedStates.chatInput.value = '';
      adjustTextareaHeight();
    }
  }

  void adjustTextareaHeight() {
    sharedStates.chatInput.style.height = 'auto';
    sharedStates.chatInput.style.height =
        '${min(sharedStates.chatInput.scrollHeight, 200)}px';
  }

  void addCodeBlockButtons(DivElement div) {
    final codeBlocks = div.querySelectorAll('pre code');
    for (var block in codeBlocks) {
      final buttonsDiv = DivElement()
        ..className = 'absolute top-2 right-2 flex gap-1';

      final copyButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.copyIcon))
        ..onClick.listen((_) {
          window.navigator.clipboard?.writeText(block.text ?? '');
          showSnackBar('Copied to clipboard');
        });

      final fileButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.fileIcon))
        ..onClick.listen((_) async {
          try {
            final response = await HttpRequest.postFormData(
              '$baseUrl/make-file',
              {'code': block.text ?? ''},
            );
            if (response.status == 200) {
              final result = jsonDecode(response.responseText ?? '');
              print('make-file: $result');

              showSnackBar('$result');
            }
          } catch (e) {
            print('Error: $e');
            window.alert('Error making request: $e');
          }
        });

      final runButton = ButtonElement()
        ..className = 'bg-blue-500 text-white py-1 px-2 rounded btn-animate'
        ..append(Helper.createSvgIcon(Svc.runIcon))
        ..onClick.listen((_) async {
          try {
            final response = await HttpRequest.postFormData(
              '$baseUrl/run-code',
              {'code': block.text ?? ''},
            );
            if (response.status == 200) {
              final result = jsonDecode(response.responseText ?? '');
              print('run: $result');

              showSnackBar('$result');
            }
          } catch (e) {
            print('Error: $e');
            window.alert('Error: $e');
          }
        });

      buttonsDiv.children.addAll([copyButton, fileButton, runButton]);
      (block.parent as Element).children.add(buttonsDiv);
    }
  }

  void showSnackBar(String message) {
    final snackbar = DivElement()
      ..text = message
      ..className = 'snackbar';

    document.body?.append(snackbar);

    // Add the "show" class to display the snackbar
    Future.delayed(Duration(milliseconds: 100), () {
      snackbar.className = 'snackbar show';
    });

    // Remove the snackbar after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      snackbar.remove();
    });
  }

  void handleWebSocketMessage(Map<String, dynamic> data) {
    final msgChunk = MessageChunk.fromJson(data);
    switch (msgChunk.type) {
      case ChunkType.start:
        startNewMessage();
        sharedStates.isFirstChunk = true;
        break;
      case ChunkType.chunk:
        appendChunk(msgChunk.content ?? '');
        if (sharedStates.isFirstChunk) {
          sharedStates.isFirstChunk = false;
          // Remove the loading indicator
          final loadingDiv = sharedStates.currentMessageElement
              ?.querySelector('.flex.items-center');
          if (loadingDiv != null) {
            loadingDiv.remove();
          }
        }

        break;
      case ChunkType.end:
        finalizeMessage(msgChunk.usage);
        if (!sharedStates.isFirstResponse) {
          sharedStates.isFirstResponse = true;
          sessionService.fetchSessions();
        }
        break;
      default:
        print('Unknown message type: ${data['type']}');
    }
  }
}
