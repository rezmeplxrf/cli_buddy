import 'package:dotenv/dotenv.dart';

String? openrouterKey;

class SecretService {
  static String? readOpenrouterKey() {
    final env = DotEnv(includePlatformEnvironment: true)..load(['secret.env']);
    final keyExists = env.isDefined('openrouter_key');
    String? key;
    if (keyExists) {
      key = env['openrouter_key'];
    } else {
      throw Exception('openrouter_key not found in .env file');
    }
    env.clear();
    return key;
  }
}
