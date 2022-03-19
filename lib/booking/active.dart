import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/global_snackbar.dart';
import '../OrderDetails/order_details.dart';

// ignore: must_be_immutable
class ActiveEvent extends StatefulWidget {
  ActiveEvent({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);
  final double _width;

  @override
  State<ActiveEvent> createState() => _ActiveEventState();
}

class _ActiveEventState extends State<ActiveEvent> {
  ActiveBookingApi activeBookingApi = ActiveBookingApi();

  var gym_data;

  getGymDetails(String x) async {
    var data;
    var userData = await FirebaseFirestore.instance
        .collection("product_details")
        .doc(x)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = documentSnapshot.data();
      }
    });
    if (gym_data == null) {
      setState(() {
        gym_data = data;
      });
    }
    // );
  }

  //
  //   }else{
  //     GlobalSnacbar();
  //   }
  // }

  // print(userData);
  // setState(() {
  //   return userData.data();
  // }
  // );

  // return userData.data();
  // }
  List booking_data = [];

  Future getData() async {
    final data = await FirebaseFirestore.instance
        .collection("bookings")
        .doc(number)
        .collection("user_booking")
        .get();
    // print(data);
    booking_data = data.docs;
    // print(booking_data);
    return data;
  }
var gymData;
  Future getGymData(String s) async {
    final data = await FirebaseFirestore.instance
        .collection("product_details")
        .doc(s)
        .get().then((DocumentSnapshot snapshot){
          // setState(() {
            gymData= snapshot.data();
          // });
      // print(gymData["name"]);

    });
    // print(gymData);
    // return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: booking_data.length,
              itemBuilder: (context, index) {
// getGymDetails(data.docs[index]['vendorId']);
//                 print(gym_data);
                DateTime x = DateTime.parse(booking_data[index]
                        ['plan_end_duration']
                    .toDate()
                    .toString());
                DateTime endDate = DateTime(x.year, x.month, x.day);
                 getGymData(booking_data[index]["vendorId"].toString());
                // var gym_name=gymData["name"];
                // print(gym_name.toString());
//               DocumentSnapshot? data= snapshot.data.;
                return
    gymData ==null?
Container(
)
    :
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => OrderDetails(
// index: index,
// orderList: data.docs,
// )));
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 8,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  width: widget._width * 0.9,
                                  child: Row(
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 22.0,
                                                left: 18,
                                                bottom: 22),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Booking ID : " +
                                                      "${booking_data[index]["booking_id"]}",
// data.docs[index]['booking_id'],
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  // "",
                                                  "${booking_data[index]["gym_name"]}",
// ??
//     "",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                      "",
                                                      // gym_data[index]["branch"],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: HexColor(
                                                                  "3A3A3A"),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
// if (data.docs[index]["workout"]
//         .contains("months") ||
//     data.docs[index]["workout"]
//         .contains("Months") ||
//     data.docs[index]["workout"]
//         .contains("month"))
                                                Row(
                                                  children: [
                                                    Text(
                                                      // "",
                                                      "Package : ${booking_data[index]["booking_plan"] ?? ""}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: HexColor(
                                                                  "3A3A3A"),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    Text(
                                                      "",
// data.docs[index]['workout']
//     .toUpperCase(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color: HexColor(
                                                                  "3A3A3A"),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
// if (data.docs[index]['workout']
//         .contains("Pay") ||
//     data.docs[index]['workout']
//         .contains("pay"))
                                                Text(
                                                  "${gym_data != null ? [
                                                      "branch"
                                                    ] : ""}",
// data.docs[index]['workout']
//     .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: HexColor("3A3A3A"),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Ends on : ${endDate.day}/${endDate.month}/${endDate.year}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: HexColor(
                                                                    "A3A3A3"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      Text(
// '${data.docs[index][]}',
                                                        "",
// "${x.day}/${x.month}/${x.year}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: HexColor(
                                                                    "A3A3A3"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: HexColor(
                                                              "49C000"),
                                                          shape:
                                                              BoxShape.circle),
                                                      width: 6,
                                                      height: 6,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "active",
// data.docs[index]['package_type']
//     .toUpperCase(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: HexColor(
                                                                  "3A3A3A"),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ))));
              });
        });
  }
}
