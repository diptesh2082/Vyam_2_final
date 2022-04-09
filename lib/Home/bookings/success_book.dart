import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/Home/bookings/feedback.dart';
import 'dart:async';

import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/OrderDetails/order_details.dart';
import 'package:vyam_2_final/golbal_variables.dart';

class SuccessBook extends StatefulWidget {
  @override
  _SuccessBookState createState() => _SuccessBookState();
}

class _SuccessBookState extends State<SuccessBook>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController _concontroller;
  late Animation<double> scaleAnimation;

  // get
  // String booking_id=Get.arguments["booking_id"];


  @override
  initState() {
    // getBookingData();
    // print(booking_details);
    // print("htffht"+booking_id);

    controller = AnimationController(
        vsync: this, value: 0.1, duration: const Duration(milliseconds: 1000));
    _concontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    scaleAnimation =
    CurvedAnimation(parent: controller, curve: Curves.easeInOutBack)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            Timer(const Duration(milliseconds: 150),
                    () => _concontroller.forward());
          });
        }
      });
    controller.forward();

    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    _concontroller.dispose();
    // scaleAnimation.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width*.36,
                ),
                ScaleTransition(
                  scale: scaleAnimation,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: 85,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Booking Successful!!',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 12,
                ),
                 Text(
                  'Share the OTP with your \n  gym owner to start',
                  style: GoogleFonts.poppins(
                      // fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          const Spacer(),
          SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(CurvedAnimation(
                parent: _concontroller, curve: Curves.easeInOut)),
            child: Container(
              height: MediaQuery.of(context).size.height*.57,
              width: MediaQuery.of(context).size.width*.99,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: const PanelWidget(),
            ),
          )
        ],
      ),
    );
  }
}

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key}) : super(key: key);

  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  var booking_details=Get.arguments["booking_details"];


  @override
  void initState() {
    // TODO: implement initState

    // getBookingData(booking_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(booking_id);
    // print(booking_details);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Center(
          child: Container(
            width: 70,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Booking Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.033,
                        ),
                        Row(
                          children:  [
                            Text(
                              'Booking ID :',
                              style: GoogleFonts.poppins(
                                  // fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                             Text(
                               booking_details["id"]??'00123',
                               // "",
                              style: GoogleFonts.poppins(
                                  // fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                         Text(
                          '${booking_details["gym_details"]["name"]??'00123'}',
                          style: GoogleFonts.poppins(
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(children:  [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                          ),
                          Text(
                              '${booking_details["gym_details"]["branch"]}',
                              style: GoogleFonts.poppins(
                                  // fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 14
                              )
                          ),
                        ]),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.002,
                        ),
                        Row(
                          children:  [
                            Text(
                              'Package  ',
                              style: GoogleFonts.poppins(

                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            Text(
                              '${booking_details["booking_plan"]}',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0055,
                        ),
                        const Text(
                          'Ends on: 6th May',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0055,
                        ),
                        FittedBox(
                          child: SizedBox(
                            height: 27,
                            width: 115,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                              child:  Text(
                                'OTP : ${Get.arguments["otp_pass"]}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Container(
                        height: 133,
                        width: 155,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(booking_details["gym_details"]["image"]))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*.4,
                height: 49,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                  child:  Text(
                    'Home',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        // fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  onPressed: () {
                    Get.off(()=>HomePage());
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.09,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*.4,
                height: 49,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                  child: const Text(
                    'Track',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  onPressed: ()async {
                   await    Get.to(() => const OrderDetails(
                     // index: index,
                     // orderList: data.docs,
                   ),
                       arguments: {
                         "doc":booking_details
                       }
                   );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}