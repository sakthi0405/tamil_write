import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class WritePreviewPage extends StatelessWidget {
  final Uint8List signature;
  static GlobalKey previewContainer = new GlobalKey();
  WritePreviewPage({
    Key key,
    @required this.signature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: CloseButton(),
          title: Text('Save'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () => storeSignature(context),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: RepaintBoundary(
          key: previewContainer,
          child: Center(
            child: Image.memory(signature, width: double.infinity),
          ),
        ),
      );

  Future storeSignature(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary =
          previewContainer.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory()).path;
      print(directory);

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
      File imgFile = new File('$directory/screenshot.png');

      imgFile
          .writeAsBytes(pngBytes)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Saved",
                ),
                backgroundColor: Colors.green,
              )));
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Failed to save',
        ),
        backgroundColor: Colors.red,
      ));
    }

//     final status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//
//     final time = DateTime.now().toIso8601String().replaceAll('.', ':');
//     final name = 'tamil$time.png';
//
//     final result = await ImageGallerySaver.saveImage(signature, name: name);
//     final isSuccess = result['isSuccess'];
// if (isSuccess) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "Saved",
//         ),
//         backgroundColor: Colors.green,
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Failed to save',
//         ),
//         backgroundColor: Colors.red,
//       ));
//
//     }
  }
}
