import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vyam_2_final/authintication/register_gender.dart';
import 'package:vyam_2_final/colors/color.dart';

import '../api/api.dart';
import '../golbal_variables.dart';

class OtpPage2 extends StatefulWidget {
  static String id = "/otp_screen";
  const OtpPage2({Key? key}) : super(key: key);

  @override
  State<OtpPage2> createState() => _OtpPage2State();
}

class _OtpPage2State extends State<OtpPage2> {
  // getToHomePage(var number) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   getNumber();
  //   sharedPreferences.setString("number", number.toString());
  //   getNumber();
  //   // Get.offAll(() =>  HomePage());
  // }

  var value = Get.arguments;
  // var id = Get.arguments["id"];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  TextEditingController otpController = TextEditingController();

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);
      // _auth.verifyPhoneNumber();
      setState(() {
        showLoading = false;
      });
      if (authCred.user != null) {

        await setVisitingFlag();
        await FirebaseFirestore.instance.collection("user_details").doc(number).update({
          "number":value[1]
        });
          Get.offAll(() => Register3());
        // }

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      // ignore: avoid_print
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  var docId = Get.arguments[1];
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

  // var flag;
  // get()async{
  //   bool? flag= await getVisitingFlag();
  //   return flag;
  // }

  Timer? timer;

  @override
  void initState() {
    print("+91$docId");
    checkExist("+91$docId");
    startTimer();
    // flag = get();
    // print(flag);
    super.initState();
  }

  Timer? _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            activateButton = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool? activateButton = false;

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: showLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
          child: SingleChildScrollView(
            child: Container(
                color: backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: size.height / 15),
                          child: Image.asset(
                            "assets/Illustrations/OTP1.png",
                            height: size.height / 2.8,
                            width: size.width / 1.7,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25.0, left: 25.0, top: 10),
                          child: Text(
                            "OTP Verification",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width / 18,
                              fontFamily: "Poppins",
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w800,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 50,
                        ),
                        Text(//number settings
                            "Enter the OTP sent to ${value[1]}"),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: size.height / 14.2,
                          width: size.width / 1.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height / 15,
                                width: size.width / 1.8,
                                child: TextField(
                                  controller: otpController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                  cursorHeight: 25,
                                  maxLength: 6,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height / 15,
                        ),
                        Container(
                          child: Text(_start.toString()),
                        ),
                        Row(
                          children: [
                            const Text("Didn’t you receive the OTP? "),
                            TextButton(
                                onPressed: activateButton!
                                    ? () {
                                  print(
                                      "Implement Function For starting Resend OTP Request");
                                }
                                    : null,
                                child: const Text(
                                  "Resend OTP",
                                  style:
                                  TextStyle(color: Colors.orangeAccent),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: size.height / 15,
                        ),
                        SizedBox(
                          width: size.width / 1.2,
                          height: size.height / 17,
                          child: ElevatedButton(
                            onPressed: () async {
                              print(getVisitingFlag());
                              AuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                verificationId: value[0],
                                smsCode: otpController.text,
                              );
                              print("/////////////// Below is the Token");
                              print(phoneAuthCredential.asMap());
                              signInWithPhoneAuthCred(phoneAuthCredential);
                              // Get.toNamed(RegistrationPage.id);
                            },
                            child: const Text(
                              "Verify",
                              style: TextStyle(
                                fontSize: 17.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: buttonColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                )),
          )),
    );
  }
}
