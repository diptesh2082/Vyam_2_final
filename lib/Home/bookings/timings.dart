import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/Home/bookings/review_screen.dart';
import 'gym_details.dart';

// class Timing extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       builder: () => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Timing_Screen(),
//       ),
//     );
//   }
// }

class Timing_Screen extends StatelessWidget {
  final id;

  Timing_Screen({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Timings',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
                FocusManager.instance.primaryFocus?.unfocus();
                // print(doc["timings"]["gym"]);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Review()));
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            )),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("product_details")
                    .doc(id)
                    .collection("timings")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var doc = snapshot.data.docs;
                  return ListView.builder(
                      itemCount: doc.length,
                      itemBuilder: (context, index) {
                        return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            shadowColor: Colors.black,
                            child: doc[index]["timing_id"] != null
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: MediaQuery.of(context).size.height *
                                        0.19,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                doc[index]["timing_id"]
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16)),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        FittedBox(
                                          child: IntrinsicHeight(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 9.0, right: 9.0),
                                                child: Column(
                                                  children: [
                                                    Wrap(
                                                        direction:
                                                            Axis.vertical,
                                                        children: [
                                                          const Text(' Morning',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      14)),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              doc[index][
                                                                      "morning_days"] ??
                                                                  'Monday - Saturday',
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14)),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              doc[index][
                                                                      "Morning"] ??
                                                                  'no Information',
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize:
                                                                      12)),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              doc[index]["closed"] !=
                                                                      null
                                                                  ? "closed ${doc[index]["closed"]}"
                                                                  : 'Sunday closed',
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      12)),
                                                        ])
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                              ),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                              ),
                                              Column(
                                                children: [
                                                  Wrap(
                                                      direction: Axis.vertical,
                                                      children: [
                                                        const Text(' Evening',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                            doc[index][
                                                                    "evening_days"] ??
                                                                "no information",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14)),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                            doc[index][
                                                                    "Evening"] ??
                                                                "no information",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 12)),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                            doc[index]["closed"] !=
                                                                    null
                                                                ? "closed ${doc[index]["closed"] ?? "Sunday closed"}"
                                                                : 'Sunday closed',
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12)),
                                                      ])
                                                ],
                                              ),
                                            ],
                                          )),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(
                                    child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Gym Timings is not available"),
                                  )));
                      });
                })));
  }
}
