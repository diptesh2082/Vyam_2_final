import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vyam_2_final/OrderDetails/active_details.dart';
import 'package:vyam_2_final/api/api.dart';

class OlderEvent extends StatelessWidget {
  OlderBookingApi olderBookingApi = OlderBookingApi();
  OlderEvent({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  final double _width;
  List events = [];
  // ActiveBookingApi activeBookingApi = ActiveBookingApi();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: olderBookingApi.getOlderBooking,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            if (data.size == 0) {
              return Center(
                child: Image.asset(
                  "assets/icons/olderEmpty.png",
                  height: _width * 0.8,
                ),
              );
            }
            var document = snapshot.data.docs;
            return  Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: document.isNotEmpty? ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    var end_time= data.docs[index]['plan_end_duration'];
                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ActiveOrderDetails(
                            // index: index,
                            // orderList: data.docs,
                          ),
                              arguments: {
                                "doc":data.docs[index]
                              },duration: Duration(milliseconds: 450),
                          );
                        },
                        child: FittedBox(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 1,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              width: _width * 0.9,
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9.0, left: 6, bottom: 9,right: 3),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              child:Padding(
                                                padding: const EdgeInsets.only(left: 3,right: 2,),
                                                child: RichText(
                                                    text: TextSpan(
                                                        style: GoogleFonts.poppins(
                                                          // fontFamily: "Poppins",
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                        children:  <TextSpan>[
                                                          TextSpan(
                                                              text: 'Booking ID - '
                                                          ),
                                                          TextSpan(
                                                              text: "${data.docs[index]['id']??""}",
                                                              style:GoogleFonts.poppins(
                                                                // fontFamily: "Poppins",
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 12,
                                                                  color: Colors.amber
                                                              )
                                                          ),
                                                        ]

                                                    )),
                                              ),

                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data.docs[index]['gym_details']["name"]??"",
                                              // data.docs[index]['gym_name'],
                                              style: GoogleFonts.poppins(
                                                  color: HexColor("3A3A3A"),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 16,
                                                ),
                                                const SizedBox(
                                                  width: 4.5,
                                                ),
                                                Text(
                                                  "${data.docs[index]["gym_details"]["branch"]??""}",
                                                  // data.docs[index]['gym_name'],
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            // if (
                                            // data.docs[index]["workout"]
                                            //     .contains("months") ||
                                            //     data.docs[index]["workout"]
                                            //         .contains("Months") ||
                                            //     data.docs[index]["workout"]
                                            //         .contains("month"))
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width*.45,
                                                  child: Text(
                                                    "Package : ${data.docs[index]["booking_plan"]??""}",
                                                    style: GoogleFonts.poppins(
                                                        color: HexColor("3A3A3A"),
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                ),
                                                Text(
                                                  "",
                                                  // data.docs[index]['workout']
                                                  //     .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: HexColor("3A3A3A"),
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            // if (
                                            // data.docs[index]['workout']
                                            //     .contains("Pay") ||
                                            //     data.docs[index]['workout']
                                            //         .contains("pay"))

                                            /////////otp section
                                            //   Container(
                                            //
                                            //     decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(6),
                                            //       color: Colors.black,
                                            //     ),
                                            //     child: Padding(
                                            //       padding: const EdgeInsets.all(4.0),
                                            //       child: Text(
                                            //         "OTP:- ${data.docs[index]["otp_pass"]??""}",
                                            //         // "data.docs[index]['workout'].toUpperCase()",
                                            //         style: GoogleFonts.poppins(
                                            //             fontSize: 12,
                                            //             color: Colors.white,
                                            //             fontWeight: FontWeight.w700),
                                            //       ),
                                            //     ),
                                            //   ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Ends on : ",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("A3A3A3"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                Text(
                                                  // "",

                                                  "${DateFormat("MMMM,dd,yyyy").format(end_time.toDate())}",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("A3A3A3"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: document[index]["booking_status"].toString().toLowerCase()=="completed"? Colors.purple:Colors.red,
                                                      shape: BoxShape.circle),
                                                  width: 6,
                                                  height: 6,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "${document[index]["booking_status"]}",
                                                  // "data.docs[index]['type'].toUpperCase()",
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
                                      )),
                                  // Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: CachedNetworkImage(
                                          // ""
                                          maxWidthDiskCache: 400,
                                          maxHeightDiskCache: 420,
                                          fit: BoxFit.cover,
                                          height: 150,
                                          imageUrl: data.docs[index]['gym_details']["image"],
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Container(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ):Center(
                child: Image.asset(
                  "assets/icons/activeEmpty.png",
                  height: _width * 0.8,
                ),
              ),
            );
          }
          return Center(
            child: Image.asset(
              "assets/icons/activeEmpty.png",
              height: _width * 0.8,
            ),
          );
        });
  }
}
