import 'dart:convert';

class CustomException implements Exception {
  CustomException({required this.message, required this.stack, this.details});

  String message;
  Map<String, dynamic>? details;
  String stack;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'details': details,
      'stack': stack,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
