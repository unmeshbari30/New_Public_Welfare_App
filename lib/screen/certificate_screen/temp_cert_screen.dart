import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rajesh_dada_padvi/controllers/home_controller.dart';
import 'package:rajesh_dada_padvi/helpers/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class CertificateScreen extends ConsumerStatefulWidget {
  const CertificateScreen({super.key});

  @override
  ConsumerState<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends ConsumerState<CertificateScreen> {
  String? firstName;
  String? lastName;
  String? bloodGroup;
  int? age;
  String? mobileNumber;
  String? mailId;
  String? gender;
  String? taluka;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      firstName = prefs.getString(PrefrencesKeyEnum.firstName.key);
      lastName = prefs.getString(PrefrencesKeyEnum.lastName.key);
      bloodGroup = prefs.getString(PrefrencesKeyEnum.bloodGroup.key);
      age = prefs.getInt(PrefrencesKeyEnum.age.key);
      mobileNumber = prefs.getString(PrefrencesKeyEnum.mobileNumber.key);
      mailId = prefs.getString(PrefrencesKeyEnum.mailId.key);
      gender = prefs.getString(PrefrencesKeyEnum.gender.key);
      taluka = prefs.getString(PrefrencesKeyEnum.taluka.key);
    });
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    bool useFallbackImage = false;
    var homeState = await ref.read(homeControllerProvider.future);
    var certificate = await homeState.certificateDataResponse; 
    final base64String = certificate?.files?.first.base64Data;
    Uint8List? imageBytes;

    if (base64String == null || base64String.trim().isEmpty) {
        useFallbackImage = true;
      } else {
        try {
          imageBytes = base64Decode(base64String);
        } catch (e) {
          useFallbackImage = true;
        }
      }

    final pdf = pw.Document();
    // final image = await imageFromAssetBundle(
    //   'lib/assets/Certificates/certificate_img.jpeg',
    // );

    final image = useFallbackImage
      ? pw.MemoryImage(
          (await rootBundle.load("lib/assets/Certificates/certificate_img.jpeg")).buffer.asUint8List(),
        )
      : pw.MemoryImage(imageBytes!); 

    final customPageFormat = PdfPageFormat(
      PdfPageFormat.a4.width,
      PdfPageFormat.a4.height,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: customPageFormat,
        margin: pw.EdgeInsets.fromLTRB(0, 25, 0, 25),

        build: (pw.Context context) {
          return pw.Center(
            child: pw.Container(
              width: PdfPageFormat.a4.width,
              height: PdfPageFormat.a4.height / 2,
              decoration: pw.BoxDecoration(
                image: pw.DecorationImage(image: image, fit: pw.BoxFit.cover),
              ),
              child: pw.Stack(
                children: [
                  pw.Positioned(
                    left: 200,
                    top: 180,
                    child: pw.Text(
                      "$firstName $lastName",
                      style: pw.TextStyle(
                        font: pw.Font.timesBold(),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Certificate Generator")),
      body: SafeArea(
        child: Column(
          children: [
            // Certificate Preview
            Expanded(
              child: PdfPreview(
                build: _generatePdf,
                allowPrinting: false,
                allowSharing: true,
                canChangePageFormat: false,
                canChangeOrientation: false,
                padding: const EdgeInsets.all(8),
              ),
            ),

            // Download Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Printing.layoutPdf(onLayout: _generatePdf);
                },
                icon: const Icon(Icons.download),
                label: const Text("Download Certificate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
