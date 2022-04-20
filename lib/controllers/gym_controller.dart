
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/camera.dart';
import '../models/gym_models.dart';

class GymController extends GetxController{

  List <GymModel> gymLists = [
    GymModel(id: 1, name: "Transfomer Gym", location: "Barakar 0.3KM", address: "Bus stand, Barakar", review: "4.7 (113 reviews)", image: "assets/photos/gym.jpg", lat: 23.7264376, lon: 86.8434882),
    GymModel(id: 2, name: "Fitness Fantasy", location: "Asansol 1.3 KM", address: "Ashram more, asansol", review: "5.0 (13 reviews)", image: "assets/photos/gym.jpg", lat: 23.6828365, lon: 86.9816039),
    GymModel(id: 3, name: "GymX Studios", location: "Asansol 2.3", address: "Bus stand, Barakar", review: "4.7 (13 reviews)", image: "assets/photos/gym.jpg", lat: 23.6823747, lon: 86.9817005),
  ];

  animateCamera(CameraUpdate newCameraPosition) {}
}