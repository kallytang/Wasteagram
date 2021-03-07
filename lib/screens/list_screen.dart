import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/assets/navigation_routes.dart';

class ListScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pushNewPost(context);
          // navigate to the new post screen
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (content, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data.documents[index];
                  return ListTile(
                      title: Text(formatDate(post['date'])),
                      trailing: Text(post['num_wasted'].toString()),
                      onTap:() {
                        
                  }); 
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
}

String formatDate(Timestamp timestamp) {
  var date = timestamp.toDate();
  String formattedDate = DateFormat('EEEE, MMMM dd, yyyy').format(date);
  return formattedDate;
}
