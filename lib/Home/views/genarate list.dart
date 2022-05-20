// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../../golbal_variables.dart';
// import 'gymStream.dart';
//
// class LocationList extends StatefulWidget {
//
//   final location;
//
//    LocationList({Key? key, this.location}) : super(key: key);
//   @override
//   _LocationListState createState() => _LocationListState();
// }
//
// class _LocationListState extends State<LocationList> {
//
//   @override
//   Widget build(BuildContext context) {
//     // location list and mylocation
//
//     Future<double> distanceFromMyLocation(Location location) async {
//       double distance = await Geolocator.distanceBetween(
//           GlobalUserData["location"].latitude,
//           GlobalUserData["location"].longitude,
//           location.latitude,
//           location.longitude) /
//           1000;
//       return distance;
//     }
//     List<Location>  locationlist=[];
//
//     // Return a list of location and corresponding distance from user
//     Future<List<Map<String, dynamic>>> sortByDistance(List<Location> locationlist) async {
//
//       // make this an empty list by intializing with []
//       List<Map<String, dynamic>> locationListWithDistance = [];
//
//       // associate location with distance
//       for(var location in locationlist) {
//         double distance = await distanceFromMyLocation(location);
//         locationListWithDistance.add({
//           'location': location,
//           'distance': distance,
//         });
//       }
//
//       // sort by distance
//       locationListWithDistance.sort((a, b) {
//         int d1 = a['distance'];
//         int d2 = b['distance'];
//         if (d1 > d2) return 1;
//         else if (d1 < d2) return -1;
//         else return 0;
//       });
//
//       return locationListWithDistance;
//     }
//
//     return FutureBuilder(
//       future: sortByDistance(locationlist),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return CircularProgressIndicator();
//         }
//
//         var sorted = snapshot.data as List<Map<String, dynamic>>;
//
//         return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: sorted.length,
//             itemBuilder: (context, index) {
//               return LocationCard( locationAndDistance: sorted[index],);
//             });
//       },
//     );
//   }
// }
// class LocationCard extends StatelessWidget {
//   final Map<String, dynamic> locationAndDistance;
//   LocationCard({required this.locationAndDistance});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         child: Center(
//           // location can be accessed by locationAndDistance['location']
//           // distance can be accessed by locationAndDistance['distance']
//             child: Text(locationAndDistance['distance'].toString())
//         ),
//       ),
//     );
//   }
// }