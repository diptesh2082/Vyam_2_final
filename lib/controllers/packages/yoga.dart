import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/controllers/packages/bookingDetails.dart';
import 'package:vyam_2_final/global_snackbar.dart';
import 'package:vyam_2_final/golbal_variables.dart';

class YogaList extends StatefulWidget {
  final getDocID;
  final gymLocation;
  final gymName;
  // final iiid;
  final type;
  final image;
  final branch;
  var isLoading;
  final doc;
  // final isLoading;
  YogaList({
    Key? key,
    required double width,
    required this.getDocID,
    required this.gymName,
    required this.gymLocation,
    required this.type,
    required this.image,
    required this.branch,
    required this.isLoading,
    required this.doc,
  })  : _width = width,
        super(key: key);
  // required this.iiid,required this.type,

  final double _width;

  @override
  State<YogaList> createState() => _YogaListState();
}

class _YogaListState extends State<YogaList> {
  BookingDetails bookingDetails = BookingDetails();

  GlobalSnacbar globalSnacbar = GlobalSnacbar();
  final bookings = FirebaseFirestore.instance
      .collection("bookings")
      .doc(number)
      .collection("user_booking");
  final id = FirebaseFirestore.instance
      .collection("bookings")
      .doc(number)
      .collection("user_booking")
      .doc()
      .id
      .toString();

  get dateTime => DateTime.now();
  int? booking_iiid;
  // getBookingId(id) async {
  //   print("//////////" + id);
  //   var db = FirebaseFirestore.instance.collection("bookings").doc(id);
  //   await FirebaseFirestore.instance
  //       .collection("bookings")
  //       .where("booking_status".toLowerCase(),
  //           whereIn: ["completed", "active", "upcoming", "cancelled"])
  //       .get()
  //       .then((value) async {
  //         if (value.docs.isNotEmpty) {
  //           booking_iiid = await value.docs.length;
  //         }
  //       })
  //       .then((value) async {
  //         print(booking_iiid);
  //         await CreateBooking(id, booking_iiid!);
  //       });
  //
  //   // coupon_list=
  // }

  CreateBooking(String id) async {
    final bookings = await FirebaseFirestore.instance.collection("bookings");
    // .doc(number)
    // .collection("user_booking");
    // print(bookings);

    await bookings.doc(id).set({
      "booking_id": id,
      "booking_status": "incomplete",
      "order_date": DateTime.now(),
      // "gym_name": "",
      "vendorId": widget.getDocID,
      "userId": number,
      "user_name": Get.find<GlobalUserData>().userData.value["name"],
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
        "image": widget.image,
        "name": widget.gymName,
        "branch": widget.branch
      },
      "daysLeft": "0",
      "discount": "0",
      "grand_total": "",
      "tax_pay": "",
      "totalDays": "0",
      "total_price": "",
      "id": "",
      "payment_method": "offline"

      // "gym_details":{
      //   "name":widget.gymName
      // },
    });

    setState(() {
      widget.isLoading = false;
    });
    // FirebaseFirestore.instance
    //     .collection("bookings")
    //     .doc(id)
    //     .update({
    //   // "gym_name": widget.gymName,
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          title: Text("${widget.type.toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: HexColor("3A3A3A"),
                  fontWeight: FontWeight.w600)),
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("product_details")
                  .doc(widget.getDocID)
                  .collection("package")
                  .doc("normal_package")
                  .collection("gym")
                  .where("type", isEqualTo: "${widget.type.toString()}")
                  .orderBy("index")
                  .snapshots(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  globalSnacbar.showError(
                      "Something went wrong", "Please try again");
                }
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  if (data.size == 0) {
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
                  }
                  // print(data.size);
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: widget._width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        data.docs[snapshot]['title']
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
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
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (int.parse(data.docs[snapshot]
                                                      ['discount']) >
                                                  0)
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5.0),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2.0,
                                                          left: 5,
                                                          right: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: HexColor(
                                                              "49C000"))),
                                                  child: Text(
                                                    data.docs[snapshot]
                                                                ["ptype"] ==
                                                            true
                                                        ? data.docs[snapshot]
                                                                ['discount'] +
                                                            "% off"
                                                        : data.docs[snapshot]
                                                                ['discount'] +
                                                            " Rs off",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9,
                                                        color:
                                                            HexColor("49C000")),
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  if (int.parse(
                                                          data.docs[snapshot]
                                                              ["discount"]) >
                                                      0)
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
                                                              FontWeight.w600),
                                                    ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    "Rs "
                                                    "${data.docs[snapshot]["ptype"] == true ? (int.parse(data.docs[snapshot]["original_price"]) - (int.parse(data.docs[snapshot]["original_price"]) * int.parse(data.docs[snapshot]["discount"]) / 100).round()) : (int.parse(data.docs[snapshot]["original_price"]) - (int.parse(data.docs[snapshot]["discount"])))}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color:
                                                            HexColor("3A3A3A"),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Inc. of all taxes",
                                            style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                color: HexColor("B2B2B2"),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      RaisedButton(
                                        elevation: 0,
                                        onPressed: () async {
                                          // await CreateBooking(id);
                                          // FirebaseFirestore.instance.collection("bookings")
                                          //     .doc(number)
                                          //     .collection("user_booking")
                                          //     .doc(id)
                                          //     .update(
                                          //     {
                                          //       "order_date": dateTime,
                                          //       "gym_name": widget.gymName,
                                          //       "vandorId": widget.getDocID
                                          //     }
                                          // )
                                          // ;
                                          bookingDetails.bookingDetails(
                                              context,
                                              snapshot,
                                              data.docs,
                                              data.docs[snapshot]['type'],
                                              widget.gymName,
                                              widget.gymLocation,
                                              id,
                                              widget.getDocID,
                                              widget.doc,
                                              data.docs[snapshot]
                                                  ['description'],
                                              widget.branch,
                                              widget.isLoading);
                                          await Future.wait(CreateBooking(id));
                                        },
                                        color: HexColor("292F3D"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text("Buy now",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: HexColor("FFFFFF"),
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
