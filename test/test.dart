import 'package:cli_buddy/src/common/service/open_router.dart';
import 'package:result_dart/functions.dart';

void main() async {
  final result = await OpenRouterService.checkCredits();

  print(result.getOrThrow());
}
