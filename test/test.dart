import 'dart:convert';

const sample =
    '{id: gen-4vrApoycbKn7HjgEmdIzfcjP0Gqq, model: openai/gpt-4o-mini-2024-07-18, object: chat.completion.chunk, created: 1725213306, choices: [{index: 0, delta: {role: assistant, content: examples, finish_reason: null, logprobs: {content: [{token: examples, logprob: -0.19688235, bytes: [32, 101, 120, 97, 109, 112, 108, 101, 115], top_logprobs: [{token: examples, logprob: -0.19688235, bytes: [32, 101, 120, 97, 109, 112, 108, 101, 115]}]}], refusal: null}}], system_fingerprint: fp_f33667828e}';

void main() {
  final decoded = jsonDecode(sample);
 print(decoded);
  // final encoded = jsonEncode(decoded);
  // print(encoded);
}
