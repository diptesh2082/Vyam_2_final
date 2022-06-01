import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/phoneNumber.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import 'dart:math' show cos, sqrt, asin;

import '../Home/views/noInternet.dart';
import '../Notifications/notification.dart';
import '../authintication/google_signin.dart';
import '../main.dart';

// ignore: prefer_typing_uninitialized_variables
var visiting_flag = false;
bool onlinePay = true;
var total_discount = 0;
bool location_service = true;
bool GlobalCouponApplied = false;
var GlobalCoupon;
Map coupon_list = {};
String CouponDetailsMap = "0";
final booking = FirebaseFirestore.instance
    .collection("bookings")
    .doc(number)
    .collection("user_booking");
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Location location = Location();
Geoflutterfire geo = Geoflutterfire();
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class couponClass extends GetxController {
  RxBool GlobalCouponApplied = false.obs;
  RxString GlobalCoupon = "".obs;
  RxString CouponDetailsMap = "".obs;
  // Map coupon_list={}.obs;
  couponAdd(bool gca, String gc) {
    GlobalCouponApplied = gca as RxBool;
    GlobalCoupon = gc as RxString;
    // coupon_list=
  }
}

// class bookingController extends GetxController{
//  var booking_id=0.obs;
//   // Map coupon_list={}.obs;
//
// }

class Need extends GetxController {
  var review = 0.0.obs;
  var star1 = 0.0.obs;
  var star2 = 0.0.obs;
  var star3 = 0.0.obs;
  var star4 = 0.0.obs;
  var star5 = 0.0.obs;
  var review_number = 0.obs;
  RxString search = "".obs;
}

getInfo() async {
  await checkExist(number);
  print(exist);
  // return exist;
  // == false?Get.off(const LoginPage()):Get.off(()=>HomePage());
}

getUserId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var userId = sharedPreferences.getString("userId") ?? "";
  // number=user_Id;
  // print(number);
  return userId;
}

setUserId(x) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("userId", x);
}

getVisitingFlag() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? visited = sharedPreferences.getBool("visited") ?? false;
  visiting_flag = visited;
  return visited;
}

setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("visited", true);
}

setVisitingFlagFalse() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("visited", false);
}

getNumber() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalNumber = sharedPreferences.getString("number");
  print(finalNumber);
  number = finalNumber!;
  print(number);
  // return number;
  // await UserApi.createNewUser();
}

setNumber(id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("number", id);

  // return number;
  // await UserApi.createNewUser();
}

getAddress() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalAddress = sharedPreferences.getString("pin");
  address2 = finalAddress.toString();

  print(address2);
}
// setVisitingFlag() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setBool("alreadyVisited", true);
// }
//
// getVisitedFlag() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   // ignore: unused_local_variable
//   bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
// }

class UserDetails {
  final collectionRef = FirebaseFirestore.instance.collection('user_details');
  List userData = [];

