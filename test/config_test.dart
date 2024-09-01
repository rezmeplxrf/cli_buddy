import 'package:cli_buddy/src/common/service/config.dart';
import 'package:mason_logger/mason_logger.dart';

void main() async {
  final logger = Logger();
  print(await ConfigService.readDefaultModel(logger));
  print(await ConfigService.readOpenrouterKey(logger));
  print(await ConfigService.readDefaultParameters(logger));
}
