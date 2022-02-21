import 'package:flutter/material.dart';


import 'register_gender.dart';
import 'register_name.dart';

import 'custom_register_route.dart';

// ignore: must_be_immutable
class Register2 extends StatelessWidget {
  static String id = "/register2_screen";
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
           const Text('2',
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
          ]),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                    child: Register1(),
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
                    child: Register3(),
                  )
                  /* PageTransition(
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 50),
                      ctx: context,
                      opaque: true,
                      child: Register3(),
                      type: PageTransitionType.rightToLeftWithFade)*/
                  );
            },
            backgroundColor: Colors.amber.shade300,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: remail(context),
    );
  }

  Widget remail(BuildContext context) => ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        'Whats your email ?',
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              controller: email,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  hintText: "Email"),
                            ),
                          )),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          width: double.infinity,
                          child: Image.asset('assets/Illustrations/gym_pana_2.png')),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      );
}
