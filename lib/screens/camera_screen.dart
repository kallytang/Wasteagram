import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  final picker = ImagePicker();
  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    imageFile = File(pickedFile.path);
    setState(() {});
  }

  @override
  //reference CS 492 lecture
  Widget build(BuildContext context) {
    if (imageFile == null) {
      return Center(
        child: RaisedButton(
          child: Text("Select Photo"),
          onPressed: () {
            getImage();
          },
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(imageFile),
            SizedBox(
              height: 40,
            ),
            RaisedButton(child: Text("Post it"), onPressed: () {})
          ],
        ),
      );
    }
  }
}
