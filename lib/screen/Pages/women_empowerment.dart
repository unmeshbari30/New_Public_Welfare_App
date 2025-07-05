import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajesh_dada_padvi/controllers/Screens/women_empowerment_controller.dart';
import 'package:rajesh_dada_padvi/controllers/home_controller.dart';

class WomenEmpowermentScreen extends ConsumerStatefulWidget {
  const WomenEmpowermentScreen({super.key});

  @override
  ConsumerState<WomenEmpowermentScreen> createState() => _WomenEmpowermentScreenState();
}

class _WomenEmpowermentScreenState extends ConsumerState<WomenEmpowermentScreen> {
  
  Widget getScaffold(WomenEmpowermentState state) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("महिला सशक्तीकरण"),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
          
              // Center(
              //     child: Text("To be updated soon...", style:  TextStyle(fontSize: 22),),
              //   )

              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.galleryItems.length,
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
      )),
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
