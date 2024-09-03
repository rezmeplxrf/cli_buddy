import 'package:cli_buddy/src/common/service/open_router.dart';

void main() async {
  final result = await OpenRouterService.checkCredits();

  print(result.getOrThrow());
}
