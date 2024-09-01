import 'package:cli_buddy/src/common/service/config.dart';
import 'package:mason_logger/mason_logger.dart';

void main() async {
  final logger = Logger();
  print(await ConfigService.loadDefaultModel(logger));
  print(await ConfigService.loadOpenrouterKey(logger));
  print(await ConfigService.loadDefaultParameters(logger));
}
