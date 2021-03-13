import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    retrieveLocation();
  }

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    imageFile = File(pickedFile.path);
    setState(() {});
  }

  void getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: SingleChildScrollView(
        child: Padding(
          child: postForm(formKey),
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  Widget getCameraButton() {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              getImage();
            },
            child: Text("Take Photo")));
  }

  Widget getGalleryButton() {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              getGalleryImage();
            },
            child: Text("Get Photo From Gallery")));
  }

  Widget postForm(GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [imageManager(), numberWastedField(), postButton()],
      ),
    );
  }

  Widget imageManager() {
    if (imageFile == null) {
      return Column(
        children: [getCameraButton(), getGalleryButton()],
      );
    } else {
      return imageHolder();
    }
  }

  Widget imageHolder() {
    return Container(
      child: Image.file(imageFile),
    );
  }
}

Widget numberWastedField() {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            labelText: 'Number Wasted', border: OutlineInputBorder()),
        onSaved: (value) {
          //  add data here
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Please Enter a Rating";
          } else {
            return null;
          }
        }),
  );
}

Widget postButton() {
  return Container(
    color: Colors.blue,
  );
}
