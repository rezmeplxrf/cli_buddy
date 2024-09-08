import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

 String baseUrl = 'http://127.0.0.1:43210';
 String wsUrl = 'ws://127.0.0.1:43210/ws';
final dio = Dio()
  ..options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 5),
    persistentConnection: true,
  )
  ..interceptors.add(TalkerDioLogger());
final talker = Talker();
