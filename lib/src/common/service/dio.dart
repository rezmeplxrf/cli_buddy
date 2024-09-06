import 'package:dio/dio.dart';

final dio = Dio()
  ..options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10), 
      sendTimeout: const Duration(seconds: 5),
      persistentConnection: true,
      );
