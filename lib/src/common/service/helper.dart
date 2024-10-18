import '../../../cli_buddy.dart';

class Helper {
  factory Helper() => _instance;
  Helper._internal();
  static final Helper _instance = Helper._internal();

  static Map<String, dynamic> toAPICompatibleJson(Message message) {
    return {
      'role': message.role.name,
      'content': message.content,
    };
  }
}
