
import 'package:buddy_chat/scr/data/open_router.dart';
import 'package:buddy_chat/scr/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query.g.dart';

@riverpod
class ModelInfoService extends _$ModelInfoService {
  @override
  FutureOr<List<ORModel>> build() async {
    try {
      final sessions = await getModels();
      return sessions;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return [];
    }
  }

  Future<List<ORModel>> getModels() async {
    state = const AsyncLoading();
    final sessions = await ref.read(listOpenRouterModelsProvider.future);
    return sessions;
  }
}

@riverpod
class ParameterQueryService extends _$ParameterQueryService {
  @override
  FutureOr<ParameterInfo?> build({required String modelId}) async {
    try {
      final info = await getParameters(modelId: modelId);
      return info;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    }
  }

  Future<ParameterInfo?> getParameters({required String modelId}) async {
    final parameterInfo =
        await ref.read(queryParametersProvider(model: modelId).future);
    return parameterInfo;
  }
}
