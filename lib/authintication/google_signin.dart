
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vyam_2_final/api/api.dart';

var userName;
var userEmail;
var userPhoto;
class FirebaseService {
  final context;

  FirebaseService(this.context);
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
        userPhoto=await _auth.currentUser!.photoURL;
        await checkEmailExist("${authCread.user!.email}");
        print(emailhai);
        // print(vi);
        print("///////////");

        // if (emailhai== true || visiting_flag==true){
        //    setNumber(emailId);
        //   // await setUserId(emailId);
        //   await getToHomePage(emailId);
        //   await Get.offAll(()=>HomePage());
        // }
        // else if (emailhai==false || visiting_flag==true) {
        //   userName= await _auth.currentUser!.displayName;
        //   userEmail=await _auth.currentUser!.email;
        //   userPhoto=await _auth.currentUser!.photoURL;
        //   // Navigator.push(context, MaterialPageRoute(builder: ))
        //   // await Navigator.push(
        //   //     (context), MaterialPageRoute(builder: (context) => HomePage()));
        //   await Get.to(()=>PhoneRegistar());
        // }
        setUserId(_auth.currentUser?.email);
        await setVisitingFlag();
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
