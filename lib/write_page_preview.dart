import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WritePreviewPage extends StatelessWidget {
  final Uint8List imgBytes;
  //static GlobalKey previewContainer = new GlobalKey();
  WritePreviewPage({
    Key key,
    @required this.imgBytes,
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
        body: Center(
          child:Image.memory(
              imgBytes,
            ),
          ),
       
      );

  Future storeSignature(BuildContext context) async {
    try {
      final status = await Permission.storage.status;
    if (status.isGranted) {
      await Permission.storage.request();
    }


      final directory = (await getExternalStorageDirectory()).path;
      print(directory);

     
      final time = DateTime.now().toIso8601String().replaceAll('.', ':');
      File imgFile = new File('$directory/tamil$time.png');

      imgFile
          .writeAsBytes(imgBytes)
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

    
  }
}
