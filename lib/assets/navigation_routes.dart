import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';

void pushNewPost(BuildContext context) {
  Navigator.of(context).pushNamed(NewPostScreen.routeName);
}

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}