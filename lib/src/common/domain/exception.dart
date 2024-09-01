import 'dart:convert';

class CustomException implements Exception {
  CustomException(
      {required this.message, required this.stack, this.verboseMessage});

  String message;
  Map<String, dynamic>? verboseMessage;
  String stack;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'verboseMessage': verboseMessage,
      'stack': stack,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
