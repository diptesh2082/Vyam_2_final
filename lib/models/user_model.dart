import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel{
  String userId;
  String name;
  List<GeoPoint> location;
  String address;
  List images;
  String number;
  String email;
  String gender;

  UserModel({ required this.userId, this.name="", this.location=const[], this.address="", this.images=const[], this.number="", this.email="",this.gender=""});
  static UserModel fromJason(Map<String, dynamic> json) => UserModel(
      userId: json["userId"],
      name: json["name"],
      location: json["location"],
      address: json["address"],
    images: json["image"],
      number:json["number"],
    email: json["email"]

  );



  Map<String, dynamic> toJson() =>{
    "userId":userId,
    "name": name,
    "location": location,
    "address": address,
    "images":images,
    "number":number,
    "email":email
  };
}