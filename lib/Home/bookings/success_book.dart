import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'dart:async';

import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/OrderDetails/order_details.dart';

import '../../golbal_variables.dart';


class SuccessBook extends StatefulWidget {
  final booking_id;
  final ven_id;
  final ven_name;
final branch;
  const SuccessBook({Key? key,required this.booking_id,required this.ven_id,required this.ven_name,required this.branch}) : super(key: key);
  @override
  _SuccessBookState createState() => _SuccessBookState();
}

class _SuccessBookState extends State<SuccessBook>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController _concontroller;
  late Animation<double> scaleAnimation;


  getnoty()async{
    await FirebaseFirestore.instance
        .collection("booking_notifications")
        .doc()
        .set({
      "title": "upcoming booking",
      "status": "upcoming",
      // "payment_done": false,
      "user_id": number.toString(),
      "user_name":  Get.find<GlobalUserData>().userData.value["name"],
      "vendor_id": widget.ven_id,
      "vendor_name": widget.ven_name,
      "time_stamp": DateTime.now(),
      "booking_id": widget.booking_id,
      "seen": false,
      "branch": widget.branch
    });
  }

  @override
  initState() {
    // getBookingData();
    // print(booking_details);
    // print("htffht"+booking_id);
    getnoty();
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

  bool shouldPop = true;

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.offAll(() => HomePage2());
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xffF2EFF1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .36,
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
              position:
                  Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(CurvedAnimation(
                          parent: _concontroller, curve: Curves.easeInOut)),
              child: Container(
                height: MediaQuery.of(context).size.height * .57,
                width: MediaQuery.of(context).size.width * .99,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: const PanelWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key}) : super(key: key);

  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  var id = Get.arguments["booking_details"];
  var booking_details;
  // getBookingData(String booking_id)async{
  //   try{
  //     await FirebaseFirestore.instance
  //         .collection('bookings')
  //         .doc(booking_id)
  //         .snapshots()
  //         .listen((DocumentSnapshot documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //         print('Document exists on the database');
  //           setState(() {
  //             booking_details= documentSnapshot.data();
  //           });
  //
  //         // });
  //
  //         // return documentSnapshot.data();
  //
  //       }
  //
  //     });
  //   }catch(e){
  //
  //     print(e);
  //
  //   }
  //
  // }
  showNotification(String title, String info) async {
    // setState(() {
    //   _counter++;
    // });
    await flutterLocalNotificationsPlugin.show(
      0,
      "${title}",
      "$info",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/launcher_icon'),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // getBookingData(id);
    // print(booking_details);

    // getBookingData(booking_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(booking_id);
    // print(booking_details);
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .doc(id)
          .snapshots(),
      builder: (context,AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var booking_details=snapshot.data;
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
                              children: [
                                Text(
                                  'Booking ID :',
                                  style: GoogleFonts.poppins(
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                Text(
                                " " + snapshot.data!.get("id").toString() ,
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
                              '${snapshot.data.get("gym_details")["name"] ?? '00123'}',
                              style: GoogleFonts.poppins(
                                  // fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                              ),
                              Text('${snapshot.data.get("gym_details")["branch"]}',
                                  style: GoogleFonts.poppins(
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 14)),
                            ]),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.002,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Package  ',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                                Text(
                                  '${snapshot.data!.get("booking_plan")}',
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
                             Text(
                              'Starts on:  ${DateFormat("MMMM, dd").format(snapshot.data!.get("booking_date").toDate())}',
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
                                          MaterialStateProperty.all<Color>(
                                              Color(0xff292F3D)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ))),
                                  child: Text(
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        snapshot.data.get("gym_details")["image"]))),
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
                    width: MediaQuery.of(context).size.width * .4,
                    height: 49,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xff292F3D)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      child: Text(
                        'Home',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      onPressed: () {
                        Get.off(() => HomePage2());
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    height: 49,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xff292F3D)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      onPressed: () async {
                        Get.to(() => const OrderDetails(
                          // index: index,
                          // orderList: data.docs,
                        ),

                          arguments: {
                            "doc":  snapshot.data
                          },duration: Duration(milliseconds: 450),
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
    );
  }
}
