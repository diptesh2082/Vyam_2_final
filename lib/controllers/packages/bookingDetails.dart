import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/DatePickerScreen.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../../select_date.dart';

class BookingDetails {

  void bookingDetails(context, index, bookingList, String gymType, getGymName,
      gymLocation, booking_id, gymID, docs,iiid) {
    List newBookingList = bookingList;
    var booking=0;
    // final userDetails=FirebaseFirestore.instance.collection("user_details").doc(number).get();

    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return SizedBox(
            width: _width,
            // color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: _height * 0.18,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            HexColor("FF8008"),
                            HexColor("FFC837"),
                          ])),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Rs "
                              "${int.parse(bookingList[index]["original_price"]) - (int.parse(bookingList[index]["original_price"]) * int.parse(bookingList[index]["discount"]) / 100).round()}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w700),
                            ),
                            if (newBookingList[index]['title'] !=
                                "Pay per session")
                              Text(
                                "Validity : " +
                                    bookingList[index]['validity']
                                        .toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 25,
                        top: 20,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.cancel_sharp)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 10, right: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gymType +
                                          newBookingList[index]['title']
                                              .toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: HexColor("3A3A3A"),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    if (newBookingList[index]['title'] !=
                                        "Pay per session")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Package validity",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: HexColor("AAAAAA"),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            newBookingList[index]['validity']
                                                .toUpperCase(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: HexColor("000000"),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Details",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: HexColor("AAAAAA"),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "• Pay only for the day you workout.\n• No membership or admission charge required.\n• Book for single/multiple days.",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: HexColor("3A3A3A"),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Note - if you book for an off-day, dont worry it will get adjusted.",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: HexColor("3A3A3A"),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (newBookingList[index]['title'] !=
                                        "Pay per session")
                                      Text(
                                        "100% safe and secure",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: HexColor("3A3A3A"),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: MaterialButton(
                                        color: HexColor("292F3D"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        onPressed: () {
                                          print(booking_id);
                                          FirebaseFirestore.instance
                                              .collection("bookings")
                                              // .where("booking_id", isEqualTo: )
                                              .doc(booking_id)
                                              .update({
                                            // "time_stamp":serv
                                            "booking_plan":
                                                newBookingList[index]['title'],
                                            "booking_price": (int.parse(
                                                        bookingList[index][
                                                            "original_price"]) -
                                                    (int.parse(bookingList[
                                                                    index][
                                                                "original_price"]) *
                                                            int.parse(bookingList[
                                                                    index]
                                                                ["discount"]) /
                                                            100)
                                                        .round())
                                                .toDouble(),
                                            "package_type": bookingList[index]
                                                ['type'],
                                            "gym_address": gymLocation,
                                            "id":iiid.toString()
                                          });
                                          // print(bookingList[index]['title'].toLowerCase());
                                          if(bookingList[index]['title'].toLowerCase()!="pay per session")
                                            {      Get.to(
                                                  () => SelectDate(
                                                months: newBookingList[index]
                                                ['title']
                                                    .toUpperCase(),
                                                price: int.parse(
                                                    bookingList[index]
                                                    ["original_price"]) -
                                                    (int.parse(bookingList[index][
                                                    "original_price"]) *
                                                        int.parse(bookingList[
                                                        index]
                                                        ["discount"]) /
                                                        100)
                                                        .round(),
                                                packageType: bookingList[index]['title'],
                                                getGymName: getGymName,
                                                getGymAddress: gymLocation,
                                                gymId: gymID,
                                                bookingId: booking_id,
                                              ),
                                              arguments: {"docs": docs},
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            );
                                            }else{
                                            Get.to(
                                                  () => DatePickerScreen(
                                                    months: newBookingList[index]
                                                    ['title']
                                                        .toUpperCase(),
                                                    price: int.parse(
                                                        bookingList[index]
                                                        ["original_price"]) -
                                                        (int.parse(bookingList[index][
                                                        "original_price"]) *
                                                            int.parse(bookingList[
                                                            index]
                                                            ["discount"]) /
                                                            100)
                                                            .round(),
                                                    packageType: bookingList[index]
                                                    ['type'],
                                                    getGymName: getGymName,
                                                    getGymAddress: gymLocation,
                                                    gymId: gymID,
                                                    bookingId: booking_id,
                                                  ),
                                              //         SelectDate(
                                              //   months: newBookingList[index]
                                              //   ['title']
                                              //       .toUpperCase(),
                                              //   price: int.parse(
                                              //       bookingList[index]
                                              //       ["original_price"]) -
                                              //       (int.parse(bookingList[index][
                                              //       "original_price"]) *
                                              //           int.parse(bookingList[
                                              //           index]
                                              //           ["discount"]) /
                                              //           100)
                                              //           .round(),
                                              //   packageType: bookingList[index]
                                              //   ['type'],
                                              //   getGymName: getGymName,
                                              //   getGymAddress: gymLocation,
                                              //   gymId: gymID,
                                              //   bookingId: booking_id,
                                              // ),
                                              arguments: {"docs": docs},
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            );
                                          }

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder:
                                          //             (context) => SelectDate(
                                          //           months: newBookingList[
                                          //           index]
                                          //           ['title']
                                          //               .toUpperCase(),
                                          //           price: int.parse(
                                          //               bookingList[
                                          //               index]
                                          //               [
                                          //               "original_price"]) -
                                          //               (int.parse(bookingList[index]
                                          //               [
                                          //               "original_price"]) *
                                          //                   int.parse(bookingList[index]
                                          //                   [
                                          //                   "discount"]) /
                                          //                   100)
                                          //                   .round(),
                                          //           packageType:
                                          //           bookingList[
                                          //           index]
                                          //           ['type'],
                                          //           getGymName:
                                          //           getGymName,
                                          //           getGymAddress:
                                          //           gymLocation,
                                          //               gymId:gymID ,
                                          //               bookingId: booking_id,
                                          //         )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 15),
                                          child: Center(
                                            child: Text(
                                              "Book now",
                                              style: GoogleFonts.poppins(
                                                  color: HexColor("FFFFFF"),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}
