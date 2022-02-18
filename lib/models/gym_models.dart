import 'package:cloud_firestore/cloud_firestore.dart';

class GymModel {
  final int id;
  final String name;
  final String location;
  final String address;
  final String review;
  final String image;
  final double lat;
  final double lon;

  GymModel(
      {required this.id,
      required this.name,
      required this.location,
      required this.address,
      required this.review,
      required this.image,
      required this.lat,
      required this.lon});

  GymModel.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        location = snapshot['location'],
        address = snapshot['address'],
        review = snapshot['review'],
        image = snapshot['image'],
        lat = snapshot['lat'],
        lon = snapshot['lon'];
}
