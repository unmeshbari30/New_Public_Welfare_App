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
    ),
    body: SafeArea(
      child: FutureBuilder<FileResponseModel?>(
        future: state.achievementsResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildShimmerList(); // 👈 Replaced inline shimmer
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data?.files?.isEmpty == true) {
            return const Center(child: Text("No achievements found."));
          } else {
            final files = snapshot.data!.files!;

            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                final base64String = file.base64Data;

                if (base64String == null || base64String.isEmpty) {
                  return const SizedBox.shrink();
                }

                Uint8List imageBytes;
                try {
                  imageBytes = base64Decode(base64String);
                } catch (e) {
                  return const Center(child: Text("Invalid image data."));
                }

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 10, 0),
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ),
  );
}


Widget buildShimmerList({int itemCount = 4}) {
  return ListView.builder(
    itemCount: itemCount,
    itemBuilder: (context, index) {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 0),
          color: Colors.grey.shade300,
          enabled: true,
          direction: ShimmerDirection.fromLTRB(),
          child: Container(
            height: 200,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {

    var achievementStateAsync = ref.watch(achievementsControllerProvider);
    return achievementStateAsync.when(
      data: (state) {
        return getScaffold(state);
      }, 
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