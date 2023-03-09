import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getx/views/cv.dart';
import 'package:getx/views/services.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class CreatePdf extends StatefulWidget {
  const CreatePdf({Key? key}) : super(key: key);

  @override
  State<CreatePdf> createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdf> {
  ScreenshotController screenshotController = ScreenshotController();
  void savePDF() async {
    final image = await screenshotController.captureFromWidget(
      const MediaQuery(data: MediaQueryData(), child: CV()),
    );
    // savePDF()
    final pdf = await Services().savePdf(image);
    // success
    // openFile
    Services.openFile(pdf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: CV()),
          Padding(
            padding: const EdgeInsets.all(0),
            child: ButtonPrimary(
              text: "Open Pdf",
              onTap: () async {
                savePDF();
              },
            ),
          ),
        ],
      ),
    );
  }
}

FutureOr<dynamic> saveImage(Uint8List bytes) async {
  await [Permission.storage].request();
  // if(galeri.)

  final time = DateTime.now();
  final name = 'profile_card_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);

  return result['filePath'];
}
