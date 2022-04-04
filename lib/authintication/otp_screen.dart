import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
// import 'package:vyam_2_final/authintication/regitration_from.dart';
import 'package:vyam_2_final/colors/color.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../api/api.dart';

class OtpPage extends StatefulWidget {
  static String id = "/otp_screen";

  final  verificationID;
  final number;
  final resendingToken;

  OtpPage({Key? key,required this.verificationID,required this.number,required this.resendingToken}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  getToHomePage(var number) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getNumber();
    sharedPreferences.setString("number", number.toString());
    getNumber();
    // Get.offAll(() =>  HomePage());
  }
  bool showError=false;

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
       await getToHomePage(_auth.currentUser?.phoneNumber);
        setUserId(_auth.currentUser?.phoneNumber);
        // bool? visitingFlag = await getVisitingFlag();
       await setNumber(_auth.currentUser!.phoneNumber);
        await checkExist("${_auth.currentUser?.phoneNumber}");
        await setUserId(_auth.currentUser?.phoneNumber);
        await setVisitingFlag();
        // print("rtet5ete5t35e4t5et $visiting_flag");
        if (visiting_flag == true) {
          Get.offAll(()=>HomePage());
        } else if (visiting_flag == false) {
          Navigator.pushReplacement((context), MaterialPageRoute(builder:(context)=>Register1()));
        }

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
        showError=true;
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
    // print("+91$docId");
    // checkExist("tsyyedstegr +91$docId");
    startTimer();
    // flag = get();
    // print(flag);
    super.initState();
  }

  Timer? _timer;
  int _start = 20;

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
                          showError? Text("please input correct otp",   style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red
                          ),):const SizedBox(),
                          SizedBox(
                            height: size.height / 15,
                          ),
                          Text(_start.toString()),
                          Row(
                            children: [
                             Text("Didn’t you receive the OTP? ",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                // color: Colors.red
                              ),
                              ),
                              TextButton(
                                  onPressed: activateButton!
                                      ? ()async {
                                    // setState(() {
                                    //   _timer;
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
                                    await _auth.verifyPhoneNumber(
                                        timeout: const Duration(seconds: 25),
                                        forceResendingToken: _forceResendingToken,
                                        phoneNumber: widget.number,
                                        verificationCompleted:
                                            (phoneAuthCredential) async {
                                          setState(() {
                                            showLoading = false;
                                          });
                                        },
                                        verificationFailed: (verificationFailed) async {
                                          Get.snackbar(
                                              "Fail", "${verificationFailed.message}");
                                          // ignore: avoid_print
                                          print(verificationFailed.message);
                                          setState(() {
                                            showLoading = false;
                                          });
                                        },

                                        codeSent:
                                            (verificationID, resendingToken) async {
                                          setState(() {
                                            // showLoding = false;
                                          });
                                          // setState(() {
                                          //   _timer;
                                          // });
                                          Navigator.pushReplacement((context), MaterialPageRoute(builder:(context)=>OtpPage(verificationID: verificationID,number: widget.number , resendingToken: resendingToken)));

                                          // await Get.off(() =>  OtpPage(), arguments: [
                                          //   verificationID,
                                          //   "+91${docId}",
                                          //   resendingToken
                                          // ]);
                                          // print("$resendingToken");
                                          checkExist(widget.number);
                                          var resending_token=resendingToken;

                                        },
                                        // forceResendingToken: (re){
                                        //
                                        // },
                                        codeAutoRetrievalTimeout:
                                            (verificationID) async {
                                        });
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
    );
  }
}
