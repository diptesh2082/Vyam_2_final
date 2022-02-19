import 'package:flutter/material.dart';

import 'custom_register_route.dart';
import 'register_gender.dart';

class Register4 extends StatelessWidget {
  static String id = "/register4_screen";
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // centerTitle: true,
          title: Container(
              //   height: MediaQuery.of(context).size.height * 0.025,
              // width: double.infinity,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('4', //_current1.toString(),
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
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                    child: Register3(),
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
            onPressed: null,
            backgroundColor: Colors.amber.shade300,
            child: null),
      ),
      body: rphoto(context),
    );
  }

  Widget rphoto(BuildContext context) => ListView(
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
                        'Add your profile picture !',
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
                        'Do not forget to smile',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                        child: Stack(children: [
                          Container(
                              height: 58,
                              width: 60,
                              // MediaQuery.of(context).size.width * 0.3,
                              child: Icon(Icons.camera_alt_outlined),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white)),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.052,
                            left: MediaQuery.of(context).size.width * 0.12,
                            right: MediaQuery.of(context).size.width * 0.0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Icon(
                                Icons.add,
                                size: 16,
                              ),
                              //color: Colors.amber,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.shade400,
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      //height: MediaQuery.of(context).size.height / 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          width: double.infinity,
                          child: Image.asset(
                              'assets/Illustrations/gym_pana_4.png')),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      );
}
