import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../select_date.dart';

class BookingDetails {
  void bookingDetails(context, index, bookingList, String gymType, getGymName) {
    List newBookingList = bookingList;

    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    showBottomSheet(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return Stack(
            children: [
              SizedBox(
                height: _height * 0.72,
                width: _width,
                // color: Colors.white,
                child: Column(
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
                                    padding: const EdgeInsets.all(0.0),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 10, right: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    newBookingList[index]
                                                            ['validity']
                                                        .toUpperCase(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: HexColor("000000"),
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                              padding:
                                                  const EdgeInsets.only(left: 8.0),
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
                                              height: 20,
                                            ),
                                            MaterialButton(
                                              color: HexColor("292F3D"),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12)),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) => SelectDate(
                                                                  months: newBookingList[
                                                                              index]
                                                                          ['title']
                                                                      .toUpperCase(),
                                                                  price: int.parse(
                                                                          bookingList[
                                                                                  index]
                                                                              [
                                                                              "original_price"]) -
                                                                      (int.parse(bookingList[index]
                                                                                  [
                                                                                  "original_price"]) *
                                                                              int.parse(bookingList[index]
                                                                                  [
                                                                                  "discount"]) /
                                                                              100)
                                                                          .round(),
                                                                  packageType:
                                                                      bookingList[
                                                                              index]
                                                                          ['type'],
                                                                  getGymName:
                                                                      getGymName,
                                                                )));
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
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
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
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