  Future getData() async {
    // ignore: avoid_print
    // print(number);
    try {
      await collectionRef.doc(number).get().then((value) {
        userData.add(value.data());
        return userData;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}

class NotificationApi {
  final Stream<QuerySnapshot> getnotification = FirebaseFirestore.instance
      .collection('user_details')
      .doc(number)
      .collection("notification")
      .snapshots();

  Future clearNotificationList() async {
    var remainderFirestore = FirebaseFirestore.instance
        .collection('user_details')
        .doc(number)
        .collection("notification");

    try {
      await remainderFirestore.get().then((value) {
        for (DocumentSnapshot ds in value.docs) {
          ds.reference.delete();
        }
      });
    } catch (e) {
      return null;
    }
  }
}

class CouponApi {
  // String number = "8859451134";
  List couponList = [];
  Future getCouponData() async {
    var couponFirestore =
        FirebaseFirestore.instance.collection('coupon').snapshots();

    // try {
    //   await couponFirestore.get().then((value) {
    //     for (var result in value.docs) {
    //       couponList.add(result.data());
    //     }
    //   });
    // } catch (e) {
    //   return null;
    // }

    return couponFirestore;
  }
}

class BannerApi {
  Stream<QuerySnapshot> getBanner =
      FirebaseFirestore.instance.collection('banner_details').snapshots();
}

class UpcomingApi {
  Stream<QuerySnapshot> getUpcomingEvents = FirebaseFirestore.instance
      .collection('bookings')
      .where("userId", isEqualTo: number)
      .where("booking_status", isEqualTo: "upcoming")
      .orderBy("order_date", descending: true)
      .snapshots();
}

class ActiveBookingApi {
  Stream<QuerySnapshot> getActiveBooking = FirebaseFirestore.instance
      .collection('bookings')
      .where("userId", isEqualTo: number)
      .where("booking_status", isEqualTo: "active")
      .orderBy("order_date", descending: true)
      .snapshots();
}

class OlderBookingApi {
  Stream<QuerySnapshot> getOlderBooking = FirebaseFirestore.instance
      .collection('bookings')
      .where("userId", isEqualTo: number)
      .where("booking_status", whereIn: ["completed", "cancelled"])
      .orderBy("order_date", descending: true)
      .snapshots();
}

class GymDetailApi {
  getuserAddress() {
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }

  Stream<QuerySnapshot> getGymDetails =
      FirebaseFirestore.instance.collection("product_details").snapshots();
// Stream<QuerySnapshot> getAllGymDetails = FirebaseFirestore.instance
//     .collection("product_details")
//     .snapshots();
}

class UserApi {
  // static const number = "";
  // String acc=number;
  static Future createNewUser() async {
    print(number);

    try {
      final docUser =
          FirebaseFirestore.instance.collection("user_details").doc(number);
      // userModel.userId = docUser.id;
      // number=docUser.id;
      final myJson = {
        'userId': docUser.id,
        "number": "",
        "uid": "",
        "subLocality": "",
        "locality": "",
        "name": "",
        "legit": true,
        "email": "",
        // "location":GeoPoint(0,0),
        "image": "",
        "address": "",
        "gender": "",
        // "lat": 0,
        // "long": 0,
        "location": const GeoPoint(
          0,
          0,
        ),
        "pincode": "",
        "locality": "",

        // "name": name,
      };
      await docUser.set(myJson);
    } catch (e) {
      Get.offAll(() => LoginPage());
    }
  }

  static Future createUserName(String name) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;
    // number=docUser.id;
    final myJson = {
      'userId': docUser.id,
      "name": name,
    };
    await docUser.update(myJson);
  }

  static Future creatUserImage(String url) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    await docUser.update({"image": url});
  }

  static Future CreateUserNumber(String number) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;
    final myJson = {
      "number": number,
    };
    await docUser.update(myJson);
  }

  static Future CreateUserEmail(String email) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;

    final myJson = {
      "email": email,
    };
    await docUser.update(myJson);
  }

  static Future CreateUserGender(String gender) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;
    final myJson = {
      "gender": gender,
    };
    await docUser.update(myJson);
  }

  static Future updateUserAddress(
      String address, List location, String pin) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    final myJson = {"address": address, "location": location, "pin": pin};
    await docUser.update(myJson);
  }
}

class GymReviews {
  Stream<QuerySnapshot> getGymReviews = FirebaseFirestore.instance
      //     .collection("Reviews")
      // .doc("GYM")
      .collectionGroup("Transformer Gym")
      // .where("pincode", isEqualTo: address2.toString())
      .snapshots();
}

Future<void> checkExistAcc(String docID) async {
  try {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(docID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document exists on the database');
        // setState(() {
        setVisitingFlag();
        print(getVisitingFlag());
        // });
        // user_data=documentSnapshot.data();
      } else {
        setVisitingFlagFalse();
        print(getVisitingFlag());
      }
    });
  } catch (e) {
    // If any error
    setVisitingFlagFalse();
    print(getVisitingFlag());
  }
}

