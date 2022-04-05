import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/phoneNumber.dart';
import 'package:vyam_2_final/authintication/register_email.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/golbal_variables.dart';
var userName;
var userEmail;
var userPhoto;
class FirebaseService {
  getToHomePage(var number) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getNumber();
    sharedPreferences.setString("number", number.toString());
    getNumber();
    // Get.offAll(() =>  HomePage());

  }
  // final G
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //
  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authCread =await _auth.signInWithCredential(credential);
      if (authCread.user !=null){
        // bool? visitingFlag=await getVisitingFlag();
        final auth =  FirebaseAuth.instance;
        print(auth.currentUser!.email);
        // getToHomePage(auth.currentUser!.email);
        // setUserId(_auth.currentUser?.email);
        // await setNumber(_auth.currentUser!.email);
        // var visitingFlag=await get;
        // checkExist(_auth.currentUser?.email);
        await checkEmailExist("${_auth.currentUser?.email}");
        // number.toString()==_auth.currentUser?.email.toString()
        print(emailhai);
        print(emailId);
        if (emailhai== true){
          await setNumber(emailId);
          await setUserId(emailId);
          await getToHomePage(emailId);
          Get.offAll(()=>HomePage());
        }
        else if(emailhai== false){
          userName=_auth.currentUser!.displayName;
          userEmail=_auth.currentUser!.email;
          userPhoto=_auth.currentUser!.photoURL;
          Get.offAll(()=>PhoneRegistar());
        }
        setUserId(_auth.currentUser?.email);
        setVisitingFlag();
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Future<Resource?> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AuthCredential facebookCredential =
  //             FacebookAuthProvider.credential(result.accessToken!.token);
  //         final userCredential =
  //             await _auth.signInWithCredential(facebookCredential);
  //         return Resource(status: Status.Success);
  //       case LoginStatus.cancelled:
  //         return Resource(status: Status.Cancelled);
  //       case LoginStatus.failed:
  //         return Resource(status: Status.Error);
  //       default:
  //         return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> signOutFromFB() async {
  //   await FacebookAuth.instance.logOut();
  //   await _auth.signOut();
  // }
}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
