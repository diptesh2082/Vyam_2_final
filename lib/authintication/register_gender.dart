import 'package:flutter/material.dart';


import 'register_email.dart';
import 'rphoto.dart';

import 'custom_register_route.dart';

class Register3 extends StatelessWidget {
  static String id = "/register3_screen";
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ])),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                    child: Register2(),
                  ));
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
            onPressed: () {
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
            },
            backgroundColor: Colors.amber.shade300,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: rgender(context),
    );
  }

  Widget rgender(BuildContext context) => ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'You are ?',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
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
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(4),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Male',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.001,
                                      ),
                                      Icon(
                                        Icons.male,
                                        color: Colors.black,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(4),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Female',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.female,
                                        color: Colors.black,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          width: double.infinity,
                          child: Image.asset('assets/Illustrations/gym_pana_3.png')),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      );
}
