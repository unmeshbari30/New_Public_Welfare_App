import 'package:rajesh_dada_padvi/models/Files/files_response_model.dart';
import 'package:rajesh_dada_padvi/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "women_empowerment_controller.g.dart";

@riverpod
class WomenEmpowermentController extends _$WomenEmpowermentController{

@override
FutureOr<WomenEmpowermentState> build() async{
  WomenEmpowermentState newState = WomenEmpowermentState();
  var data = await ref.read(repositoryProvider.future);
  newState.getWomenEmpowermentData = data.getWomenEmpowermentData() ;
  return newState;

}





}

class WomenEmpowermentState{

  Future<FileResponseModel?>? getWomenEmpowermentData; 

  List<Map<String, String>> galleryItems = [
    {
      'imagePath': "lib/assets/women_empowerment/savitribai_phule_jayanti.jpeg",
      'description': "8 मार्च रोजी महिला दिनानिम्मत सावित्रीबाई फुले ज्येष्ठ नागरिक महिला मंडळ यांच्या कार्यक्रमात उपस्थित होते."
    },
    {
      'imagePath': "lib/assets/women_empowerment/women_day.jpeg",
      'description': "बोरद येथे महिला दिनानिमित्त महिलांचे प्रश्न जाणून घेतले व त्यांना महिलांचे सरकार द्वारे मिळणाऱ्या  उपाययोजना समजून देण्यात आले.",
    },
    {
      "imagePath": "lib/assets/women_empowerment/bachatgat.jpeg",
      "description": "तळवे या गावी अंगणवाडी व महिला बचत गटाची बैठक घेऊन त्यांना नवीन उद्योगधंद्याबद्दल माहिती दिली"
    },
    // Add more items here
    {
      "imagePath": "lib/assets/women_empowerment/mod_bachatgat_meeting.jpeg",
      "description": "मोड या गावी महिला बचत गटाची मीटिंग ठेवून त्यांच्या समस्या जाणून घेतल्या व बचत गटाच्या नवीन उपाययोजना सांगण्यात आला."
    },
    {
      "imagePath": "lib/assets/women_empowerment/morwad.jpeg",
      "description": "मोरवड येथे तरुणींशी भेट घेऊन त्यांच्याजवळ चर्चा केली."
    },
    {
      "imagePath": "lib/assets/women_empowerment/morwad_mahile_charcha.jpeg",
      "description": "मोरवड या गावी महिलांशी चर्चा करून त्यांच्या समस्या ऐकून घेतल्या."
    },

    //
    {
      "imagePath": "lib/assets/women_empowerment/ranjanpur_prasad.jpeg",
      "description": "तीर्थक्षेत्र रंजनपुर येथे दर्शन घेऊन  महाप्रसादाच्या लाभ घेतला."
    },
    {
      "imagePath": "lib/assets/women_empowerment/bachatgat_meeting.jpeg",
      "description": "आम्हाला बचत गट महिलांची मीटिंग घेऊन त्यांच्या समस्या ऐकून त्यावर निराकरण केले."
    },
    {
      "imagePath": "lib/assets/women_empowerment/kalawati_foundation.jpeg",
      "description": "आ. राजेशदादा पाडवी यांच्या मार्गदर्शनाखाली कै. कलावती पाडवी फाउंडेशन च्या माध्यमातून कु. नेहा राजेशदादा पाडवी यांच्या हस्ते जिल्हा परिषदेचा शाळेत वॉटर प्युरिफायरचे लोकार्पण करण्यात आले."
    },
  ];


}