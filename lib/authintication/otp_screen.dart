import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/home_page.dart';
// import 'package:vyam_2_final/authintication/regitration_from.dart';
import 'package:vyam_2_final/colors/color.dart';

class OtpPage extends StatefulWidget {
  static String id = "/otp_screen";
  OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  getToHomePage(var number) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("number", number.toString());
    Get.offAll(() => HomePage());
  }

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
      setState(() {
        showLoading = false;
      });
      if (authCred.user != null) {
        getToHomePage(value[1]);
        // SharedPreferences preferences = await SharedPreferences.getInstance();

        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
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
                          Row(
                            children: [
                              const Text("Didn’t you receive the OTP? "),
                              TextButton(
                                  onPressed: () {},
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
                                AuthCredential phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: value[0],
                                        smsCode: otpController.text);
                                signInWithPhoneAuthCred(phoneAuthCredential);
                                // Get.toNamed(RegistrationPage.id);
                              },
                              child: const Text(
                                "Verify",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: elevatedButtonColor),
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
