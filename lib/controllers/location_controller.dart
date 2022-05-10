//
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// class LocationController extends GetxController{
//   var address = "search".obs;
//   // String location = "Search";
//   //  YourLocation(var x){
//   //   address = x;
//   // }
//   //  Future<Position> determinePosition() async {
//   //    bool serviceEnabled;
//   //    LocationPermission permission;
//   //
//   //
//   //    serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //    if (!serviceEnabled) {
//   //      await Geolocator.openLocationSettings();
//   //      return Future.error('Location services are disabled.');
//   //    }
//   //
//   //    permission = await Geolocator.checkPermission();
//   //    if (permission == LocationPermission.denied) {
//   //      permission = await Geolocator.requestPermission();
//   //      if (permission == LocationPermission.denied) {
//   //
//   //        return Future.error('Location permissions are denied');
//   //      }
//   //    }
//   //
//   //    if (permission == LocationPermission.deniedForever) {
//   //      // Permissions are denied forever, handle appropriately.
//   //      return Future.error(
//   //          'Location permissions are permanently denied, we cannot request permissions.');
//   //    }
//   //
//   //    return await Geolocator.getCurrentPosition();
//   //  }
//   //  Future<void> GetAddressFromLatLong(Position position) async {
//   //    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
//   //    Placemark place = placemark[0];
//   //    address = "${place.name},${place.street},${place.postalCode}" as RxString;
//   //  }
//
//
// }