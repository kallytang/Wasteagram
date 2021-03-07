import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = "newPost";
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),

    );
  }
}
