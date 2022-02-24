import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vyam_2_final/Home/home_page.dart';

import 'custom_register_route.dart';
import 'register_gender.dart';

class Register4 extends StatefulWidget {
  static String id = "/register4_screen";

  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
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
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
            onPressed: (){
              Get.offAll(()=>HomePage());
            },
            backgroundColor: Colors.amber.shade300,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            )
        ),
      ),
      body: Stack(
        children: [
          Hero(
              tag: "register",
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8.5),
                child: Image.asset('assets/Illustrations/gym_pana_4.png'),
              )),
          rphoto(context),
        ],
      ),
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
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
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
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
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
                          const CircleAvatar(
                            radius: 51,
                              backgroundColor: Colors.white,
                              // MediaQuery.of(context).size.width * 0.3,
                              child: Icon(Icons.camera_alt_outlined,
                              size: 40,
                              ),
                              // decoration: const BoxDecoration(
                              //     shape: BoxShape/.circle, color: Colors.white)
                              ),
                          Positioned(
                            // top: 0,                                  //MediaQuery.of(context).size.height * 0.052,
                            bottom: 14.5,
                            // right: 20,
                            left: 32.5,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Icon(
                                Icons.add,
                                size: 21,
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
                    // SizedBox(
                    //   //height: MediaQuery.of(context).size.height / 0.5,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Container(
                    //       width: double.infinity,
                    //       child: Image.asset(
                    //           'assets/Illustrations/gym_pana_4.png')),
                    // ),
                  ],
                ),
              )
            ],
          )
        ],
      );
}
