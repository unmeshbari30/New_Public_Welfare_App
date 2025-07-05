import 'package:rajesh_dada_padvi/models/Files/files_response_model.dart';
import 'package:rajesh_dada_padvi/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "achievements_controller.g.dart";

@riverpod
class AchievementsController extends _$AchievementsController{

@override
FutureOr<AchievementsState> build() async{
  AchievementsState newState = AchievementsState();
  var data = await ref.read(repositoryProvider.future);
  newState.achievementsResponse = data.getAchievements() ;
  return newState;

}





}

class AchievementsState{

  Future<FileResponseModel?>? achievementsResponse; 

}