import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/Home/bookings/cancelpro.dart';
import 'golbal_variables.dart';

class MyChoice {
  String choice;
  int index;
  MyChoice({required this.choice, required this.index});
}

class CancelDetails extends StatefulWidget {
  CancelDetails({required this.bookingId, required this.vendor_name,required this.id,required this.vendorId,required this.branch});
  var bookingId;
  final vendor_name;
  final id;
  final vendorId;
  final branch;

  @override
  State<CancelDetails> createState() => _CancelDetailsState();
}

class _CancelDetailsState extends State<CancelDetails> {
  String default_choice =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit blaba ksan sajfoowe.";
  int default_index = 0;

  TextEditingController cancelremark = TextEditingController();
  var doc = Get.arguments["doc"];
  var choices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
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
        child: SizedBox(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Cancellation Data").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                    child: Text("check your internet connection"));
              }
              if (snapshot.hasData==false) {
                return const Center(
                    child: Text("check your internet connection"));
              }
              choices=snapshot.data!.docs;
              List doc=[];
              int i=0;
              choices.forEach((e){
                doc.add(e);
              });


              return Column(
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
                    child:
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                            title: Text(
                              '${doc[index]["cancel_remark"]}',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            contentPadding: const EdgeInsets.only(left: 4),
                            activeColor: Colors.amber.shade400,
                            value:index,
                            groupValue: default_index,
                            onChanged: (value) {
                              setState(() {
                                default_choice = doc[index];
                                default_index =index;
                              });
                            });
                      }
                    )

                    //   }
                    // ),
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
                                  height: 170,
                                  width: 280,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Are you sure you wanna cancel ?",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) {
                                                //         return HomePage();
                                                //       }),
                                                // );
                                              },
                                              child: Container(
                                                  height: 38,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      color: HexColor("FFECB2"),
                                                      borderRadius:
                                                          BorderRadius.circular(8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 3,
                                                        right: 3,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                HexColor("030202")),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            // Image.asset("assets/icons/icons8-approval.gif",
                                            //   height: 70,
                                            //   width: 70,
                                            // ),

                                            const SizedBox(width: 15),
                                            GestureDetector(
                                              onTap: () async {
                                                // Navigator.pop(context);
                                                try {
                                                  await FirebaseFirestore.instance
                                                      .collection("bookings")
                                                      .doc(widget.bookingId)
                                                      .update({
                                                    "booking_status": "cancelled"
                                                  });

                                                  Map<String, dynamic> cancel_data = {
                                                    "cancel_remark":
                                                        cancelremark.text,
                                                    "cancel_choice": default_choice,
                                                    "booking_id":widget.id,
                                                    "bookingId":widget.bookingId,
                                                    "vendor_id":widget.bookingId,
                                                    "vendor_name":widget.vendor_name,
                                                    "user_name":GlobalUserData["name"],
                                                    "user_number":GlobalUserData["userId"],
                                                    "time_stamp":DateTime.now(),
                                                    "branch":widget.branch
                                                  };
                                                 await FirebaseFirestore.instance
                                                      .collection("Cancellation Data")
                                                      .add(cancel_data);
                                                  cancelremark.clear();
                                                  await FirebaseFirestore.instance
                                                      .collection("booking_notifications")
                                                      .doc()
                                                      .set({
                                                    "title": "booking Activated",
                                                    "status":"cancelled",
                                                    // "payment_done": false,
                                                    "user_id":number.toString(),
                                                    "user_name":GlobalUserData["name"],
                                                    "vendor_id":widget.vendorId,
                                                    "vendor_name":widget.vendor_name,
                                                  });
                                                  // Get.snackbar("Your Booking Status", "Your Booking Cancelled",
                                                  //     icon: Image.asset("assets/icons/vyam.png")
                                                  // );
                                                  Get.offAll(() => BooKingCancelation(
                                                        doc: doc,
                                                      ));
                                                  // Get.off(()=>ActiveOrderDetails( ),
                                                  //     arguments: {
                                                  //       "doc":doc
                                                  //     }
                                                  // );
                                                } catch (e) {
                                                  printError();
                                                }
                                              },
                                              child: Container(
                                                  height: 38,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      color: HexColor("27AE60"),
                                                      borderRadius:
                                                          BorderRadius.circular(8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 3,
                                                        right: 3,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Center(
                                                      child: Text(
                                                        "Proceed",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                HexColor("030105")),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            ;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
