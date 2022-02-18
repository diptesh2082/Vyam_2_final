import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/models/home_model.dart';

class HomeController extends GetxController{
List boards  =[
  BoardInfo("assets/cards/50% off.png"),
  BoardInfo("assets/cards/yoga classes.png"),
];
List OptionsList = [
  OptionsInfo('assets/cards/gym.png'),
  OptionsInfo('assets/cards/zumba.png'),
  OptionsInfo('assets/cards/yoga.png'),
];
List <ProductGym> GymLists = [
  ProductGym(imageAssets: "assets/photos/gym.jpg", name: "Transfomer Gym", address: "Bus stand, Barakar", rating: '4.7', distance: '1'),
  ProductGym(imageAssets: "assets/photos/gyms 2.jpg", name: "Fitness Fantasy", address: "Fitness Fantasy", rating: '4.9', distance: '2'),
  ProductGym(imageAssets: "assets/photos/gyms 3.jfif", name: "GymX studios", address: "GymX studios", rating: '4.9', distance: '3.5'),
  ProductGym(imageAssets: "assets/photos/gyms 4.jpeg", name: "GymX studios", address: "GymX studios", rating: '4.7', distance: '6'),
  ProductGym(imageAssets: "assets/photos/gyms 5.jpg", name: "Transfomer Gym", address: "Bus stand, Barakar", rating: '4.7', distance: '7'),
];
}