// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

// import '../private_variable.dart';
final placesApiKey = "AIzaSyBueDk3xi4f8z5oGKwI8VLu-A190d89I8A";

class RequestHelper {
  Future getPlaces({String? query}) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&language=en&components=country:in&key=$placesApiKey";

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      List<PlacesApiHelperModel> list = [];
      if (response.statusCode == 200) {
        final responsebody = jsonDecode(response.body);
        for (var item in responsebody['predictions']) {
          list.add(PlacesApiHelperModel(
            mainText: item['structured_formatting']['main_text'],
            secondaryText: item['structured_formatting']['secondary_text'],
          ));
        }
        return list;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getCoordinatesFromAddresss(mainText) async {
    try {
      // List<Location> address = await GetAddressFromLatLong(position);
      List<Location> locations = await locationFromAddress(mainText);
      final map = locations[0].toJson();

      return GeocodingApiHelperModel(
          latitude: map['latitude'], longitude: map['longitude']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class PlacesApiHelperModel {
  final String? mainText;
  final String? secondaryText;

  PlacesApiHelperModel({
    this.mainText,
    this.secondaryText,
  });
}

class GeocodingApiHelperModel {
  double? latitude;
  double? longitude;

  GeocodingApiHelperModel({
    this.latitude,
    this.longitude,
  });
}
