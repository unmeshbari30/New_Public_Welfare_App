import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajesh_dada_padvi/controllers/Screens/women_empowerment_controller.dart';
import 'package:rajesh_dada_padvi/controllers/home_controller.dart';
import 'package:rajesh_dada_padvi/models/Files/files_response_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WomenEmpowermentScreen extends ConsumerStatefulWidget {
  const WomenEmpowermentScreen({super.key});

  @override
  ConsumerState<WomenEmpowermentScreen> createState() => _WomenEmpowermentScreenState();
}

class _WomenEmpowermentScreenState extends ConsumerState<WomenEmpowermentScreen> {
  
  // Widget getScaffold(WomenEmpowermentState state) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       title: Text("महिला सशक्तीकरण"),
  //       backgroundColor: Colors.amber,
  //     ),
  //     body: SafeArea(
  //         child: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //             SizedBox(height: 20),
  //             ListView.builder(
  //                 shrinkWrap: true,
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 itemCount: state.galleryItems.length,
  //                 itemBuilder: (context, index) {
  //                   final item = state.galleryItems[index];
  //                   return Padding(
  //                     padding: const EdgeInsets.only(bottom: 12.0),
  //                     child: Card(
  //                       elevation: 5,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(15),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         children: [
  //                           ClipRRect(
  //                             borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
  //                             child: Image.asset(
  //                               item['imagePath'] ?? "",
  //                               fit: BoxFit.cover,
  //                               height: 200,
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(12.0),
  //                             child: Text(
  //                               item['description'] ?? "",
  //                               style: const TextStyle(fontSize: 16),
  //                               textAlign: TextAlign.justify,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //           ],
  //         ),
  //       ),
  //     )),
  //   );
  // }

  
Widget getScaffold(WomenEmpowermentState state) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text("महिला सशक्तीकरण"),
      backgroundColor: Colors.amber,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<FileResponseModel?>(
              future: state.getWomenEmpowermentData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Shimmer(
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            
                if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("Failed to load data."));
                }
            
                final items = snapshot.data!.files;
            
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items?.length,
                  itemBuilder: (context, index) {
                    final item = items?[index];
                    Uint8List? imageBytes;
                    bool useFallbackImage = false;
                    var base64String = item?.base64Data;
                  
                    if (base64String == null || base64String.trim().isEmpty) {
                        useFallbackImage = true;
                      } else {
                        try {
                          imageBytes = base64Decode(base64String);
                        } catch (e) {
                          useFallbackImage = true;
                        }
                      }
            
            
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                              child: useFallbackImage
                                  ? Image.asset(
                                      "lib/assets/Icons/broken_image.png",
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.memory(
                                      imageBytes!,
                                      // height: 200,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            if(item?.description !=null || item?.description != "")
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                item?.description ?? "",
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
  
  @override
  Widget build(BuildContext context) {
    var womenStateAsync = ref.watch(womenEmpowermentControllerProvider);
    return womenStateAsync.when(
        data: (state) => getScaffold(state),
        error: (error, stackTrace) => const Scaffold(
              body: Text("Something Went Wrong"),
            ),
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
