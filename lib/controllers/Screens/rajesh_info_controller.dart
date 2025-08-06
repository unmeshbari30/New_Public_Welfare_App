import 'package:rajesh_dada_padvi/models/Files/mla_info_model.dart';
import 'package:rajesh_dada_padvi/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "rajesh_info_controller.g.dart";

@riverpod
class RajeshInfoController extends _$RajeshInfoController {
  @override
  FutureOr<RajeshInfoState> build() async {
    ref.keepAlive();
    RajeshInfoState newState = RajeshInfoState();
    var repository = await ref.read(repositoryProvider.future);
    newState.mlaInfoModel = repository.getMlaInfo();
    return newState;
  }
}

class RajeshInfoState {
  Future<MlaInfoModel?>? mlaInfoModel;
}
