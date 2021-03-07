import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
// import 'package:share/share.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "newPost";
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  File imageFile;
  LocationData locationData;
  final picker = ImagePicker();

  void initState() {
    super.initState();
    retrieveLocation();
  }
  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    imageFile = File(pickedFile.path);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      

    );
  }
  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }
}

