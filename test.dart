import 'dart:io';

void main() async {
  var server = await HttpServer.bind('localhost', 8080);
  print('Listening on localhost:${server.port}');

  await for (var request in server) {
    request.response.headers.add('Content-Type', 'text/event-stream');
    request.headers.add('Cache-Control', 'no-cache');
    request.response.headers.add('Connection', 'keep-alive');

    for (var i = 0; i < 10; i++) {
      request.response.write('data: Message $i\n\n');
      await Future.delayed(Duration(seconds: 1));
    }

    await request.response.close();
  }
}