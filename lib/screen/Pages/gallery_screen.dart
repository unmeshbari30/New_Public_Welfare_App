import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajesh_dada_padvi/controllers/Screens/gallery_controller.dart';
import 'package:rajesh_dada_padvi/models/Files/files_response_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {

  Widget getScaffold(GalleryState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text("गॅलरी"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<FileResponseModel?>(
                future: state.galleryResponseData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show shimmer for the whole list
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
                    return const Center(child: Text("No data in Gallery"));
                  }
              
                  final galleryItems = snapshot.data!.files;
              
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: galleryItems?.length,
                    itemBuilder: (context, index) {
                      final item = galleryItems?[index];
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
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
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
                              if (item?.description != null ||
                                  item?.description != "")
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
    var galleryStateAsync = ref.watch(galleryControllerProvider);
    return galleryStateAsync.when(
      data: (state) => getScaffold(state),
      error: (error, stackTrace) =>
          const Scaffold(body: Text("Something Went Wrong")),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}