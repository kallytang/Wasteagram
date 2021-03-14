import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String imgUrl;
  int numWasted;
  Timestamp date;
  double latitude;
  double longitude;

  Map<String, dynamic> toMap() {
    return {
      "image_url": imgUrl,
      "num_wasted": numWasted,
      "date": date,
      "latitude": latitude,
      "longitude": longitude
    };
  }

  Post({this.imgUrl, this.numWasted, this.date, this.latitude, this.longitude});
  String toString() {
    return "image_url: $imgUrl, num_wasted: $numWasted, date: $date, latitude: $latitude, longitude: $longitude";
  }
}
