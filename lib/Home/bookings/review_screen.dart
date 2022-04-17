import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vyam_2_final/Home/bookings/add_review.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/colors/color.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import 'gym_details.dart';
class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double ratingvalue = 0;

  TextEditingController title = TextEditingController();
  TextEditingController exp = TextEditingController();
  var _ratingController = TextEditingController();
  GymReviews reviews = GymReviews();
  var doc =Get.arguments ;
  var review;
  final _id=  Get.arguments["gym_id"];
  @override
  void initState() {
    // TODO: implement initState
    print(doc["name"]);
    print(_id);
    // print("25");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Reviews',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          // color: buttonColor,
          width: MediaQuery.of(context).size.width*.9,
          child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              label: const Text(
                'Write a review',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white),
              ),
              backgroundColor: buttonColor,
              onPressed: (){
                Get.to(()=>AddReview(),
                arguments: {
                  "gym_id":_id,
                }
                );
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Customer reviews',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemBuilder: ((context, index) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              }),
                              rating: 4.7,
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            const Text('4.7 out of 5 ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14))
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                        ),
                        const Text(
                          '(113 reviews)',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '5 star',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 9,
                                  backgroundColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  percent: 0.6,
                                  trailing: const Text(
                                    '60%',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  progressColor: Colors.amber,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '4 star',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 9,
                                  backgroundColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  percent: 0.3,
                                  trailing: const Text(
                                    '30%',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  progressColor: Colors.amber,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '3 star',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 9,
                                  backgroundColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  percent: 0.15,
                                  trailing: const Text(
                                    '15%',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  progressColor: Colors.amber,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '2 star',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 9,
                                  backgroundColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  percent: 0.05,
                                  trailing: const Text(
                                    '5%',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  progressColor: Colors.amber,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Text(
                                  '1 star',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 9,
                                  backgroundColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  percent: 0.10,
                                  trailing: const Text(
                                    '10%',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  progressColor: Colors.amber,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 30,
                          indent: 8,
                          endIndent: 20,
                          thickness: 1.2,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<QuerySnapshot>(

                        stream: FirebaseFirestore.instance.collection("Reviews").where("gym_id",isEqualTo: "${_id}"   ).snapshots(),
                        builder: ((context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amberAccent,
                              ),
                            );
                          }
                          var document = snapshot.data.docs;
                          print(document);
                          // document = document.where((element) {
                          //   return  element
                          //       .get('gym_id')
                          //       .toString()
                          //   // .toLowerCase()
                          //       .contains(doc["gym_id"].toString());
                          // }).toList();
                          // print(document.length);
                          return document.isNotEmpty
                              ? Column(
                                children: [
                                  ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: document.length,
                                      itemBuilder: (context, int index) {

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              leading: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
//border: Border.all(width: 1),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/trainer1.png"),
                                                        fit: BoxFit.cover)),
                                              ),
                                              title: Text(
                                                // "",
                                                document[index]["title"],
// snapshot.data.docs[index]['name'],
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              subtitle: Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RatingBarIndicator(
                                                    itemBuilder: ((context, index) {
                                                      return const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      );
                                                    }),
                                                    rating: double.parse(document[index]['rating']),
                                                    itemCount: 5,
                                                    itemSize: 18.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                   Text(
                                                    // "",
                                                    document!=null?document[index]["experience"] ?? "":"",
// snapshot.data.docs[index]['experience'],
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider();
                                      },
                                    ),
                                ],
                              )
                              : const Center(
                                  child: Text(
                                    "No Review",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontFamily: "Poppins",
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                        })),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future openreviewcard() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final CollectionReference review =
                         FirebaseFirestore.instance.collection('Reviews');
                    FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      CollectionReference reference =
                          FirebaseFirestore.instance.collection('Reviews');
                      Map<String, dynamic> review_data = {
                        "rating": ratingvalue.toString(),
                        "title": title.text,
                        "experience": exp.text
                      };
                      await reference
                          .doc("GYM")
                          .collection(number)
                          .add(review_data);

                      title.clear();
                      exp.clear();

                      /* FirebaseFirestore.instance
                          .collection("user_details")
                          .add(review_data);*/
                    });
                  },
                ),
              ),
            ],
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 2.22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                  RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.amber,
                        ),
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          ratingvalue = value;
                        });
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.022,
                  ),
                  // Text(
                  //   ratingvalue != null ? ratingvalue.toString() : 'Rate it'),
                  const Text(
                    'Add a title',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: Card(
                        child: TextField(
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      controller: title,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintMaxLines: 2,
                          hintText: 'Sum up your experience in one line.'),
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.022,
                  ),
                  const Text(
                    'Add a written review',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: Card(
                      child: TextField(
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        controller: exp,
                        maxLines: 10,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintMaxLines: 4,
                            hintStyle: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            hintText:
                                'What did you like or dislike? What was your overall experience.'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
}

// ListView.builder(
// shrinkWrap: true,
// itemCount: document.length,
// itemBuilder: (context, index) {
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// ListTile(
// leading: Container(
// height: 50,
// width: 50,
// decoration: const BoxDecoration(
// shape: BoxShape.circle,
// //border: Border.all(width: 1),
// image: DecorationImage(
// image: AssetImage(
// "assets/images/trainer1.png"),
// fit: BoxFit.cover)),
// ),
// title: Text(
// document["review"],
// // snapshot.data.docs[index]['name'],
// style: const TextStyle(
// fontFamily: 'Poppins',
// fontWeight: FontWeight.w600,
// fontSize: 12),
// ),
// subtitle: RatingBarIndicator(
// itemBuilder: ((context, index) {
// return const Icon(
// Icons.star,
// color: Colors.amber,
// );
// }),
// rating: ratingvalue,
// itemCount: 5,
// itemSize: 18.0,
// direction: Axis.horizontal,
// ),
// ),
// Text(
// "10",
// // snapshot.data.docs[index]['experience'],
// style: const TextStyle(
// fontFamily: 'Poppins',
// fontWeight: FontWeight.w400,
// fontSize: 12),
// ),
// const SizedBox(
// height: 30,
// )
// ],
// );
// },
// )
