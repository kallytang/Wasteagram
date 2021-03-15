import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post_dto.dart';
import 'list_screen.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = "detailScreen";

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
   
    final FoodWastePostDTO post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text("Wasteagram")),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          dateTitle(post),
          imageSection(post),
          numWastedTitle(post),
          locationInfoSection(post)
        ]));
  }

  Widget dateTitle(FoodWastePostDTO post) {
    return Padding(
      child: Text(
        formatDate(post.date),
        style: TextStyle(fontSize: 30),
      ),
      padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
    );
  }

  Widget imageSection(FoodWastePostDTO post) {
    return Padding(
      child: imageHolder(post),
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
    );
  }

  Widget numWastedTitle(FoodWastePostDTO post) {
    return Padding(
      child: Text("${post.numWasted} items", style: TextStyle(fontSize: 30)),
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
    );
  }

  Widget locationInfoSection(FoodWastePostDTO post) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          child: Text("Location ${post.latitude}. ${post.longitude}",
              style: TextStyle(fontSize: 18)),
          padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
        ));
  }
}

String formatDate(Timestamp timestamp) {
  var date = timestamp.toDate();
  String formattedDate = DateFormat('E, MMM dd, yyyy').format(date);
  return formattedDate;
}

Widget imageHolder(FoodWastePostDTO post) {
  return Container(
    height: 260,
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: NetworkImage(post.imgUrl),
            alignment: FractionalOffset.topCenter)),
  );
}
