import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';


import 'register_email.dart';
import 'rphoto.dart';

import 'custom_register_route.dart';

class Register3 extends StatefulWidget {
  static String id = "/register3_screen";

  Register3({Key? key}) : super(key: key);

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  String gender="";
  var name= Get.arguments["name"];
  var email=Get.arguments["email"];
  var user_number=Get.arguments["number"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text('3', //_current1.toString(),
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
            Text('4', //rimages.length.toString(),
                style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w400))
          ]),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                    child: Register2(),
                  ));
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
            onPressed: ()async {
              Navigator.push(
                  context,
                  CustomPageRoute(
                    child: Register4(),
                  )
                /* PageTransition(
                      curve: Curves.easeIn,
                      ctx: context,
                      duration: Duration(milliseconds: 50),
                      opaque: true,
                      child: Register4(),
                      type: PageTransitionType.rightToLeftWithFade)*/
              );
              // print(name);
              // await setVisitingFlag();
              await UserApi.createNewUser();
              await UserApi.createUserName(name);
              await UserApi.CreateUserEmail(email);
              await UserApi.CreateUserGender(gender);
              await FirebaseFirestore.instance.collection("user_details").doc(number).update({
                "number":number
              });


            },
            backgroundColor: Colors.amber.shade300,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: Image.asset('assets/Illustrations/undraw_energizer_re.png')),
          ),
          rgender(context),
        ],
      ),
    );
  }

  Widget rgender(BuildContext context) => ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'You are a ?',
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
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 96,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(4),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                           gender=="male"?  Colors.black87 : Colors.white
                                        ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                child: Row(
                                  children: [
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                          color: gender =="male"? Colors.white : Colors.black87 ,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Spacer(),
                                    // SizedBox(
                                    //   width:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.001,
                                    // ),
                                    Icon(
                                      Icons.male,
                                      color: gender=="male"? Colors.white : Colors.black87 ,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    gender = "male";
                                  });

                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(4),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            gender=="female"?  Colors.black87 : Colors.white
                                        ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                child: Row(
                                  children:  [
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                          color: gender=="female"? Colors.white : Colors.black87 ,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.female,
                                      color: gender=="female"? Colors.white : Colors.black87 ,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    gender = "female";
                                  });

                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Container(
                  //       width: double.infinity,
                  //       child: Image.asset('assets/Illustrations/gym_pana_3.png')),
                  // ),
                ],
              )
            ],
          )
        ],
      );
}
