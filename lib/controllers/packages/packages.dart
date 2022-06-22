// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/controllers/packages/yoga.dart';

import 'package:vyam_2_final/golbal_variables.dart';

import 'bookingDetails.dart';

class Packeges extends StatefulWidget {
  final gymName;
  final gymLocation;
  final getFinalID;
  // final display_mage;
  // final branch;
  final doc;

  const Packeges(
      {Key? key,
      required this.getFinalID,
      required this.gymName,
      required this.gymLocation,
      required this.doc})
      : super(key: key);

  @override
  _PackegesState createState() => _PackegesState();
}

class _PackegesState extends State<Packeges> {
  BookingDetails bookingDetails = BookingDetails();

  var dateTime;
  bool isLoading = true;
  setDate() {
    dateTime = DateTime.now();
  }

  final userDetails = FirebaseFirestore.instance.collection("user_details");
  final auth = FirebaseAuth.instance;
  var userData;
  final id =
      FirebaseFirestore.instance.collection("bookings").doc().id.toString();

  getBookingId(id) async {
    print("//////////" + id);
    var db = FirebaseFirestore.instance.collection("bookings").doc(id);
    await FirebaseFirestore.instance
        .collection("bookings")
        .where("booking_status".toLowerCase(),
            whereIn: ["completed", "active", "upcoming", "cancelled"])
        .get()
        .then((value) async {
          if (value.docs.isNotEmpty) {
            booking_iiid = await value.docs.length;
          }
        })
        .then((value) async {
          print(booking_iiid);
          await CreateBooking(id, (booking_iiid + 500));
        });

    // coupon_list=
  }

  String? iiid;
  getUserData() async {
    userDetails.doc(number).get().then((DocumentSnapshot doc) {
      userData = doc.data();


      // print(userData);
    });
  }

// var dooc= Get.arguments["doc"];
  // bookingController booking = Get.put(bookingController());
  int booking_iiid = 0;
  // final String image = Get.arguments["doc"]["display_picture"];
  // final String branch = Get.arguments["doc"]["branch"];
  // var String booking_id;
  final bookings = FirebaseFirestore.instance.collection("bookings");

  CreateBooking(String id, int booking_id) async {
    final bookings = await FirebaseFirestore.instance.collection("bookings");
    // .doc(number)
    // .collection("user_booking");
    // print(bookings);

    await bookings.doc(id).set({
      "booking_id": id,
      "booking_status": "incomplete",
      "order_date": DateTime.now(),
      // "gym_name": "",
      "vendorId": widget.getFinalID,
      "userId": number,
      "user_name": GlobalUserData["name"],
      "booking_accepted": false,
      "payment_done": false,
      "booking_plan": "",
      "booking_price": 0.toDouble(),
      "package_type": "",
      "gym_address": "",
      "booking_date": DateTime.now(),
      "plan_end_duration": DateTime.now(),
      "otp_pass": "",
      "gym_details": {
        "image": widget.doc["display_picture"],
        "name": widget.gymName,
        "branch": widget.doc["branch"]
      },
      "daysLeft": "0",
      "discount": "0",
      "grand_total": "",
      "tax_pay": "",
      "totalDays": "0",
      "total_price": "",
      "id": booking_id,
      "payment_method": "offline"

      // "gym_details":{
      //   "name":widget.gymName
      // },
    });

    // setState(() {
    //   isLoading = false;
    // });
    print(id);
    // FirebaseFirestore.instance
    //     .collection("bookings")
    //     .doc(id)
    //     .update({
    //   // "gym_name": widget.gymName,
    // });
  }

  // getBooking()async{
  //  await getBookingId();
  //
  // }

