import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajesh_dada_padvi/controllers/Screens/gallery_controller.dart';
import 'package:rajesh_dada_padvi/controllers/home_controller.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {



  Widget getScaffold(GalleryState state){

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text("गॅलरी"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                // Center(
                //   child: Text("To be updated soon...", style:  TextStyle(fontSize: 22),),
                // )
            
            
            
                 ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:state. galleryItems.length,
                  itemBuilder: (context, index) {
                    final item = state.galleryItems[index];
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
                              child: Image.asset(
                                item['imagePath'] ?? "",
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                item['description'] ?? "",
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
            
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            
            
            
              ],
            ),
          ),
        )
      ),
    );

  }

  
  @override
  Widget build(BuildContext context) {
    var galleryStateAsync = ref.watch(galleryControllerProvider);
    return galleryStateAsync.when(
      data: (state) => getScaffold(state), 
      error:  (error, stackTrace) => const Scaffold(
              body: Text("Something Went Wrong"),
            ), 
      loading:  () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}