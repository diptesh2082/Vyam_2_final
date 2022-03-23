import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';

// ignore: prefer_typing_uninitialized_variables
var number;
var address2;
var total_discount=0;
final booking= FirebaseFirestore.instance.collection("bookings").doc(number).collection("user_booking");
Location location = Location();
Geoflutterfire geo = Geoflutterfire();
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

getUserId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user_Id= sharedPreferences.getString("userId")?? "";
  number=user_Id;
  print(number);
  return number;
}
setUserId(x)async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("userId", x);
}
getVisitingFlag() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? visited= sharedPreferences.getBool("visited")?? false;
  return visited;
}
setVisitingFlag()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("visited", true);
}
setVisitingFlagFalse()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("visited", false);
}
getNumber() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalNumber = sharedPreferences.getString("number");
  number = finalNumber.toString();
  print(number);
  // return number;
  // await UserApi.createNewUser();

}
getAddress() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var finalAddress = sharedPreferences.getString("pin");
  address2 = finalAddress .toString();
  // print(address2);
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
    var couponFirestore = FirebaseFirestore.instance.collection('coupon').snapshots();

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
      .collection('bookings')
      .doc(number)
      .collection("user_booking")
      .where("booking_status", isEqualTo: "active")
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
      .snapshots();
  // Stream<QuerySnapshot> getAllGymDetails = FirebaseFirestore.instance
  //     .collection("product_details")
  //     .snapshots();
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
      "number": docUser.id,
      "uid":  _auth.currentUser?.uid,
      "subLocality":""
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
  static Future creatUserImage(String url)async{
    final docUser = FirebaseFirestore.instance
        .collection("user_details")
        .doc(number);
    await docUser.update(
        {
          "image": url
        }
    );
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
class GymReviews{
  // final String uid;
  // GymReviews({required this.uid});

//   getuserAddress() {
//     Stream<QuerySnapshot> getReviews =
//     FirebaseFirestore.instance.collection('user_details').snapshots();
//   }

    Stream<QuerySnapshot> getGymReviews = FirebaseFirestore.instance
    //     .collection("Reviews")
    // .doc("GYM")
    .collectionGroup("Transformer Gym")
        // .where("pincode", isEqualTo: address2.toString())
        .snapshots();



}

class GymAllApi {
  getuserAddress() {
    Stream<QuerySnapshot> getUser =
        FirebaseFirestore.instance.collection('user_details').snapshots();
  }


  Stream<QuerySnapshot> getGymDetails = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: GlobalUserLocation)
      .snapshots();
  Stream<QuerySnapshot> getMaleGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: GlobalUserLocation)
      .where("gender", isEqualTo: "male")
      .snapshots();
  Stream<QuerySnapshot> getFemaleGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: GlobalUserLocation)
      .where("gender", isEqualTo: "female")
      .snapshots();
  Stream<QuerySnapshot> getUnisexGym = FirebaseFirestore.instance
      .collection("product_details")
      .where("pincode", isEqualTo: GlobalUserLocation)
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