  @override
  void initState() {
    print(id);
    // CreateBooking(id);
    getBookingId(id);
    print(id);
    setDate();
    iiid = id;
    setState(() {
      isLoading = false;
    });
    // getBookingId();
    // getBookingId();
    print(id);

    // print(number);

    // print(userDetails);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // booking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return isLoading
        ? Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
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
              backgroundColor: Color(0xffF5F5F5),
              centerTitle: true,
              title: Text(
                "Packages",
                style: GoogleFonts.poppins(
                    color: HexColor("3A3A3A"),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            backgroundColor: Colors.grey[100],
            body: SizedBox(
              width: _width,
              height: _height,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("product_details")
                            .doc(widget.getFinalID)
                            .collection("package")
                            .doc("normal_package")
                            .collection("gym")
                            .where("valid", isEqualTo: true)
                            .where("type", whereIn: ["gym","Gym","GYM"])
                            .orderBy("index")
                            .snapshots(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return  Center(
                              child: Container(),
                            );
                          }
                          if (snapshot.hasData) {
                            final data = snapshot.requireData;

                            if (data.size == 0) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child:Container()
                                  // Text(
                                  //   "Coming Soon !! ",
                                  //   style: GoogleFonts.poppins(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.red),
                                  // ),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (data.docs[snapshot]
                                                    ['trending']==true)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Trending",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                      ),
                                                      Flexible(
                                                        child: Image.asset(
                                                          "assets/icons/trending.jpeg",
                                                          height: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            Row(
                                              children: [
                                                Text(
                                                  data.docs[snapshot]
                                                          ['title'] ??
                                                      "".toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: HexColor("3A3A3A"),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                if (int.parse(
                                                        data.docs[snapshot]
                                                            ['price']) <=
                                                    100)
                                                  // Text(
                                                  //   data.docs[snapshot]
                                                  //           ['title'] ??
                                                  //       "".toUpperCase(),
                                                  //   style: GoogleFonts.poppins(
                                                  //       fontSize: 16,
                                                  //       color:
                                                  //           HexColor("3A3A3A"),
                                                  //       fontWeight:
                                                  //           FontWeight.w600),
                                                  // ),
                                                  const Spacer(),
                                              ],
                                            ),
                                            // const SizedBox(
                                            //   height: 2,
                                            // ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // if (int.parse(
                                                //         data.docs[snapshot]
                                                //             ['price']) >
                                                //     100)
                                                //   if (int.parse(
                                                //           data.docs[snapshot]
                                                //               ['price']) <
                                                //       100)
                                                // Text(
                                                //   data.docs[snapshot]
                                                //           ['title']
                                                //       .toUpperCase(),
                                                //   style:
                                                //       GoogleFonts.poppins(
                                                //           fontSize: 16,
                                                //           color: HexColor(
                                                //               "3A3A3A"),
                                                //           fontWeight:
                                                //               FontWeight
                                                //                   .w600),
                                                // ),
                                                // const Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        if (int.parse(data.docs[
                                                                    snapshot]
                                                                ['discount']) >
                                                            0)
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2.0,
                                                                    bottom: 2.0,
                                                                    left: 5,
                                                                    right: 5),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: HexColor(
                                                                        "49C000"))),
                                                            child: Text(
                                                              data.docs[snapshot]
                                                                      [
                                                                      'discount'] +
                                                                  "% off",
                                                              style: GoogleFonts.poppins(
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
                                                            if (int.parse(data
                                                                            .docs[
                                                                        snapshot]
                                                                    [
                                                                    "discount"]) >
                                                                0)
                                                              Text(
                                                                "Rs "
                                                                "${int.parse(data.docs[snapshot]['original_price'])}",
                                                                style: GoogleFonts.poppins(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        15,
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
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 18,
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
                                                    // if (int.parse(
                                                    //         data.docs[snapshot]
                                                    //             ['price']) <
                                                    //     100)
                                                    //   Text(
                                                    //     "\₹${int.parse(data.docs[snapshot]['price'])}",
                                                    //     style:
                                                    //         GoogleFonts.poppins(
                                                    //             fontSize: 16,
                                                    //             color: HexColor(
                                                    //                 "3A3A3A"),
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w600),
                                                    //   ),
                                                    Text(
                                                      "Inc. of all taxes",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 9,
                                                              color: HexColor(
                                                                  "B2B2B2"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                MaterialButton(
                                                  elevation: 2,
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    // CreateBooking();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    // FocusScope.of(context).requestFocus( FocusNode());

                                                    bookingDetails
                                                        .bookingDetails(
                                                      context,
                                                      snapshot,
                                                      data.docs,
                                                      // "",
                                                      data.docs[snapshot]
                                                          ['title'],
                                                      widget.gymName,
                                                      widget.gymLocation,
                                                      id,
                                                      widget.getFinalID,
                                                      widget.doc,
                                                    );
                                                    // CreateBooking(id);
                                                    await getBookingId(id);
                                                  },
                                                  color: HexColor("292F3D"),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text("Buy now",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color: HexColor(
                                                                  "FFFFFF"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))),
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          );
                        })),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("category")
                            .where("name", whereNotIn: ["gym","Gym","GYM"])
                            // .where("status", isEqualTo: true)
                            // .orderBy("index")
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return  Center(
                              child: Container(),
                            );
                          }
                          var docs = snapshot.data.docs;
                          var doc=[];
                          docs.forEach((e){
                            if ( widget.doc["service"].contains(e.get("name") ) ){
                              doc.add(e);
                            }

                            // return widget.doc["service"].isCaseInsensitiveContains(e.get("name")
                            //      .toString());
                          });

                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: doc.length,
                              itemBuilder: (BuildContext context, int index) {
                                // if ()
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      YogaList(
                                        type: doc[index]["name"],
                                        width: _width,
                                        getDocID: widget.getFinalID,
                                        gymName: widget.gymName,
                                        gymLocation: widget.gymLocation,
                                        image: widget.doc["display_picture"],
                                        branch: widget.doc["branch"],
                                        isLoading: isLoading,
                                        doc: widget.doc,
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),

                                    ],
                                  ),
                                );
                              });
                        })
                  ],
                ),
              ),
            ),
          );
  }
}
