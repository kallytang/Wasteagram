import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/assets/navigation_routes.dart';
import 'list_screen.dart';
import 'package:wasteagram/app.dart';
import 'package:wasteagram/assets/widgets.dart';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:share/share.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "newPost";

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var hintText = "Number Wasted";
  File imageFile;
  LocationData locationData;
  var imageMissing = false;
  bool isLoading = true;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  var url = "";
  var post = FoodWastePost();

  void getImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retrieveLocation();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingCircle();
    }
    return postScaffold(formKey, context);
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  Widget postScaffold(GlobalKey<FormState> formKey, BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Create Post")),
      body: postForm(formKey),
      bottomNavigationBar: postButton(formKey, context),
    );
  }

  Widget postForm(GlobalKey<FormState> formKey) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            imageHolder(),
            numberWastedField(),
          ]),
        ));
  }

  Widget loadingCircle() {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [imageLoadingCircle()],
      ),
    ));
  }

  Widget imageHolder() {
    isLoading = false;
    setState(() {});
    return Container(
      height: 260,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: FileImage(imageFile),
              alignment: FractionalOffset.topCenter)),
    );
  }

  Widget numberWastedField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Semantics(
          hint: "Enter number of items wasted",
          child: TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: hintText),
              onSaved: (value) {
                post.numWasted = int.parse(value);
              },
              validator: (value) {
                if (value.isEmpty) {
                  hintText = "Please Enter a Rating";
                  setState(() {});
                } else {
                  return null;
                }
              })),
    );
  }

  Widget postButton(GlobalKey<FormState> formKey, BuildContext context) {
    AppState appState = context.findAncestorStateOfType<AppState>();
    return Semantics(
        enabled: true,
        onTapHint: "Make post and return to main screen",
        child: GestureDetector(
            onTap: () async {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
                post.imgUrl = url;
                post.longitude = locationData.longitude;
                post.latitude = locationData.latitude;
                post.date = Timestamp.fromDate(DateTime.now());
                await FirebaseFirestore.instance
                    .collection("posts")
                    .add(post.toMap());
                appState.setState(() {});
                Navigator.of(context).pushNamedAndRemoveUntil(
                    ListScreen.routeName, (Route<dynamic> route) => false);
              }
            },
            child: Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.blue,
              child: Icon(
                Icons.cloud_upload,
                size: 100,
                color: Colors.white,
              ),
            )));
  }
}
