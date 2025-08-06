import 'package:rajesh_dada_padvi/models/complaint_response_model.dart';
import 'package:rajesh_dada_padvi/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grievance_controller.g.dart';

@riverpod
class GrievanceController extends _$GrievanceController {
  @override
  FutureOr<GrievanceState> build() async {
    GrievanceState newState = GrievanceState();
    var repository = await ref.read(repositoryProvider.future);
    newState.complaintsList = await repository.getComplaints();
    // newState.

    return newState;
  }

  Future<bool> deleteComplaintsById({required String id}) async {
    try {
      var repository = await ref.read(repositoryProvider.future);
       await repository.deleteComplaintById(id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future refreshComplaintsList()async{
    try{
      update((p0) async{
        var repository  = await ref.read(repositoryProvider.future);
         var temp  =  await repository.getComplaints();
         p0.complaintsList = temp;       
        return p0;
      },);

    }catch(e){
      print(e);
    }
  }
}

class GrievanceState {
  ComplaintResponseModel? complaintsList;
}
