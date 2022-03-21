import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMapWithCoordinates extends StatefulWidget {
  const ShowMapWithCoordinates({Key? key, this.lat, this.long})
      : super(key: key);
  final double? lat;
  final double? long;

  @override
  State<ShowMapWithCoordinates> createState() => _ShowMapWithCoordinatesState();
}

class _ShowMapWithCoordinatesState extends State<ShowMapWithCoordinates> {
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
    )));
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(23.7217038, 86.7921423),
    zoom: 11.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _gotoLocation(widget.lat!, widget.long!);
        },
        //   markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
