import 'package:flutter/material.dart';
import 'package:wasteagram/screens/camera_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';
class App extends StatefulWidget {
  // This widget is the root of your application.
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    DetailScreen.routeName: (context) => DetailScreen(),
    CameraScreen.routeName: (context) => CameraScreen()
  };
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastagram',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: App.routes,
    );
  }
}