var exist;
var user_details;

Future<void> checkExist(String docID) async {
  try {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(docID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document exists on the database');
        // setState(() {
        exist = true;

        setVisitingFlag();
        print(getVisitingFlag());
        // return true;
        // });
        // user_data=documentSnapshot.data();
      } else {
        exist = false;
        setVisitingFlagFalse();
        print(getVisitingFlag());
      }
    });
  } catch (e) {
    // If any error
    setVisitingFlagFalse();
    print(getVisitingFlag());
    exist = false;
  }
}
// bool result=false;
// getInternet()async{
//   var internet=InternetConnectionChecker();
//   var listener = InternetConnectionChecker().onStatusChange.listen((status) {
//     switch (status) {
//       case InternetConnectionStatus.connected:
//         print('Data connection is available.');
//         Get.offAll(HomePage());
//         break;
//       case InternetConnectionStatus.disconnected:
//
//         Get.offAll(NoInternet());
//         break;
//     }
//   });
// }

myLocation() async {
  // number=getUserId();
  // print(number);
  try {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(number)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // var userData = snapshot.data();
        GlobalUserData = snapshot.data();
        // GlobalUserLocation = GlobalUserData["pincode"]??"Tap here to tap your location";

        print(GlobalUserLocation);
        // user_data=documentSnapshot.data();
      }
    });
  } catch (e) {
    GlobalUserData = {
      "pincode": "700091",
      "address": "Tap here to choose your location",
      "gender": ""
    };
    GlobalUserLocation = "700091";
  }
}

var emailId;
var emailhai;
getToHomePage(var number) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getNumber();
  sharedPreferences.setString("number", number.toString());
  getNumber();
  // Get.offAll(() =>  HomePage());
}

checkEmailExist(String email) async {
  try {
    await FirebaseFirestore.instance
        .collection('user_details')
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        // print('Document exists on the database');
        String emailId = await snapshot.docs[0]["number"];
        print(snapshot.docs[0].id);
        emailhai = await true;
        setNumber(emailId);
        await setUserId(emailId);
        await getToHomePage(emailId);
        await Get.offAll(() => HomePage());
        // return true;
        // email=true as bool;
        // return true;

      } else {
        emailhai = await false;
        userName = await _auth.currentUser!.displayName;
        userEmail = await _auth.currentUser!.email;
        userPhoto = await _auth.currentUser!.photoURL;
        // Navigator.push(context, MaterialPageRoute(build
        await Get.to(() => PhoneRegistar());
        // return false;
      }
    });
  } catch (e) {
    await Get.to(() => LoginPage());
    print(e);
  }
}

var vendorDetails;
vendorData(String id) async {
  // number=getUserId();
  // print(number);
  try {
    await FirebaseFirestore.instance
        .collection('product_details')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document exists on the database');
        vendorDetails = documentSnapshot.data();
        return documentSnapshot.data();
      } else {
        return {};
      }
    });
  } catch (e) {
    print(e);
  }
}

class GymAllApi {
  getuserAddress() {
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }

  // getGymDetails(String type) async{
  //   Stream<QuerySnapshot> getGymDetails =  await FirebaseFirestore.instance
  //       .collection("product_details")
  //       .where("pincode", isEqualTo: GlobalUserData["pincode"])
  //       .orderBy("location")
  //       .snapshots();
  //   return getGymDetails;
  // }
  Stream<QuerySnapshot> getGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .where("locality", isEqualTo: GlobalUserData["locality"])
      .where("legit", isEqualTo: true)
      .orderBy("location")
      .snapshots();

