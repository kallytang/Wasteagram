import 'package:flutter/material.dart';
import 'screens/list_screen.dart';

class App extends StatefulWidget {
  // This widget is the root of your application.
  static final routes = {};
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastagram',
      theme: ThemeData(
       
        primarySwatch: Colors.teal,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListScreen(),
    );
  }
}
