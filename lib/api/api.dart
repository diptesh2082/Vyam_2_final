import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

// ignore: prefer_typing_uninitialized_variables
var number;
Location location = Location();
Geoflutterfire geo = Geoflutterfire();
FirebaseFirestore firestore = FirebaseFirestore.instance;

getNumber() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalNumber = sharedPreferences.getString("number");
  number = finalNumber.toString();
  // ignore: avoid_print
  print(number);
}

class UserId {
  getId() {
    return number;
  }
}

class UserDetails {
  final collectionRef = FirebaseFirestore.instance.collection('user_details');
  List userData = [];

  Future getData() async {
    // ignore: avoid_print
    print(number);
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

class SaveUserDetails {
  saveUserData() {
    firestore.collection("user_details").doc(number).update({});
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
  String number = "8859451134";
  List couponList = [];
  Future getCouponData() async {
    var couponFirestore = FirebaseFirestore.instance.collection('coupon');

    try {
      await couponFirestore.get().then((value) {
        for (var result in value.docs) {
          couponList.add(result.data());
        }
      });
    } catch (e) {
      return null;
    }

    return couponList;
  }
}

class BannerApi {
  Stream<QuerySnapshot> getBanner =
      FirebaseFirestore.instance.collection('banner_details').snapshots();
}

class UpcomingApi {
  Stream<QuerySnapshot> getUpcomingEvents = FirebaseFirestore.instance
      .collection('user_details')
      .doc(number)
      .collection("bookings")
      .doc("upcoming")
      .collection("upcoming_booking")
      .snapshots();
}

class ActiveBookingApi {
  Stream<QuerySnapshot> getActiveBooking = FirebaseFirestore.instance
      .collection('user_details')
      .doc(number)
      .collection("bookings")
      .doc("active")
      .collection("active_booking")
      .snapshots();
}

class OlderBookingApi {
  Stream<QuerySnapshot> getOlderBooking = FirebaseFirestore.instance
      .collection('user_details')
      .doc(number)
      .collection("bookings")
      .doc("older")
      .collection("older_booking")
      .snapshots();
}

class GymDetailApi {
  getuserAddress() {
    // ignore: unused_local_variable
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }

  Stream<QuerySnapshot> getGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: "700091")
      .snapshots();
}


setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("alreadyVisited", true);
}

getVisitedFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
}

class UserApi {
  // static const number = "";
  static Future createUser(String name, String number, String email) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;
    number = docUser.id;
    final myJson = {
      'userId': docUser.id,
      "name": name,
      "email": email,
      "number": number,
    };
    await docUser.set(myJson);
  }

  static Future updateUserAddress(
      String address, List location, String pin) async {
    final docUser =
        FirebaseFirestore.instance.collection("user_details").doc(number);
    final myJson = {"address": address, "location": location, "pin": pin};
    await docUser.update(myJson);
  }
}

class GymAllApi {
  getuserAddress() {
    // ignore: unused_local_variable
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }

  Stream<QuerySnapshot> getGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: "700091")
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

