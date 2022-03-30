import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/Home/bookings/review_screen.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';


class AddReview extends StatefulWidget {
  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController title = TextEditingController();
  TextEditingController exp = TextEditingController();
  double ratingvalue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Write a Review',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            label: const Text(
              'Submit',
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.white),
            ),
            backgroundColor: Colors.black,
            onPressed: () async {
              Navigator.of(context).pop();
              final CollectionReference review =
                  FirebaseFirestore.instance.collection('Reviews');
              FirebaseFirestore.instance.runTransaction((transaction) async {
                CollectionReference reference =
                    FirebaseFirestore.instance.collection('Reviews');
                Map<String, dynamic> review_data = {
                  "rating": ratingvalue.toString(),
                  "title": title.text,
                  "experience": exp.text
                };
                await reference
                    .doc("${Get.arguments["gym_id"]}")
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        // height: MediaQuery.of(context).size.height / 2.22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(
              // height: MediaQuery.of(context).size.height * 0.022,
              height: 22,
            ),
            // Text(
            //   ratingvalue != null ? ratingvalue.toString() : 'Rate it'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Add a title',
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height / 12,
                height: 60,
                child: Card(
                    child: TextField(
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  controller: title,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 10,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      hintMaxLines: 2,
                      hintText: 'Sum up your experience in one line.'),
                )),
              ),
            ),
            const SizedBox(
              height: 22,
              // height: MediaQuery.of(context).size.height * 0.022,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Add a written review',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'poppins',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: SizedBox(
                height: 90,
                // height: MediaQuery.of(context).size.height / 8,
                child: Card(
                  child: TextField(
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'poppins',
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
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        hintText:
                            'What did you like or dislike? What was your overall experience.'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
