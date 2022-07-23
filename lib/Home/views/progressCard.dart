import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../golbal_variables.dart';

class ProgressCard extends StatelessWidget {
   ProgressCard({Key? key}) : super(key: key);


  double finaldaysLeft = 0;
  double progress = 0;
  var getPercentage;
  var progressColor;
  var getdata;
  var textColor;
  var user_data;
  String getDays = '0';
  int totalDays = 0;
  var myaddress;
  var address;
  bool isLoading = true;
  var value2;
  var day_left;
  // bool showCard = false;
  getProgressStatus() async {
    try{
      int finalDate = int.parse(getDays);
      print(getDays);
      print("++++++++++++++++++++++++++++++++++++++++++++++++");
      finalDate = totalDays - finalDate;
      finaldaysLeft = finalDate / totalDays;
      day_left = totalDays - int.parse(getDays);
      // progress=double.parse((100 * getDays/totalDays).toInt());

      getPercentage = 100 * int.parse(getDays.toString()) / totalDays;
      progress = (double.parse(getPercentage.toString()) / 100);
      // locationController.YourLocation(location);
      print("reytedry///////////${getPercentage}");
      if (getPercentage >= 90) {
        progressColor = Colors.red;
        textColor = Colors.red;
        // showCard = true;
      }
      if (getPercentage <= 89 && getPercentage >= 75) {
        // showCard = true;

        progressColor = const Color.fromARGB(255, 255, 89, 0);
        textColor = const Color.fromARGB(255, 255, 89, 0);
      }
      if (getPercentage <= 74 && getPercentage >= 50) {
        progressColor = Colors.orange;
        textColor = Colors.orange;
        // showCard = true;
      }
      if (getPercentage <= 49 && getPercentage >= 0) {
        progressColor = Colors.yellow;
        textColor = Colors.amberAccent;
        // showCard = true;
      } else {
        // showCard = false;
      }
    }catch(e){
      // showCard=false;
    }
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
      // .doc(number)
      // .collection("user_booking")
          .where("userId", isEqualTo: number)
          .where("booking_status", isEqualTo: "active")
          .orderBy("id",descending: true)
          .snapshots(),
      builder: (context,AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child:  const SizedBox());
        }
        if (snapshot.hasError) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.hasData) {
          final data = snapshot.requireData;
          if (data.size == 0) {
            return const SizedBox();
          }

          var document = snapshot.data.docs;
          print("dee/////////////////");
          print(document);

          return document.isNotEmpty
         ? ListView.builder(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemCount: 1,
            itemBuilder: (context,int index) {


                getDays = (DateTime.now().difference(data.docs[index]["booking_date"].toDate()).inDays).toString() ;

                totalDays =(data.docs[index]["plan_end_duration"].toDate().difference(data.docs[index]["booking_date"].toDate()).inDays) ;
                totalDays=totalDays.abs();
                print(totalDays);
                print(getDays);
                if (totalDays==0){
                  totalDays=1;
                }
                // if (getDays==0){
                //   getDays="1";
                // }
                print("--------------------------------------------${data.docs[index]["booking_id"]}");
                final percent = double.parse(
                    (100 * int.parse(getDays.toString()) ~/ totalDays)
                        .toStringAsFixed(1));
                print(percent);
                print(percent);
                getProgressStatus();
                if(percent>=0.000000000000000000000000000000000000000000 && int.parse(getDays) >= 0){
                  return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child:
                      // StreamBuilder<QuerySnapshot>(
                      //             stream: FirebaseFirestore.instance
                      //                 .collection('bookings')
                      //             // .doc(number)
                      //             // .collection("user_booking")
                      //                 .where("userId", isEqualTo: number)
                      //                 .where("booking_status", isEqualTo: "active")
                      //                 .orderBy("id",descending: true)
                      //                 .snapshots(),
                      //             builder: (context, AsyncSnapshot snapshot) {
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return const Center(child: CircularProgressIndicator());
                      // }
                      // if (snapshot.hasError) {
                      //   return const SizedBox();
                      // }
                      // if (!snapshot.hasData) {
                      //   return Container();
                      // }
                      // if (snapshot.hasData) {
                      //   final data = snapshot.requireData;
                      //   if (data.size == 0) {
                      //     return const SizedBox();
                      //   }
                      //   var document = snapshot.data.docs;
                      //   print("dee/////////////////");
                      //   print(document);

                      // return document.isNotEmpty
                      //   ? ListView.builder(
                      // shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      // itemCount: document.length,
                      // itemBuilder: (context, index) {
                      //
                      //
                      //
                      //   getDays = (DateTime.now().difference(data.docs[index]["booking_date"].toDate()).inDays).toString() ;
                      //
                      //   totalDays =(data.docs[index]["plan_end_duration"].toDate().difference(data.docs[index]["booking_date"].toDate()).inDays) ;
                      //   totalDays=totalDays.abs();
                      //   print(totalDays);
                      //   print(getDays);
                      //
                      //   final percent = double.parse(
                      //       (100 * int.parse(getDays.toString()) ~/ totalDays)
                      //           .toStringAsFixed(1));
                      //   print(percent);
                      //   print(percent);
                      //   getProgressStatus();
                      //   if(percent>=0.000000000000000000000000000000000000000000 && int.parse(getDays) >= -1){
                      //     return
                      Stack(
                        children: [
                          Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(children: [
                                  if (finaldaysLeft != 0)
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                day_left != null
                                                    ? day_left.toString()
                                                    : "",
                                                style: GoogleFonts.poppins(
                                                    color: textColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text("days to go",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        Text(
                                            data.docs[index]['gym_details']
                                            ["name"] ??
                                                "",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        Text("Stay Strong !",
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  if (finaldaysLeft == 0)
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                              "Your Subscription has been expired",
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print("buy");
                                          },
                                          child: Text("Buy new packages",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  const Spacer(),
                                  CircularPercentIndicator(
                                    animation: true,
                                    radius: 44,
                                    lineWidth: 12.0,
                                    percent: progress,
                                    progressColor: progressColor,
                                  ),
                                ]),
                              )),
                          Positioned(
                            right: MediaQuery.of(context).size.width * .0895,
                            bottom: 53,
                            child: Text(
                              "${percent}%",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                  );
                }

                          // }
                          return SizedBox();
                        },
                      )
                          : Container();
                    }
                    return const SizedBox();
                  });
              // },}
            // );
        }
      // ),
    // );
  // }
}