  Stream<QuerySnapshot> getMaleGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("locality", isEqualTo: GlobalUserData["locality"])
      .where("legit", isEqualTo: true)
      .where("gender", isEqualTo: "male")
      .orderBy("location")
      .snapshots();
  Stream<QuerySnapshot> getFemaleGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("locality", isEqualTo: GlobalUserData["locality"])
      .where("gender", isEqualTo: "female")
      .where("legit", isEqualTo: true)
      .orderBy("location")
      .snapshots();
  Stream<QuerySnapshot> getUnisexGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("locality", isEqualTo: GlobalUserData["locality"])
      .where("gender", isEqualTo: "unisex")
      .where("legit", isEqualTo: true)
      .orderBy("location")
      .snapshots();
}

// class GymApi {
//   // String number = "8859451134";
//   List gymList = [];
//   Future getCouponData() async {
//     var couponFirestore = FirebaseFirestore.instance.collection('product_details');
//
//     try {
//       await couponFirestore.get().then((value) {
//         for (var result in value.docs) {
//           gymList.add(result.data());
//         }
//       });
//     } catch (e) {
//       return null;
//     }
//
//     return couponList;
//   }
// }
// distance(lat1,long1,lat2,long2){

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  double d = 12742 * asin(sqrt(a));
  d = double.parse((d).toStringAsFixed(1));
  return d;
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return Geolocator.getCurrentPosition();
}

String pin = "";
String locality = "";
String subLocality = "";
String myaddress = "your location";
var address = "";
Future<void> GetAddressFromLatLong(Position position) async {
  List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0];

  address =
      "${place.subLocality},${place.locality},${place.name},${place.street},${place.postalCode}";
  pin = "${place.postalCode}";
  locality = "${place.locality}";
  subLocality = "${place.subLocality}";
  await FirebaseFirestore.instance
      .collection("user_details")
      .doc(number)
      .update({
    "location": GeoPoint(position.latitude, position.longitude),
    "address": address,
    // "lat": position.latitude,
    // "long": position.longitude,
    "pincode": pin,
    "locality": locality,
    "subLocality": locality,
    // "number": number
  });
  await myLocation();
}

Future<void> GetAddressFromGeoPoint(GeoPoint position) async {
  List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0];

  address =
      "${place.subLocality},${place.locality},${place.name},${place.street},${place.postalCode}";
  pin = "${place.postalCode}";
  locality = "${place.locality}";
  subLocality = "${place.subLocality}";
  print(pin);
}

getAddressPin(var pin) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getAddress();
  sharedPreferences.setString("pin", pin.toString());
  getAddress();
}

getUserLocation() async {
  Position position = await _determinePosition();
  await GetAddressFromLatLong(position);
  await getAddressPin(pin);
}

checkUserLocation(bool serviceEnabled, LocationPermission permission) async {
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {}
  //   await Geolocator.openLocationSettings();
  //   return Future.error('Location services are disabled.');
  // }
  // permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     return Future.error('Location permissions are denied');
  //   }
  // }
  // if (permission == LocationPermission.deniedForever) {
  //   // Permissions are denied forever, handle appropriately.
  //   return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.');
  // }

  // return await Geolocator.getCurrentPosition();
}

// Future<void> GetAddressFromLatLong(Position position) async {
//   List<Placemark> placemark =
//   await placemarkFromCoordinates(position.latitude, position.longitude);
//   Placemark place = placemark[0];
//   print(place);
//   address =
//       "${place.name??""}, "+"${place.street??""}, ${place.locality??""}, ${place.subAdministrativeArea??""}, ${place.postalCode??""}";
//   pin = "${place.postalCode}";
//   locality = "${place.locality}";
//   subLocality = "${place.subLocality}";
// }
class TkInd extends GetxController {
  var current = 0.obs;
  var isSelected = [true, false, false, false, false, false, false, false].obs;
}

Future getDevicetoken() async {
  try {
    // setState(() async {
    final device_token;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    device_token = await _firebaseMessaging.getToken();
    // });

    print("this is the token $device_token");
    return device_token;
  } catch (e) {
    print(e);
  }
}
