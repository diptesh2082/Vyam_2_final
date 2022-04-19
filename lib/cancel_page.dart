import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/OrderDetails/order_details.dart';

import 'api/api.dart';
import 'golbal_variables.dart';

class MyChoice {
  String choice;
  int index;
  MyChoice({required this.choice, required this.index});
}

class CancelDetails extends StatefulWidget {
  CancelDetails({required this.bookingId});
  var bookingId;

  @override
  State<CancelDetails> createState() => _CancelDetailsState();
}

class _CancelDetailsState extends State<CancelDetails> {
  String default_choice =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit blaba ksan sajfoowe.";
  int default_index = 0;

  TextEditingController cancelremark = TextEditingController();

  List<MyChoice> choices = [
    MyChoice(
        choice:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit blaba ksan sajfoowe.",
        index: 0),
    MyChoice(
        choice:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit blaba ksan sajfoowe.",
        index: 1),
    MyChoice(
        choice:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit blaba ksan sajfoowe.",
        index: 2),
    MyChoice(
        choice:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit blaba ksan sajfoowe.",
        index: 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Cancellation Details',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Reasons for Cancellation',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: choices
                    .map((data) => RadioListTile(
                        title: Text(
                          '${data.choice}',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        contentPadding: const EdgeInsets.only(left: 4),
                        activeColor: Colors.amber.shade400,
                        value: data.index,
                        groupValue: default_index,
                        onChanged: (value) {
                          setState(() {
                            default_choice = data.choice;
                            default_index = data.index;
                          });
                        }))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: SizedBox(
                height: 120,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      controller: cancelremark,
                      maxLines: 10,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintMaxLines: 4,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Add remarks or suggestions'),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 58.0, left: 8, right: 8),
                child: SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          content: SizedBox(
                            height: 160,
                            width: 160,
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Text(
                                    "Are you sure ?",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "You want to cancel ?",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Image.asset("assets/icons/icons8-approval.gif",
                                        //   height: 70,
                                        //   width: 70,
                                        // ),

                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await FirebaseFirestore.instance
                                                .collection("bookings")
                                                .doc(number)
                                                .collection("user_booking")
                                                .doc(widget.bookingId)
                                                .update({
                                              "booking_status": "cancel"
                                            });

                                            Map<String, dynamic> cancel_data = {
                                              "cancel_remark":
                                                  cancelremark.text,
                                              "cancel_choice": default_choice,
                                            };
                                            FirebaseFirestore.instance
                                                .collection("Cancellation Data")
                                                .add(cancel_data);
                                            cancelremark.clear();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderDetails()));
                                          },
                                          child: Container(
                                              height: 20,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                  color: HexColor("292F3D"),
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4,
                                                    right: 3,
                                                    top: 2,
                                                    bottom: 2),
                                                child: Center(
                                                  child: Text(
                                                    "yes",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            HexColor("FFFFFF")),
                                                  ),
                                                ),
                                              )),
                                        ),
                                        const SizedBox(width: 15),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             OrderDetails()));
                                          },
                                          child: Container(
                                              height: 20,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                  color: HexColor("292F3D"),
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4,
                                                    right: 3,
                                                    top: 2,
                                                    bottom: 2),
                                                child: Center(
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            HexColor("FFFFFF")),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
