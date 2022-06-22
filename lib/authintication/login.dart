import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/Home/profile/Terms_&_Conditions.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/google_signin.dart';
import 'package:vyam_2_final/authintication/otp_screen.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/colors/color.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../Home/profile/privacyPolicy.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoding = false;
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // goToHome(){
  //   if ();
  // }
  var resending_token;
  bool wrong=false;

  googleIn() async {
    print('hhhhhhhhhhhhhh');
    // FirebaseService().signInwithGoogle();
    FirebaseService service = FirebaseService(context);
    try {
      await service.signInwithGoogle();
      setState(() {
        showLoding = false;
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        Text(e.message!);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(number);

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: showLoding
          ?  Container(
          color: Colors.white,
          child: Center(child: Image.asset( "assets/Illustrations/vyam.png",
            height: 200,
            width: 200,
          )))
          : SafeArea(
              child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                    color: backgroundColor,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/sign_up.png",
                          height: size.height / 2.5,
                          width: size.width / 1.08,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: size.height / 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25.0, left: 25.0, top: 0),
                          child: InkWell(
                            onTap: (){
                              final GoogleSignIn _googleSignIn = GoogleSignIn();
                              _googleSignIn.signOut();
                            },
                            child: Text(
                              "Find and book best gyms Online",
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
                        ),
                        SizedBox(
                          height: size.height / 50,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 15.0),
                                child: const Divider(
                                  color: Colors.black,
                                  height: 36,
                                  thickness: 1,
                                )),
                          ),
                          const Text(
                            "Log in or sign up",
                            style: TextStyle(fontSize: 15),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 10.0),
                                child: const Divider(
                                  color: Colors.black,
                                  height: 36,
                                  thickness: 1,
                                )),
                          ),
                        ]),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          // height: size.height / 15,
                          width: size.width / 1.15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width / 25,
                              ),
                              Container(
                                height: size.height / 35,
                                width: size.height / 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/icons/india_flag.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "+91",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 20, bottom: 0),
                                child: SizedBox(
                                  // height: size.height / 15,
                                  width: size.width *.55,
                                  child: Column(
                                    children: [

                                      TextFormField(

                                         maxLength: 10,
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            counterText: "",
                                            border: InputBorder.none,
                                            hintText: "Enter phone number",
                                        ),
                                        validator: (value) {
                                          if (value!.length !=10) {
                                            return "Enter Correct Number";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if(wrong)
                          Text(
                              "Invalid number",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12

                            ),
                              ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        SizedBox(
                          width: size.width / 1.2,
                          height: size.height / 17,
                          child: ElevatedButton(
                            onPressed: () async {
                              final isValid = _formKey.currentState?.validate();
                              if (isValid!){
                                _formKey.currentState?.save();
                                setState(() {
                                  showLoding = true;
                                }
                                );
                                var _forceResendingToken;
                                await _auth.verifyPhoneNumber(
                                    timeout: const Duration(seconds: 30),
                                    forceResendingToken: _forceResendingToken,
                                    phoneNumber: "+91${phoneController.text}",
                                    codeSent:
                                        (verificationID, resendingToken) async {

                                      resending_token = resendingToken;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OtpPage(
                                                verificationID: verificationID,
                                                number:
                                                "+91${phoneController.text.trim()}",
                                                resendingToken: resending_token,
                                              )));
                                      setState(() {
                                        showLoding = false;
                                      });
                                    },
                                    verificationCompleted:
                                        (phoneAuthCredential) async {
                                      setState(() {
                                        showLoding = false;
                                      }
                                      );
                                    },
                                    verificationFailed: (verificationFailed) async {
                                      // Get.snackbar(
                                      //     "Fail", "${verificationFailed.message}");
                                      // ignore: avoid_print
                                      print(verificationFailed.message);
                                      setState(() {
                                        wrong=true;
                                        showLoding = false;
                                      });
                                    },

                                    // forceResendingToken: (re){
                                    //
                                    // },
                                    codeAutoRetrievalTimeout:
                                        (verificationID) async {});
                              }

                            },
                            child: Text(
                              "Continue",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(primary: buttonColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 15.0),
                                child: const Divider(
                                  color: Colors.black,
                                  height: 30,
                                  thickness: .8,
                                )),
                          ),
                          const Text(
                            "Or",
                            style: TextStyle(fontSize: 15),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 10.0),
                                child: const Divider(
                                  color: Colors.black,
                                  height: 30,
                                  thickness: .8,
                                )),
                          ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    // setState(() {
                                    //   showLoding = true;
                                    // });
                                    await googleIn();
                                  },
                                  icon: Image.asset(
                                    "assets/icons/google-3.png",
                                    height: 45,
                                    width: 45,
                                  )
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 250,
                          // height: 40,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                   "Continue means you agree to",
                                style: GoogleFonts.poppins(
                                  // fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Text(
                                        " Privacy Policy",
                                        style:  GoogleFonts.poppins(
                                          // fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            // color: Colors.amber
                                        )
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
                                    },
                                  ),
                                  Text(
                                      " and",
                                      style:  GoogleFonts.poppins(
                                        // fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Colors.grey
                                      )
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndCondition()));

                                    },
                                    child: Text(
                                        " Terms of use",
                                        style:  GoogleFonts.poppins(
                                          // fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            // color: Colors.amber
                                        )
                                    ),
                                  ),
                                ],
                              ),

                              // RichText(
                              //   textAlign: TextAlign.center,
                              //     maxLines: 2,
                              //     text: TextSpan(
                              //         style: GoogleFonts.poppins(
                              //           // fontFamily: "Poppins",
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 12,
                              //             color: Colors.grey),
                              //         children:  <TextSpan>[
                              //           TextSpan(
                              //               text: "Continue means you agree to"
                              //           ),
                              //           TextSpan(
                              //             text:" Terms of use",
                              //             style:  GoogleFonts.poppins(
                              //               // fontFamily: "Poppins",
                              //                 fontWeight: FontWeight.w700,
                              //                 fontSize: 12,
                              //                 color: Colors.amber
                              //             )
                              //               //     :GoogleFonts.poppins(
                              //               // // fontFamily: "Poppins",
                              //               //   fontWeight: FontWeight.w500,
                              //               //   fontSize: 12,
                              //               //   color: Colors.grey),
                              //           ),
                              //           TextSpan(
                              //               text: " and",
                              //               style:  GoogleFonts.poppins(
                              //                 // fontFamily: "Poppins",
                              //                   fontWeight: FontWeight.w500,
                              //                   fontSize: 12,
                              //               )
                              //           ),
                              //           TextSpan(
                              //               text: " Privacy Policy",
                              //               style:  GoogleFonts.poppins(
                              //                 // fontFamily: "Poppins",
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: 12,
                              //                   color: Colors.amber
                              //               )
                              //           ),
                              //
                              //         ]
                              //
                              //     )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    )),
              ),
            )),
    );
  }
}
