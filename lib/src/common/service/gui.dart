import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

class GUIService {
  factory GUIService() => _instance;
  GUIService._internal();
  static final GUIService _instance = GUIService._internal();

  static void setLogger(Logger? logger) => _logger = logger;

  static Logger? _logger;
  static HttpServer? _server;
  Future<void> start() async {
    // Create a handler for serving static files from the 'public' directory
    final staticHandler =
        createStaticHandler('public', defaultDocument: 'index.html');

    // Create a pipeline with the static handler
    final handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(staticHandler);

    // Start the server
    _server = await io.serve(handler, 'localhost', 43210);
    _logger
        ?.info('Serving at http://${_server?.address.host}:${_server?.port}');
  }

  Future<void> stop() async {
    if (_server != null) {
      await _server!.close(force: true);
      _logger?.info('Server stopped');
    }
  }
}
