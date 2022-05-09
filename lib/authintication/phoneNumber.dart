import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/otp2.dart';

//
// import 'otp_screen.dart';
// import 'register_gender.dart';
// import 'register_name.dart';

import '../golbal_variables.dart';
import 'custom_register_route.dart';

class PhoneRegistar extends StatefulWidget {
  static String id = "/register2_screen";

  @override
  State<PhoneRegistar> createState() => _PhoneRegistarState();
}

class _PhoneRegistarState extends State<PhoneRegistar> {
  bool showLoding = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    setVisitingFlagFalse();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        _googleSignIn.signOut();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: scaffoldColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                  Text('2',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  Text("/",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  Text('4',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w400))
                ])),
            leading: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: FloatingActionButton(
              // clipBehavior: Clip.none,
              onPressed: () async {
                final isValid = _formKey.currentState?.validate();
                if (isValid!) {
                  _formKey.currentState?.save();
                  setState(() {
                    showLoding = true;
                  });

                  await _auth.verifyPhoneNumber(
                      phoneNumber: "+91${phoneController.text}",
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoding = false;
                        });
                      },
                      verificationFailed: (verificationFailed) async {
                        Get.snackbar("Fail", "varification faild");
                        // ignore: avoid_print
                        print(verificationFailed.message);
                        setState(() {
                          showLoding = false;
                        });
                      },
                      codeSent: (verificationID, resendingToken) async {
                        setState(() {
                          showLoding = false;
                        });
                        // checkExist("+91${phoneController.text}");
                        // print(phoneController.text);
                        var resending_token = await resendingToken;
                        Get.to(
                          () => OtpPage2(
                            verificationID: verificationID,
                            number: "+91${phoneController.text.trim()}",
                            resendingToken: resending_token,
                          ),
                          //     arguments: [
                          //   verificationID,
                          //   "+91${phoneController.text.trim()}",
                          //   resendingToken
                          // ]
                        );
                      },
                      codeAutoRetrievalTimeout: (verificationID) async {});
                  // Navigator.push(
                  //     context,
                  //     CustomPageRoute(
                  //       child: Register3(),
                  //     ));
                  // await UserApi.CreateUserEmail(phoneController.text.trim());
                }
              },
              backgroundColor: Colors.amber.shade300,
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              )),
        ),
        body: showLoding
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Stack(
                  // fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Image.asset(
                            'assets/Illustrations/undraw_fitness_stats_6.png'),
                      ),
                    ),
                    Form(key: _formKey, child: phoneNumber(context)),
                  ],
                ),
              ),
      ),
    );
  }

  Widget phoneNumber(BuildContext context) => ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  // margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          'Whats your Phone Number ?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Help us tailor the experience',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width * .9,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 8.0),
                            child: TextFormField(
                              maxLength: 10,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              // maxLength: 10,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.length > 10 ||
                                    value.length < 10) {
                                  return "Enter your full Number";
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  hintText: "phone number"),
                            ),
                          )),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Container(
                      //       width: double.infinity,
                      //       child: Image.asset('assets/Illustrations/gym_pana_2.png')),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
}
