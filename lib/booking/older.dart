import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/OrderDetails/older_order_details.dart';
import 'package:vyam_2_final/api/api.dart';

// import 'package:vyambooking/List/list.dart';
// import 'package:vyambooking/OrderDetails/older_order_details.dart';
// import 'package:vyambooking/OrderDetails/order_details.dart';
class OlderEvent extends StatelessWidget {
  OlderBookingApi olderBookingApi = OlderBookingApi();
  OlderEvent({
    Key? key,
    required double width,
  })  : _width = width,
        super(key: key);

  final double _width;
  List events = [];

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
            return Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OlderOderDetails(
                                        index: index,
                                        orderList: data.docs,
                                      )));
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
                            width: _width * 0.9,
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 22.0, left: 20, bottom: 22),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Booking ID : " +
                                                data.docs[index]['id'],
                                            style: GoogleFonts.poppins(
                                                color: HexColor("3A3A3A"),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            data.docs[index]['gym_name'],
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
                                                data.docs[index]['location'],
                                                style: GoogleFonts.poppins(
                                                    color: HexColor("3A3A3A"),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          if (data.docs[index]["workout"]
                                                  .contains("months") ||
                                              data.docs[index]["workout"]
                                                  .contains("Months") ||
                                              data.docs[index]["workout"]
                                                  .contains("month"))
                                            Row(
                                              children: [
                                                Text(
                                                  "Package : ",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  data.docs[index]['workout']
                                                      .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: HexColor("3A3A3A"),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          if (data.docs[index]['workout']
                                                  .contains("Pay") ||
                                              data.docs[index]['workout']
                                                  .contains("pay"))
                                            Text(
                                              data.docs[index]['workout']
                                                  .toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: HexColor("3A3A3A"),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            data.docs[index]['end_date'],
                                            style: GoogleFonts.poppins(
                                                color: HexColor("A3A3A3"),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            data.docs[index]['type'],
                                            style: GoogleFonts.poppins(
                                                color: HexColor("3A3A3A"),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              for (int i = 1;
                                                  i <=
                                                      int.parse(data.docs[index]
                                                          ['rating']);
                                                  i++)
                                                Icon(
                                                  Icons.star,
                                                  color: HexColor("FFC700"),
                                                  size: 15,
                                                ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  "Edit review",
                                                  style: GoogleFonts.poppins(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: HexColor("3A3A3A"),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                Flexible(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    data.docs[index]['image'],
                                    fit: BoxFit.cover,
                                    height: 150,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Center(
            child: Image.asset(
              "assets/icons/olderEmpty.png",
              height: _width * 0.8,
            ),
          );
        });
  }
}
