import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/post.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/assets/navigation_routes.dart';
import 'list_screen.dart';
import 'package:wasteagram/app.dart';

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
  bool isLoading = false;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  var url = "";
  var post = Post();
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  // void getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   imageFile = File(pickedFile.path);

  //   setState(() {});
  // }

  void getGalleryImage() async {
    isLoading = true;
    setState(() {});
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");
    imageFile = File(pickedFile.path);
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    final imageUrl = await storageReference.getDownloadURL();
    url = imageUrl;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return screenManager(formKey, context);
  }

  Widget screenManager(GlobalKey<FormState> formKey, BuildContext context) {
    if (isLoading) {
      return imageLoadingCircle();
    } else {
      return postScaffold(formKey, context);
    }
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  // Widget getCameraButton() {
  //   return Container(
  //       child: ElevatedButton(
  //           onPressed: () {
  //             getImage();
  //           },
  //           child: Text("Take Photo")));
  // }

  Widget postScaffold(GlobalKey<FormState> formKey, BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Create Post")),
      body: postForm(formKey),
      bottomNavigationBar: postButton(formKey, context),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     child: postForm(formKey),
      //     padding: const EdgeInsets.all(20),
      //   ),
      // ),
    );
  }

  Widget getGalleryButton() {
    return Column(children: [
      Center(
          child: ElevatedButton(
              onPressed: () {
                getGalleryImage();
              },
              child: Text("Get Photo From Gallery")))
    ]);
  }

  Widget postForm(GlobalKey<FormState> formKey) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            imageManager(),
            numberWastedField(),
          ]),
        ));
  }

  Widget imageManager() {
    if (imageFile == null) {
      if (imageMissing == true) {
        return Column(
          children: [
            getGalleryButton(),
            Text(
              "Please pick an Image First",
              style: TextStyle(color: Colors.red),
            )
          ],
        );
      }
      return Column(
        children: [getGalleryButton()],
      );
    } else {
      return imageHolder();
    }
  }

  Widget imageLoadingCircle() {
    return Center(
        child: Container(
      child: CircularProgressIndicator(
        value: null,
      ),
    ));
  }

  Widget imageHolder() {
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
      child:Semantics( 
          hint: "Enter number of items wasted",
          child:TextFormField(
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
    AppState appState =
        context.findAncestorStateOfType<AppState>();
    return Semantics(
      enabled: true,
      onTapHint: "Make Post",
      child:GestureDetector(
        onTap: () async {
          if (imageFile != null) {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();

              // listState.totalWasted += post.numWasted;
              
              // upload task
              post.imgUrl = url;
              post.longitude = locationData.longitude;
              post.latitude = locationData.latitude;
              post.date = Timestamp.fromDate(DateTime.now());
              await FirebaseFirestore.instance
                  .collection("posts")
                  .add(post.toMap());
              appState.setState(() {
                
              });

              goBack(context);
            }
            // show a loading bar

          } else {
            imageMissing = true;
            setState(() {});
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
