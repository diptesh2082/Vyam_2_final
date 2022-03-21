// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/controllers/packages/yoga.dart';
import 'package:vyam_2_final/controllers/packages/zumba.dart';

import '../package_controller.dart';
import 'bookingDetails.dart';

class Packeges extends StatefulWidget {
  final gymName;
  final gymLocation;
  final getFinalID;
  const Packeges(
      {Key? key,
      required this.getFinalID,
      required this.gymName,
      required this.gymLocation})
      : super(key: key);

  @override
  _PackegesState createState() => _PackegesState();
}

class _PackegesState extends State<Packeges> {

  BookingDetails bookingDetails = BookingDetails();

  var dateTime;
  setDate(){
   dateTime = DateTime.now();
  }


  final userDetails=FirebaseFirestore.instance.collection("user_details");
  final auth = FirebaseAuth.instance;
  var userData ;
  getUserData()async{
    userDetails.doc(number).get().then((DocumentSnapshot doc) {
      userData=doc.data();
      // print(userData);
    });
  }
  // var String booking_id;
  final bookings= FirebaseFirestore.instance.collection("bookings").doc(number).collection("user_booking");
  final id = FirebaseFirestore.instance.collection("bookings").doc(number).collection("user_booking").doc().id.toString();
  CreateBooking(String id)async{
    final bookings= FirebaseFirestore.instance.collection("bookings").doc(number).collection("user_booking");
    print(bookings);
    // booking_id = bookings.doc().id;
    // String id=bookings.doc().id;
    bookings.doc(id).set({
      "booking_id": id,
      "booking_status": "",
      "order_date": "",
      "gym_name": "",
      "vendorId": "",
      "userId": number,
      "user_name": "",
      "booking_accepted": false,
      "payment_done": false,
      "booking_plan":"",
      "booking_price": 0.toDouble(),
      "package_type":"",
      "gym_address":"",
      "booking_date":"",
      "plan_end_duration":"",
      "otp_pass":"",
      "gym_details": {
        "image":Get.arguments["doc"]["images"][0],
        "name": widget.gymName,

      },



    });
  }
  @override
  void initState() {
    getUserData();
    setDate();
    // print(userDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 25,
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
          onPressed: () {
            // getUserData();
            Get.back();
            // print();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Packages",
          style: GoogleFonts.poppins(
              color: HexColor("3A3A3A"),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SizedBox(
        width: _width,
        height: _height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("product_details")
                      .doc(widget.getFinalID)
                      .collection("package")
                      .doc("normal_package")
                      .collection("gym")
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.requireData;
                      if (data.size == 0) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "Coming Soon !! ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                width: _width * 0.95,
                                height: 138,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20,
                                      top: 10,
                                      bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          if (
                                          int.parse(data.docs[snapshot]
                                                  ['price']) >
                                              100
                                          )
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Trending",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: HexColor("CDCDCD"),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  data.docs[snapshot]['title']??""
                                                      .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: HexColor("3A3A3A"),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          if (int.parse(data.docs[snapshot]
                                                  ['price']) <=
                                              100)
                                            Text(
                                              data.docs[snapshot]['title']??""
                                                  .toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: HexColor("3A3A3A"),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          const Spacer(),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 2,
                                      // ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (int.parse(data.docs[snapshot]
                                          ['price']) >
                                              100)

                                          if (int.parse(data.docs[snapshot]
                                          ['price']) < 100)
                                            Text(
                                              data.docs[snapshot]['title']
                                                  .toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: HexColor("3A3A3A"),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          // const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [

                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    if (int.parse(data.docs[snapshot]
                                                    ['discount']) >
                                                        0)
                                                    Container(
                                                      margin:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2.0,
                                                          left: 5,
                                                          right: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                          border: Border.all(
                                                              color: HexColor(
                                                                  "49C000"))),
                                                      child: Text(
                                                        data.docs[snapshot]
                                                        ['discount'] +
                                                            "% off",
                                                        style:
                                                        GoogleFonts.poppins(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontSize: 9,
                                                            color: HexColor(
                                                                "49C000")),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Rs "
                                                              "${int.parse(data.docs[snapshot]['original_price'])}",
                                                          style: GoogleFonts.poppins(
                                                              decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                              fontSize: 15,
                                                              color: HexColor(
                                                                  "BFB9B9"),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          "Rs "
                                                              "${int.parse(data.docs[snapshot]["original_price"]) - (int.parse(data.docs[snapshot]["original_price"]) * int.parse(data.docs[snapshot]["discount"]) / 100).round()}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontSize: 14,
                                                              color: HexColor(
                                                                  "3A3A3A"),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              if (int.parse(data.docs[snapshot]
                                              ['price']) <
                                                  100)
                                                Text(
                                                  "\$${int.parse(data.docs[snapshot]['price'])}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: HexColor("3A3A3A"),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                              Text(
                                                "Inc. of all taxes",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 9,
                                                    color: HexColor("B2B2B2"),
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          MaterialButton(
                                            elevation: 2,
                                            onPressed: ()async {
                                              FocusScope.of(context).unfocus();
                                              // CreateBooking();
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              // FocusScope.of(context).requestFocus( FocusNode());
                                              await CreateBooking(id);
                                              // print(number);
                                              await FirebaseFirestore.instance.collection("bookings")
                                              .doc(number)
                                              .collection("user_booking")
                                              .doc(id)
                                              .update(
                                                {
                                                  "booking_status": "incomplete",
                                                  "order_date": dateTime,
                                                  "gym_name": widget.gymName,
                                                  "vendorId": widget.getFinalID,
                                                  "userId": number,
                                                  "user_name": userData["name"],
                                                  "booking_accepted": false,
                                                  "payment_done": false,
                                                  "daysLeft": "50",
                                                  // "gym_details":{
                                                  //   "name":widget.gymName
                                                  // },
                                                  "totalDays":"65"


                                                }
                                              )
                                              ;
                                              bookingDetails.bookingDetails(
                                                  context,
                                                  snapshot,
                                                  data.docs,
                                                  "",
                                                  widget.gymName,
                                                  widget.gymLocation,
                                                  id,
                                                  widget.getFinalID
                                              );
                                             },
                                            color: HexColor("292F3D"),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text("Buy now",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color:
                                                            HexColor("FFFFFF"),
                                                        fontWeight:
                                                            FontWeight.w600))),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Coming Soon !! ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                    );
                  })),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YogaList(
                      width: _width,
                      getDocID: widget.getFinalID,
                      gymName: widget.gymName,
                      gymLocation: widget.gymLocation,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ZumbaList(
                        width: _width,
                        getDocId: widget.getFinalID,
                        gymName: widget.gymName,
                        gymLocation: widget.gymLocation),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
