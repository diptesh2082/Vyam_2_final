import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/authintication/google_signin.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
// import 'package:vyam_2_final/authintication/regitration_from.dart';
import 'package:vyam_2_final/colors/color.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import 'package:vyam_2_final/page_trangition/fade_route.dart';

import '../api/api.dart';

class OtpPage extends StatefulWidget {
  static String id = "/otp_screen";

  final verificationID;
  final number;
  final resendingToken;

  OtpPage(
      {Key? key,
      required this.verificationID,
      required this.number,
      required this.resendingToken})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var settings;

  getToHomePage(var number) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getNumber();
    sharedPreferences.setString("number", number.toString());
    getNumber();
    // Get.offAll(() =>  HomePage());
  }

  bool showError = false;

  // var value = Get.arguments;
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
// <<<<<<< HEAD
// // <<<<<<< HEAD
//         // await  getToHomePage(_auth.currentUser?.phoneNumber);
// // =======
//         await getToHomePage(_auth.currentUser?.phoneNumber);
// // >>>>>>> 66154dc3e06a029c9d1c2a117b3c73dddb7ee373
//         await setNumber(_auth.currentUser!.phoneNumber);
//         await checkExist("${_auth.currentUser?.phoneNumber}")
//             .then((value) async {
//           await setUserId(_auth.currentUser?.phoneNumber);
//           print(visiting_flag);
//           if (visiting_flag == true) {
// // <<<<<<< HEAD
// //             Navigator.pushReplacement(
// //                 (context), MaterialPageRoute(builder: (context) => HomePage()));
// // =======
//             Get.offAll(HomePage());
//             // Navigator.pushReplacement(
//             //     (context), MaterialPageRoute(builder: (context) => HomePage()));
// // >>>>>>> 66154dc3e06a029c9d1c2a117b3c73dddb7ee373
//             // Get.offAll(()=>HomePage());
//           } else if (visiting_flag == false) {
//             userPhoto = "null";
//             Navigator.pushReplacement((context),
//                 MaterialPageRoute(builder: (context) => Register1()));
// =======
        await getToHomePage(_auth.currentUser?.phoneNumber);
        await setNumber(_auth.currentUser!.phoneNumber);
        await checkExist("${_auth.currentUser?.phoneNumber}")
            .then((value) async {
          await setUserId(_auth.currentUser?.phoneNumber);
          print(visiting_flag);
          if (visiting_flag == true) {
            Get.offAll(HomePage());
            // Navigator.pushReplacement(
            //     (context), MaterialPageRoute(builder: (context) => HomePage()));
            // Get.offAll(()=>HomePage());
          } else if (visiting_flag == false) {
            userPhoto = "null";
            Navigator.pushReplacement((context),
                MaterialPageRoute(builder: (context) => Register1()));
// >>>>>>> 66154dc3e06a029c9d1c2a117b3c73dddb7ee373
          }
        });

        // await setVisitingFlag();

        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      // Navigator.pushReplacement(
      //     (context), MaterialPageRoute(builder: (context) => LoginPage()));

      setState(() {
        showLoading = false;
        showError = true;
      });
      // ignore: avoid_print
      print(e.message);

      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  // var docId = Get.arguments[1];
  Future<void> checkExist(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_details')
          .doc(docID)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          setVisitingFlag();
          print(getVisitingFlag());
          // });
          // user_data=documentSnapshot.data();
        } else {
          setVisitingFlagFalse();
        }
      });
    } catch (e) {
      // If any error
      setVisitingFlagFalse();
    }
  }

  Timer? timer;

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  Timer? _timer;
  int _start = 30;

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
  // bool isLoding=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: scaffoldColor,
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
                                "Enter the OTP sent to ${widget.number}"),
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
                            showError
                                ? Text(
                                    "please input correct otp",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: size.height / 15,
                            ),
                            Text(_start.toString()),
                            Row(
                              children: [
                                Text(
                                  "Didn’t you receive the OTP? ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    // color: Colors.red
                                  ),
                                ),
                                TextButton(
                                    onPressed: activateButton!
                                        ? () {
                                            // setState(() {
                                            //   showLoading = true;
                                            // });
                                            // Get.off(() =>
                                            //     const OtpPage(),
                                            //   // arguments: [
                                            //     //         verificationID,
                                            //     //         "+91${docId}",
                                            //     //         resendingToken
                                            //     //       ]
                                            // );
                                            print(widget.number);
                                            // print("+91${docId}");

                                            var _forceResendingToken;
                                            _auth.verifyPhoneNumber(
                                                timeout:
                                                    const Duration(seconds: 27),
                                                forceResendingToken:
                                                    _forceResendingToken,
                                                phoneNumber: widget.number,
                                                verificationCompleted:
                                                    (phoneAuthCredential) async {
                                                  // setState(() {
                                                  //   showLoading = false;
                                                  // });
                                                },
                                                verificationFailed:
                                                    (verificationFailed) async {
                                                  Get.snackbar("Fail",
                                                      "${verificationFailed.message}");
                                                  // ignore: avoid_print
                                                  print(verificationFailed
                                                      .message);
                                                  // setState(() {
                                                  //   showLoading = false;
                                                  // });
                                                },
                                                codeSent: (verificationID,
                                                    resendingToken) async {
                                                  // setState(() {
                                                  //   showLoading = true;
                                                  // });
                                                  await Navigator.pushReplacement(
                                                      (context),
                                                      FadeRoute(
                                                          page: OtpPage(
                                                              verificationID:
                                                                  verificationID,
                                                              number:
                                                                  widget.number,
                                                              resendingToken:
                                                                  resendingToken)));

                                                  checkExist(widget.number);
                                                  var resending_token =
                                                      resendingToken;
                                                },
                                                // Get.reload()
                                                codeAutoRetrievalTimeout:
                                                    (verificationID) async {});
                                            // print(
                                            //     "Implement Function For starting Resend OTP Request");
                                          }
                                        : null,
                                    child: Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                        color: activateButton!
                                            ? Colors.orangeAccent
                                            : Colors.grey[350],
                                      ),
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
                                    verificationId: widget.verificationID,
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
      ),
    );
  }
}
