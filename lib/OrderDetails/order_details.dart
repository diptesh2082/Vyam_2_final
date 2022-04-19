import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/api/maps_launcher_api.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../cancel_page.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
  }) : super(key: key);
  // final index;
  // final orderList;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List getOderDetails = [];
  var doc = Get.arguments;
// var gym__details;
  var gym_id = Get.arguments["doc"]["vendorId"];
  var booking_id = Get.arguments["doc"]["booking_id"];

  @override
  void initState() {
    // getOderDetails = widget.orderList;
    // print(doc["doc"]["vendorId"]);
    vendorData(gym_id);
    print(booking_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: HexColor("3A3A3A"),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(
              color: HexColor("3A3A3A"),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Card(
                  elevation: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .95,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 145,
                                  imageUrl: doc["doc"]['gym_details']["image"],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width*002,
                            // ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 22.0, bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Booking ID : " + doc["doc"]['id'],
                                      style: GoogleFonts.poppins(
                                          color: HexColor("3A3A3A"),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      doc["doc"]['gym_details']["name"] ?? "",
                                      style: GoogleFonts.poppins(
                                          color: HexColor("3A3A3A"),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 4.5,
                                        ),
                                        Text(
                                          doc["doc"]["gym_details"]['branch'] ??
                                              "",
                                          style: GoogleFonts.poppins(
                                              color: HexColor("3A3A3A"),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "End on :",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("A3A3A3"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  doc["doc"]
                                                          ['plan_end_duration']
                                                      .toDate()
                                                      .year
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("A3A3A3"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("49C000"),
                                                      shape: BoxShape.circle),
                                                  width: 5,
                                                  height: 5,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Confirmed",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            print(vendorDetails['location']
                                                .latitude);
                                            await MapsLaucherApi().launchMaps(
                                                vendorDetails['location']
                                                    .latitude,
                                                vendorDetails['location']
                                                    .longitude);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/icons/bx_bxs-direction-right.png",
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Navigate",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("49C000"),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color: HexColor("292F3D"),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 6,
                                                  bottom: 6),
                                              child: Text(
                                                // "",
                                                "OTP : " +
                                                    doc["doc"]['otp_pass'],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("EEEE22")),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          // onTap: () async {
                                          //   var number =
                                          //       getOderDetails[widget.index]
                                          //           ['phone_number'];
                                          //   FlutterPhoneDirectCaller.callNumber(
                                          //       number);
                                          // },
                                          child: GestureDetector(
                                            onTap: () async {
                                              var number =
                                                  (vendorDetails['number']);
                                              print(number);
                                              String telephoneUrl =
                                                  "tel:${number.toString()}";
                                              if (await canLaunch(
                                                  telephoneUrl)) {
                                                await launch(telephoneUrl);
                                              } else {
                                                throw "Error occured trying to call that number.";
                                              }
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: HexColor("292F3D"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14,
                                                          right: 14,
                                                          top: 6,
                                                          bottom: 6),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/icons/call.png"),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Call",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: HexColor(
                                                                    "FFFFFF")),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                        const Spacer()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 1,
                child: Container(
                  width: _width * 0.95,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Workout",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            // if (getOderDetails[widget.index]['workout']
                            //     .contains("Pay"))
                            //   Text(
                            //     getOderDetails[widget.index]['workout']
                            //         .toUpperCase(),
                            //     style: GoogleFonts.poppins(
                            //         fontSize: 20, fontWeight: FontWeight.w700),
                            //   ),
                            // if (getOderDetails[widget.index]['workout']
                            //     .contains("Months"))
                            Text(
                              // getOderDetails[widget.index]['workout']
                              "Gym".toUpperCase(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Package",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              // getOderDetails[widget.index]['workout']
                              "${doc["doc"]["booking_plan"] ?? ""}"
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Start date",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              // getOderDetails[widget.index]['start_date'],
                              "${doc["doc"]["booking_date"].toDate().month}/${doc["doc"]["booking_date"].toDate().day}/${doc["doc"]["booking_date"].toDate().year}",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Valid upto",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              "${doc["doc"]["plan_end_duration"].toDate().month}/${doc["doc"]["plan_end_duration"].toDate().day}/${doc["doc"]["plan_end_duration"].toDate().year}",
                              // getOderDetails[widget.index]['end_date'],
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 8,
                child: Container(
                  width: _width * 0.95,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              "Total amount",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              "Rs " + doc["doc"]['total_price'].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Discount",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              // getOderDetails[widget.index]['discount'],
                              doc["doc"]['discount'].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Promo code",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              doc["doc"]['discount'].toString(),
                              // getOderDetails[widget.index]['promocode'],
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Grand Total",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("27AE60")),
                            ),
                            const Spacer(),
                            Text(
                              "Rs " + doc["doc"]['grand_total'].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("27AE60")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Share OTP with the gym to start",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: HexColor("A3A3A3"),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.off(() => CancelDetails(
                            bookingId: booking_id,
                          ));
                      vendorData(booking_id);
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(16))),
                      //     content: SizedBox(
                      //       height: 160,
                      //       width: 160,
                      //       child: FittedBox(
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //               "Are you sure ?",
                      //               style: GoogleFonts.poppins(fontSize: 12),
                      //             ),
                      //             const SizedBox(
                      //               height: 1,
                      //             ),
                      //             Text(
                      //               "You want to cancel ?",
                      //               style: GoogleFonts.poppins(fontSize: 12),
                      //             ),
                      //             const SizedBox(
                      //               height: 15,
                      //             ),
                      //             Row(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.center,
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                 children: [
                      //                   // Image.asset("assets/icons/icons8-approval.gif",
                      //                   //   height: 70,
                      //                   //   width: 70,
                      //                   // ),
                      //
                      //                   GestureDetector(
                      //                     onTap: () async {
                      //                       Navigator.pop(context);
                      //                       await FirebaseFirestore.instance
                      //                           .collection("bookings")
                      //                           .doc(number)
                      //                           .collection("user_booking")
                      //                           .doc(booking_id)
                      //                           .update({
                      //                         "booking_status": "cancel"
                      //                       });
                      //                     },
                      //                     child: Container(
                      //                         height: 20,
                      //                         width: 28,
                      //                         decoration: BoxDecoration(
                      //                             color: HexColor("292F3D"),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(2)),
                      //                         child: Padding(
                      //                           padding: const EdgeInsets.only(
                      //                               left: 4,
                      //                               right: 3,
                      //                               top: 2,
                      //                               bottom: 2),
                      //                           child: Center(
                      //                             child: Text(
                      //                               "yes",
                      //                               style: GoogleFonts.poppins(
                      //                                   fontSize: 9,
                      //                                   fontWeight:
                      //                                       FontWeight.w700,
                      //                                   color:
                      //                                       HexColor("FFFFFF")),
                      //                             ),
                      //                           ),
                      //                         )),
                      //                   ),
                      //                   const SizedBox(width: 15),
                      //                   GestureDetector(
                      //                     onTap: () {
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: Container(
                      //                         height: 20,
                      //                         width: 28,
                      //                         decoration: BoxDecoration(
                      //                             color: HexColor("292F3D"),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(2)),
                      //                         child: Padding(
                      //                           padding: const EdgeInsets.only(
                      //                               left: 4,
                      //                               right: 3,
                      //                               top: 2,
                      //                               bottom: 2),
                      //                           child: Center(
                      //                             child: Text(
                      //                               "No",
                      //                               style: GoogleFonts.poppins(
                      //                                   fontSize: 9,
                      //                                   fontWeight:
                      //                                       FontWeight.w700,
                      //                                   color:
                      //                                       HexColor("FFFFFF")),
                      //                             ),
                      //                           ),
                      //                         )),
                      //                   ),
                      //                 ]),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("292F3D"),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Text(
                            "Cancel Order",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: HexColor("FFFFFF")),
                          ),
                        )),
                  ),
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/icons/message-question.png"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
