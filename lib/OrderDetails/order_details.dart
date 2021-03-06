import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/api/maps_launcher_api.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../Home/profile/Contact_Us.dart';
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
    return Scaffold(
      backgroundColor: scaffoldColor,
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
          "Booking Details",
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
                  elevation: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .95,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    maxWidthDiskCache: 400,
                                    maxHeightDiskCache: 420,
                                    height: 150,
                                    imageUrl: doc["doc"]['gym_details']
                                        ["image"],
                                  ),
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
                                    Material(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      elevation: 5,
                                      // color: Colors.yellow,
                                      // decoration: BoxDecoration(
                                      //   color: Colors.yellowAccent,
                                      //   borderRadius: BorderRadius.circular(5)
                                      // ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 3,
                                          right: 2,
                                        ),
                                        child: RichText(
                                            text: TextSpan(
                                                style: GoogleFonts.poppins(
                                                    // fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                                children: <TextSpan>[
                                              TextSpan(text: 'Booking ID - '),
                                              TextSpan(
                                                  text:
                                                      "${doc["doc"]['id'] ?? ""}",
                                                  style: GoogleFonts.poppins(
                                                      // fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Colors.amber)),
                                            ])),
                                      ),
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
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //       "End on :",
                                            //       style: GoogleFonts.poppins(
                                            //           color: HexColor("A3A3A3"),
                                            //           fontSize: 12,
                                            //           fontWeight:
                                            //               FontWeight.w500),
                                            //     ),
                                            //     Text(
                                            //       doc["doc"]
                                            //               ['plan_end_duration']
                                            //           .toDate()
                                            //           .year
                                            //           .toString(),
                                            //       style: GoogleFonts.poppins(
                                            //           color: HexColor("A3A3A3"),
                                            //           fontSize: 12,
                                            //           fontWeight:
                                            //               FontWeight.w500),
                                            //     ),
                                            //   ],
                                            // ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("FFE41F"),
                                                      shape: BoxShape.circle),
                                                  width: 5,
                                                  height: 5,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Upcoming",
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("27AE60")),
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

                              '${doc["doc"]['package_type']}'.toUpperCase(),

                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("27AE60")),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${doc["doc"]['booking_plan'] == "pay per session" || int.parse(doc["doc"]['totalDays'].toString()) <30 ? doc["doc"]['booking_plan'] : "Package"}',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              // getOderDetails[widget.index]['workout']
                              doc["doc"]['booking_plan'] == "pay per session" || int.parse(doc["doc"]['totalDays'].toString()) <30
                                  ? '${doc["doc"]['totalDays'].toString()} days'
                                  : doc["doc"]['booking_plan'],

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
                              "${DateFormat("dd, MMM,yyyy").format(doc["doc"]["booking_date"].toDate())}",
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
                              "${DateFormat("dd, MMM, yyyy").format(doc["doc"]["plan_end_duration"].toDate())}",
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
                elevation: 1,
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
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Promo code",
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 16, fontWeight: FontWeight.w400),
                        //     ),
                        //     const Spacer(),
                        //     Text(
                        //       doc["doc"]['discount'].toString(),
                        //       // getOderDetails[widget.index]['promocode'],
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 16, fontWeight: FontWeight.w400),
                        //     ),
                        //   ],
                        // ),
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
                        Divider(
                          thickness: .5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Payment Type",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey),
                            ),
                            const Spacer(),
                            if (doc["doc"]['payment_method'] == 'offline')
                              Text(
                                'Cash',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              ),
                            if (doc["doc"]['payment_method'] == 'online')
                              Text(
                                'Online',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
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
                  InkWell(
                    autofocus: false,
                    onTap: () async {
                      Get.off(
                          () => CancelDetails(
                                bookingId: booking_id,
                                vendor_name: doc["doc"]['gym_details']["name"],
                                id: doc["doc"]["id"],
                            vendorId:gym_id, branch: doc["doc"]['gym_details']["branch"],
                              ),
                          arguments: {"doc": Get.arguments["doc"]});
                      vendorData(booking_id);
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
                  InkWell(
                    onTap: () {
                      Get.to(() => ContactUs());
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/icons/message-question.png"),
                      ),
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
