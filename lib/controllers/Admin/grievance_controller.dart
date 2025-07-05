
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


}

class GrievanceState {

  ComplaintResponseModel? complaintsList;

 
}
