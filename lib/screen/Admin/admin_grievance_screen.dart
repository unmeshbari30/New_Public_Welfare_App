import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rajesh_dada_padvi/controllers/Admin/grievance_controller.dart';

class AdminGrievanceScreen extends ConsumerStatefulWidget {
  const AdminGrievanceScreen({super.key});

  @override
  ConsumerState<AdminGrievanceScreen> createState() =>
      _AdminGrievanceScreenState();
}

class _AdminGrievanceScreenState extends ConsumerState<AdminGrievanceScreen> {
  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd-MM-yyyy hh:mm a').format(date);
  }

  Widget getScaffold(GrievanceState state) {
    final complaints = state.complaintsList?.complaints ?? [];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber, 
      title: Text("Complaints"),
      centerTitle: true,
      ),
      body: SafeArea(
        child: complaints.isEmpty
          ? Center(
              child: Text(
                "No Complaints",
                style: TextStyle(fontSize: 16),
              ),
            )
          : SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.complaintsList?.complaints?.length ?? 0,
                  itemBuilder: (context, index) {
                    final complaint = state.complaintsList?.complaints?[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${complaint?.fullName ?? 'N/A'}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Mobile: ${complaint?.mobileNumber ?? 'N/A'}",
                                ),
                                Text("Tehsil: ${complaint?.tehsil ?? 'N/A'}"),
                                Text("Gender: ${complaint?.gender ?? 'N/A'}"),
                                Text("Address: ${complaint?.address ?? 'N/A'}"),
                                Text(
                                  "Message: ${complaint?.yourMessage ?? 'N/A'}",
                                ),
                                Text(
                                  "Created At: ${formatDate(complaint?.createdAt)}",
                                ),
                              ],
                            ),
                          ),

                          // Top-right positioned delete button
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                try {
                                  EasyLoading.show();
                                  var temp = ref.read(
                                    grievanceControllerProvider.notifier,
                                  );
                                  var response = await temp
                                      .deleteComplaintsById(
                                        id: complaint?.id ?? "",
                                      );

                                  
                                  if (response) {

                                    await ref
                                        .read(
                                          grievanceControllerProvider.notifier,
                                        )
                                        .refreshComplaintsList();

                                        
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Complaint Delete Successfully",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                    
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Failed to Delete",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                } finally {
                                  EasyLoading.dismiss();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var grievanceState = ref.watch(grievanceControllerProvider);
    return grievanceState.when(
      data: (state) {
        return getScaffold(state);
      },
      error: (error, stackTrace) =>
          const Scaffold(body: Text("Something Went Wrong")),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
