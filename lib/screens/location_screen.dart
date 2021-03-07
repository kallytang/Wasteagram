import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';

class ShareLocationScreen extends StatefulWidget {
  @override
  _ShareLocationScreenState createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  LocationData locationData;
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation(); 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Latitude: ${locationData.latitude}"),
          Text("Longitude ${locationData.longitude}"),
          RaisedButton(
            child: Text("Share"),
            onPressed: () {
              Share.share("I'm at ${locationData.latitude}, ${locationData.latitude}")
            },
          )
        ],
      ),
    );
  }
}
