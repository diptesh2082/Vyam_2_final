import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vyam_2_final/OrderDetails/order_details.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/controllers/gym_detail.dart';
// import 'package:vyambooking/List/list.dart';
// import 'package:vyambooking/OrderDetails/order_details.dart';

class UpcomingEvent extends StatelessWidget {
  UpcomingApi upcomingApi = UpcomingApi();
  UpcomingEvent({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  final double _width;
  List events = [];

  Future upcomingEventsList() async {
    // events = upcomingItems;
    await Future.delayed(const Duration(milliseconds: 500));
    if (events.isNotEmpty) {
      return events;
    }
    if (events.isEmpty) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: upcomingApi.getUpcomingEvents,
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
                  "assets/icons/upcomingEmpty.png",
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
                    // var end_time= data.docs[index]['plan_end_duration'];
                    var start_time=data.docs[index]['booking_date'];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const OrderDetails(
                            // index: index,
                            // orderList: data.docs,
                          ),
                              arguments: {
                                "doc":data.docs[index]
                              }
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
                                            top: 4.0, left: 6, bottom: 4,right: 6),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Booking ID : ${data.docs[index]['id']??""}",
                                              style: GoogleFonts.poppins(
                                                  color: HexColor("3A3A3A"),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 2,
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
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 4.5,
                                                ),
                                                Text(
                                                  "${data.docs[index]["gym_details"]["branch"]??""}",
                                                  // data.docs[index]['gym_name'],
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            // const SizedBox(
                                            //   height: 3,
                                            // ),
                                            // if (
                                            // data.docs[index]["workout"]
                                            //     .contains("months") ||
                                            //     data.docs[index]["workout"]
                                            //         .contains("Months") ||
                                            //     data.docs[index]["workout"]
                                            //         .contains("month"))
                                            Row(
                                              children: [
                                                Text(
                                                  "Package : ${data.docs[index]["booking_plan"]??""}",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w700),
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
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            // if (
                                            // data.docs[index]['workout']
                                            //     .contains("Pay") ||
                                            //     data.docs[index]['workout']
                                            //         .contains("pay"))
                                            Container(

                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Color(0xff292F3D),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "OTP:- ${data.docs[index]["otp_pass"]??""}",
                                                  // "data.docs[index]['workout'].toUpperCase()",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Starts on : ",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("A3A3A3"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                Text(
                                                  // "",

                                                  "${DateFormat("MMMM,dd,yyyy").format(start_time.toDate())}",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("A3A3A3"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor("EACE09"),
                                                      shape: BoxShape.circle),
                                                  width: 6,
                                                  height: 6,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  "upcoming",
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
                                          // "",

                                          fit: BoxFit.cover,
                                          height: 150,
                                          imageUrl: data.docs[index]['gym_details']["image"],
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress,),
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
                  "assets/icons/upcomingEmpty.png",
                  height: _width * 0.8,
                ),
              ),
            );
          }
          return Center(
            child: Image.asset(
              "assets/icons/upcomingEmpty.png",
              height: _width * 0.8,
            ),
          );
        });
  }
}
