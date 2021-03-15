import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePostDTO {
  String imgUrl;
  String id;
  int numWasted;
  Timestamp date;
  double latitude;
  double longitude;
  // GeoPoint location;
  FoodWastePostDTO(
      {this.id,
      this.imgUrl,
      this.numWasted,
      this.date,
      this.latitude,
      this.longitude});
}
