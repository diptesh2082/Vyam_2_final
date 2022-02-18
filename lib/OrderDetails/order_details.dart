import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.index, required this.orderList})
      : super(key: key);
  final index;
  final orderList;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List getOderDetails = [];

  @override
  void initState() {
    getOderDetails = widget.orderList;
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  getOderDetails[widget.index]['image'],
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                              ),
                            )),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 22.0, bottom: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Booking ID : " +
                                          getOderDetails[widget.index]['id'],
                                      style: GoogleFonts.poppins(
                                          color: HexColor("3A3A3A"),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      getOderDetails[widget.index]['gym_name'],
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
                                          getOderDetails[widget.index]
                                              ['location'],
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
                                                  getOderDetails[widget.index]
                                                      ['end_date'],
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
                                        Padding(
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
                                                "OTP : " +
                                                    getOderDetails[widget.index]
                                                        ['otp'],
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
                                          onTap: () async {
                                            var number =
                                                getOderDetails[widget.index]
                                                    ['phone_number'];
                                            FlutterPhoneDirectCaller.callNumber(
                                                number);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: HexColor("292F3D"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
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
              Card(
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
                      children: [
                        Row(
                          children: [
                            Text(
                              "Workout",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            if (getOderDetails[widget.index]['workout']
                                .contains("Pay"))
                              Text(
                                getOderDetails[widget.index]['workout']
                                    .toUpperCase(),
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            if (getOderDetails[widget.index]['workout']
                                .contains("Months"))
                              Row(
                                children: [
                                  Text(
                                    "Gym - ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    getOderDetails[widget.index]['workout']
                                        .toUpperCase(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Package",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              getOderDetails[widget.index]['workout']
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Start date",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              getOderDetails[widget.index]['start_date'],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Valid upto",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              getOderDetails[widget.index]['end_date'],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
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
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Total amount",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              "Rs " +
                                  getOderDetails[widget.index]['total_amount'],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Discount",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              getOderDetails[widget.index]['discount'],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Promo code",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Text(
                              getOderDetails[widget.index]['promocode'],
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Grand Total",
                              style: GoogleFonts.poppins(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("27AE60")),
                            ),
                            const Spacer(),
                            Text(
                              "Rs " +
                                  getOderDetails[widget.index]['grand_total'],
                              style: GoogleFonts.poppins(
                                  fontSize: 21,
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
                    Container(
                        decoration: BoxDecoration(
                            color: HexColor("292F3D"),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 6, bottom: 6),
                          child: Text(
                            "Cancel Order",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: HexColor("FFFFFF")),
                          ),
                        )),
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
      ),
    );
  }
}
