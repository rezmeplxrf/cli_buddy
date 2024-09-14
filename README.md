---

# cli_buddy

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
<a title="Made with Fluent Design" href="https://github.com/bdlukaa/fluent_ui">
  <img
    src="https://img.shields.io/badge/fluent-design-blue?style=flat-square&color=gray&labelColor=0078D7"
  />
</a>

---

## Call Any LLM from Your Terminal
 - Lightweight and Fast
 - Supports over 100+ LLMs (GPT, Claude, Cohere, LLama 3, Gemini, Mistral, DeekSeek, and many other LLMs including all Open Source LLMs)
 - Use your own API key ([OpenRouter](https://openrouter.ai/))
 - Local LLM Support using Ollama
 - Complete privacy - not a single analytic data is collected
 - Works on Linux, macOS, and Windows 
 - Can also view GUI similar to many AI chat app if you want
  

## Demo

![Demo](demo.gif)

## Features
1. **Code Generation**: Ask for code and directly generate (or overwrite) a file with it.
   - Also available: option to copy to clipboard, ask for explanation, or chat with the context.
2. **Shell Command Execution**: Ask for a shell command and directly execute it in your terminal.
   - Also available: option to copy to clipboard or ask for explanation.
3. **Continuous Chat**: Chat with AI continuously in your terminal.
4. **Session Management**: Save chat history in JSON format locally and load it when starting a new session using `-s <session_id>`.
   - By default, saving chat history is disabled.
5. **OpenRouter APIs**: Even though it's made as a CLI tool, this package can also be used for any Dart/Flutter project to use OpenRouter APIs. This package exposes OpenRouter APIs and Models. Simply declare `final openRouter = OpenRouterService();` and use it in your project. such as `final result = await openRouter.invoke(session: ChatSession());`
6. **GUI**: Want to see GUI? Just run `buddy open` to open the GUI.

## Getting Started 🚀

### Installation

1. Installing as a package
   - Simply run:
   ```sh
   dart pub global activate cli_buddy
   ```

2. Installing Dart SDK
   - Install Dart SDK following the official [Install Dart SDK](https://dart.dev/get-dart) document.
   - Check if Dart sdk is installed by running `dart --version`
   - Run `dart pub global activate cli_buddy`

3. Using binary
   - Download binary for your OS in /release (currently I only have MacOS so tested on MacOS but technically should work on all OS)
   - If your system is Unix (MacOS, Linux) run `sudo chmod +x <path/to/binary>`
   - Test if it runs: `./<path/to/binary> --help`
   - Set alias according to your system (e.g. `alias buddy='./<path/to/binary>'`)


### Get API Key from [OpenRouter](https://openrouter.ai/)
[OpenRouter](https://openrouter.ai/) provides unified LLM APIs at (almost) the same cost as the original LLM API provider.
**Note: OpenRouter provides some free AI models with limitations. You can try out for free using those models without payments**
**Note: I am not affliated with OpenRouter and I do not receive any benefits from them by any means.**


### Add API Key
```sh
buddy set --or-api-key <your openrouter key>
```


### Example `buddy.config`
```json
{
  "api_provider": "openrouter",
  "localEndpoint": "localhost:43210",
  "save_session": true,
  "save_online": false,
  "local_web": true,
  "max_messages": 20,
  "openrouter_default_model": "openai/gpt-4o",
  "ollama_default_model": null,
  "ollamaEndpoint": "localhost:11434",
  "openrouter_key": null,
  "temperature": 0.3,
  "max_tokens": null,
  "top_p": null,
  "top_k": null,
  "frequency_penalty": null,
  "presence_penalty": null,
  "repetition_penalty": null,
  "min_p": null,
  "top_a": null,
  "seed": null,
  "logit_bias": null,
  "logprobs": false,
  "top_logprobs": null,
  "response_format": null,
  "stop": null,
  "cmd_prompt": "If there is a lack of details, provide most logical solution.\nEnsure the output is a valid shell command.\nIf multiple steps required try to combine them together in one command.\nProvide only plain text without Markdown formatting.\nDo not provide markdown formatting such as ```",
  "explain_prompt": "Provide short and concise explanation of your previous response about command or code.\nProvide only plain text without Markdown formatting.\nDo not provide markdown formatting such as ```",
  "code_prompt": "Provide only code as output without any description.\nProvide only code in plain text format without Markdown formatting.\nDo not include symbols such as ``` or ```python.\nIf there is a lack of details, provide most logical solution.\nYou are not allowed to ask for more details.\nFor example if the prompt is \"Hello world Python\", you should return \"print('Hello world')\".\n",
  "chat_prompt": "You are a Flutter/Dart developer. Don't be verbose in your response but focus on solving problem or coding. As for state management, use hooks_flutter and riverpod_hook packages.",
  "validate_prompt": "Your job is to verify if the provided code by the previous AI assistant is valid.\nProvide concise response unless asked for more details."
}
```

## Basic Usage

```sh
# Shell command
$ buddy shell how can I update homebrew

# If you want to use special characters, use quotes
$ buddy shell "how can I update homebrew?"

# Coding
$ buddy code "Generate a random number between 1 and 10 in Dart"

# Chat
$ buddy chat "Tell me about the SSH protocol"

# Show Graphical User Interface
$ buddy open

# Show CLI version
$ buddy --version

# Show usage help
$ buddy --help
```

## Info Command

The `info` command allows you to search for AI models in OpenRouter. Below are the available options and flags:

- `-q, --query`: Search for AI models by name, provider, or model type (e.g., text, image).
- `-o, --order`: Specify the order in which the results should be displayed. Allowed values: `name`, `context`, `prompt`, `completion`, `image`.
- `-f, --config`: Display the current configuration file. If it does not exist, create a new one.
- `-c, --credits`: Display the credits available in OpenRouter.
- `-l, --list`: List all AI models available in OpenRouter.
- `-p, --parameters`: Query the parameters of a specific AI model.
- `-s, --sessions`: (-s list) List saved chat histories in the default session folder or (-s <session_id>) view a specific chat history.

### Example Usage

```sh
# Search for AI models by name
$ buddy info -q "claude"

# Search for AI models by provider
$ buddy info -q "openai"

# List all available AI models
$ buddy info -l

# Display the current configuration
$ buddy info -f

# Display the credits used for your OpenRouter account
$ buddy info -c

# Query the parameters of a specific AI model
$ buddy info -p "model_id"

# List saved chat histories
$ buddy info -s list

# View a specific chat history by session ID
$ buddy info -s "session_id"
```

## Markdown format

* As for 'code', 'suggest', 'explain' mode, by default system prompt will discourage using markdown format, will remove it in the final output (for 'code copy/shell run/copy').
* As for 'chat' mode, markdown is allowed, but to use it, you need to pass '-m --markdown' flag. However, if markdown flag is used, real time streaming message will be disabled. Also implementing markdown in console is hard. Feel free to make a merge request if you did it.


## Roadmap

- Writing code to a file then executing
- Indexing specified path and file extension for Rag
- Support for RAG (Retrieval-Augmented Generation)
- Automated comments for all speficied file path/file extension
- Automated improving all specified file path/file extension
- Support for Google Vertex AI API


## Contributions

Contributions are welcome! Feel free to open issues or submit pull requests.



---

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
