import 'dart:io';
import 'dart:typed_data';

// import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Services {
  Future<File> savePdf(Uint8List bytes) async {
    final pdf = Document();
    pdf.addPage(Page(
      build: (context) {
        return FullPage(
          ignoreMargins: true,
          child: Image(
            MemoryImage(bytes.buffer.asUint8List()),
            fit: BoxFit.cover,
          ),
        );
      },
    )
        // MultiPage(
        //   pageFormat: PdfPageFormat.a4,
        //   build: (context) => [
        //     Center(
        //       child: Container(
        //         height: 700,
        //         child: Image(
        //           MemoryImage(
        //             bytes.buffer.asUint8List(),
        //           ),
        //           fit: BoxFit.contain,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
    return saveDocument(name: 'CV.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf?.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes!);

    return file;
  }

  static Future openFile(File file) async {
    print("harusnya ke sini");
    final url = file.path;

    await OpenFile.open(url);
  }
}
