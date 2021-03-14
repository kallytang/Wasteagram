import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/assets/navigation_routes.dart';
import 'package:wasteagram/models/post_dto.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  int totalWasted = 0;
  @override
  void initState() {
    super.initState();
    queryDBCount();
  }

  void queryDBCount() async {
    QuerySnapshot snapshots =
        await FirebaseFirestore.instance.collection("posts").get();
    totalWasted = 0;
    for (var items in snapshots.docs) {
      totalWasted += items['num_wasted'];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram, Total Wasted: ${totalWasted}')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Create a Post',
        child:FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          pushNewPost(context);
          // navigate to the new post screen
        },
      )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (content, snapshot) {
          if (snapshot.hasData) {
            countTotal(snapshot, context);
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  var postData = snapshot.data.documents[index];
                  var post = PostDTO(
                      id: postData.documentID,
                      imgUrl: postData['image_url'],
                      numWasted: postData['num_wasted'],
                      date: postData['date'],
                      latitude: postData['latitude'],
                      longitude: postData['longitude']);
                  return Semantics(
                    onTapHint: "Tap to see List information",
                    child:ListTile(
                      title: Text(formatDate(postData['date'])),
                      trailing: Text(postData['num_wasted'].toString()),
                      onTap: () {
                        sendPostToDetailScreen(post, context);
                      }));
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void countTotal(AsyncSnapshot snapshot, BuildContext context) {
    int total = 0;
    for (var docs in snapshot.data.documents) {
      total += docs["num_wasted"];
    }
    totalWasted = total;
  }
}

String formatDate(Timestamp timestamp) {
  var date = timestamp.toDate();
  String formattedDate = DateFormat('EEEE, MMMM dd, yyyy').format(date);
  return formattedDate;
}

void sendPostToDetailScreen(PostDTO post, BuildContext context) async {
  await Navigator.pushNamed(context, DetailScreen.routeName, arguments: post);
}
