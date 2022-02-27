import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

// ignore: prefer_typing_uninitialized_variables
var number;
var address2;
Location location = Location();
Geoflutterfire geo = Geoflutterfire();
FirebaseFirestore firestore = FirebaseFirestore.instance;

getVisitingFlag() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? finalNumber = sharedPreferences.getBool("visited")?? false;
}
setVisitingFlag()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("visited", true);
}
getNumber() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalNumber = sharedPreferences.getString("number");
  number = finalNumber.toString();
  await UserApi.createNewUser();
  print(number);
}
getAddress() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalAddress = sharedPreferences.getString("pin");
  address2 = finalAddress .toString();
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
 Stream<QuerySnapshot> getBanner = FirebaseFirestore.instance
      .collection('banner_details')
      .snapshots();
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
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }

  Stream<QuerySnapshot> getGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: address2.toString())
      .snapshots();
  Stream<QuerySnapshot> getAllGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .snapshots();
}



class UserApi {
  // static const number = "";
  // String acc=number;
  static Future createNewUser() async {
    final docUser =
    FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;
    // number=docUser.id;
    final myJson = {
      'userId': docUser.id,
      // "name": name,
    };
    await docUser.set(myJson);
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

  static Future CreateUserNumber (String number) async {
    final docUser =
    FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;
    final myJson = {
      "number": number,
    };
    await docUser.update(myJson);
  }
  static Future CreateUserEmail (String email) async {
    final docUser =
    FirebaseFirestore.instance.collection("user_details").doc(number);
    // userModel.userId = docUser.id;

    final myJson = {
      "email": email,
    };
    await docUser.update(myJson);
  }
  static Future CreateUserGender (String gender) async {
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

class GymAllApi {
  getuserAddress() {
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }

  Stream<QuerySnapshot> getGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: address2)
      .snapshots();
  Stream<QuerySnapshot> getMaleGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: address2)
      .where("gender", isEqualTo: "male")
      .snapshots();
  Stream<QuerySnapshot> getFemaleGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: address2)
      .where("gender", isEqualTo: "female")
      .snapshots();
  Stream<QuerySnapshot> getUnisexGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: address2)
      .where("gender", isEqualTo: "unisex")
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

