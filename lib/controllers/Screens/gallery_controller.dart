import 'package:rajesh_dada_padvi/models/Files/files_response_model.dart';
import 'package:rajesh_dada_padvi/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "gallery_controller.g.dart";

@riverpod
class GalleryController extends _$GalleryController{

@override
FutureOr<GalleryState> build() async{
  GalleryState newState = GalleryState();
  var data = await ref.read(repositoryProvider.future);
  newState.galleryResponseData = data.getGalleryData() ;
  return newState;

}





}

class GalleryState{

  Future<FileResponseModel?>? galleryResponseData;

   List<Map<String, String>> galleryItems = [
    {
      'imagePath': "lib/assets/Gallery/ranipur_info.jpeg",
      'description': "राणीपूर येथील धरणावर जाऊन परिसरातील शेतकरी बांधवांना धरणातील गाळ त्यांच्या शेतात टाकण्याचे उपक्रमास सुरवात झाली. या उपक्रमामुळे शेतजमिनींची सुपीकता वाढेल आणि धरणातील पाणीसाठाही वाढण्यास मदत होईल. समृद्ध शेती आणि भरभराटीचा मार्ग याच उपक्रमातून नक्की खुलणार! शेतकरी राजा जिंदाबाद!",
    },
    {
      'imagePath': "lib/assets/Gallery/amoni_aasharam.jpeg",
      'description': "मा. महाराष्ट्र राज्याचे आदिवासी विकास मंत्री डॉ. अशोक उईके साहेब यांच्या संवाद चिमुकल्यांशी अभियानांतर्गत मा. आ. राजेशदादा पाडवी यांनी अमोनी आश्रम शाळेतील विद्यार्थ्यांशी संवाद साधला आणि त्यांचे प्रश्न, स्वप्ने व भविष्यासाठीच्या संधींवर मनमोकळा चर्चा केली."
    },
    
    {
      "imagePath": "lib/assets/Gallery/raksha_bandhan.jpeg",
      "description": "तळोदा येथे सार्वजनिक रक्षाबंधन निमित्ताने महिला चे समस्या ऐकून घेतले"
    },
    {
      "imagePath": "lib/assets/Gallery/birsa_munda.jpeg",
      "description": "तळोदा येथे आदिवासी दिनानिमित्ताने भगवान बिरसा मुंडा यांना अभिवादन केले"
    },
    {
      "imagePath": "lib/assets/bhausaheb.jpeg",
      "description": "लोणखेडा येथे अण्णासाहेब पी. के. अण्णा पाटील यांचा पुतळ्यास अभिवादन केले"

    }
  ];


}