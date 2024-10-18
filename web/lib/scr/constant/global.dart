import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

String baseUrl = 'http://localhost:43210';
String wsUrl = 'ws://localhost:43210/ws';

class Global {

  
static final dio = Dio()
  ..options = BaseOptions(
    receiveDataWhenStatusError: true,
    sendTimeout: const Duration(seconds: 5),
    persistentConnection: true,
  )
  ..interceptors.add(TalkerDioLogger());
static final talker = Talker();
}


const fallbackModel = 'openai/gpt-4o';
const errorMessagePart =
    'Please refer to this [Documentation](https://openrouter.ai/docs/errors) for more details.';
