import 'package:cloud_firestore/cloud_firestore.dart';

class PostDTO {
  String imgUrl;
  String id;
  int numWasted;
  Timestamp date;
  double latitude;
  double longitude;
  // GeoPoint location;
  PostDTO(
      {this.id,
      this.imgUrl,
      this.numWasted,
      this.date,
      this.latitude,
      this.longitude});
}
