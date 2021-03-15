import 'package:flutter/material.dart';
import 'package:wasteagram/screens/camera_screen.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/models/post_dto.dart';

void pushNewPost(BuildContext context) {
  Navigator.of(context).pushNamed(NewPostScreen.routeName);
}

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void pushGetGallery(BuildContext context) {
  Navigator.of(context).pushNamed(CameraScreen.routeName);
}

void sendPostToDetailScreen(FoodWastePostDTO post, BuildContext context) async {
  await Navigator.pushNamed(context, DetailScreen.routeName, arguments: post);
}

void sendPhotoToPost(String imgUrl, BuildContext context) async {
  await Navigator.pushNamed(context, NewPostScreen.routeName,
      arguments: imgUrl);
}
