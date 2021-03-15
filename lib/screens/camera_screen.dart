import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wasteagram/assets/navigation_routes.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/assets/widgets.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = "cameraScreen";
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  final picker = ImagePicker();
  void getImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    final imageUrl = await storageReference.getDownloadURL();
    Navigator.popAndPushNamed(context, NewPostScreen.routeName,
        arguments: imageUrl);
    // sendPhotoToPost(imageUrl, context);
    //make query
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  //reference CS 492 lecture
  Widget build(BuildContext context) {
    // if (imageFile == null) {
    return Scaffold(
      body: Center(
        child:Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [imageLoadingCircle()]))
    );
  }
  
//         child: RaisedButton(
//           child: Text("Select Photo"),
//           onPressed: () {
//             getImage();
//           },
//         ),
//       );
//     } else {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.file(imageFile),
//             SizedBox(
//               height: 40,
//             ),
//             RaisedButton(child: Text("Post it"), onPressed: () {})
//           ],
//         ),
//       );
//     }
//   }
}
