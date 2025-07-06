import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajesh_dada_padvi/controllers/Screens/achievements_controller.dart';
import 'package:rajesh_dada_padvi/models/Files/files_response_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({super.key});

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  //   Widget getScaffold(AchievementsState state) {
  //   final List<String> imagePaths = [
  //     "lib/assets/Rajesh_dada_101.jpeg",
  //     "lib/assets/Rajesh_dada_103.jpeg",
  //     "lib/assets/Rajesh_dada_104.jpeg",
  //     "lib/assets/Rajesh_dada_106.jpeg",
  //   ];

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("साधनेची यशस्वी वाटचाल"),
  //       centerTitle: true,
  //     ),
  //     body: SafeArea(
  //       child: ListView.builder(
  //         itemCount: imagePaths.length,
  //         itemBuilder: (context, index) {
  //           return Card(
  //             elevation: 4,
  //             margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(8, 12, 10, 0),
  //               child: Image.asset(
  //                 imagePaths[index],
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget getScaffold(AchievementsState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("साधनेची यशस्वी वाटचाल"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<FileResponseModel?>(
                future: state.achievementsResponse,
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
              
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data == null) {
                    return const Center(child: Text("No data Found"));
                  }
              
                  final files = snapshot.data!.files;
              
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: files?.length,
                    itemBuilder: (context, index) {
                      final file = files?[index];
                      final base64String = file?.base64Data;
                      final description = file?.description ?? "";
                      Uint8List? imageBytes;
                      bool useFallbackImage = false;
              
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
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: useFallbackImage
                                    ? Image.asset(
                                        "lib/assets/Icons/broken_image.png",
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.memory(
                                        imageBytes!,
                                        // width: double.infinity,
                                        // height: 180,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              if (description.isNotEmpty || description != "")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                                  child: Text(
                                    description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(fontSize: 16),
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

  //  Widget buildShimmerList({int itemCount = 4}) {
  //   return ListView.builder(
  //     itemCount: itemCount,
  //     itemBuilder: (context, index) {
  //       return Card(
  //         elevation: 4,
  //         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //         child: Shimmer(
  //           duration: const Duration(seconds: 2),
  //           interval: const Duration(seconds: 0),
  //           color: Colors.grey.shade300,
  //           enabled: true,
  //           direction: ShimmerDirection.fromLTRB(),
  //           child: Container(
  //             height: 200,
  //             margin: const EdgeInsets.all(12),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var achievementStateAsync = ref.watch(achievementsControllerProvider);
    return achievementStateAsync.when(
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