import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:reviews_slider/reviews_slider.dart';
import 'package:vyam_2_final/Home/bookings/success_book.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/OrderDetails/order_details.dart';
import 'gym_details.dart';
import 'review_screen.dart';

class Feedback1 extends StatefulWidget {
  @override
  _Feedback1State createState() => _Feedback1State();
}

class _Feedback1State extends State<Feedback1> {
  int selectedvalue = 0;
  late String selectedoption;
  List<String> slider_option = ["Bad", "Average", "Good", "Great", "Awesome"];
  TextEditingController feedback = TextEditingController();
  void onChange(
    int value,
  ) {
    setState(() {
      selectedvalue = value;
      selectedoption = slider_option[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Feedback',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Review()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ReviewSlider(
                  optionStyle: TextStyle(fontSize: 10),
                  onChange: onChange,
                  circleDiameter: 48,
                  options: slider_option,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                selectedvalue == 0
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'What went bad ?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'poppins',
                              fontSize: 14),
                        ),
                      )
                    : selectedvalue == 1
                        ? const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Tell us how we can improve ?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'poppins',
                                  fontSize: 14),
                            ),
                          )
                        : selectedvalue == 2
                            ? const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'What you like ?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'poppins',
                                      fontSize: 14),
                                ),
                              )
                            : selectedvalue == 3
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'What went good ?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'poppins',
                                          fontSize: 14),
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'What went well ? ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'poppins',
                                          fontSize: 14),
                                    ),
                                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: TextField(
                        autofocus: true,
                        maxLines: 10,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        controller: feedback,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintMaxLines: 4,
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            hintText:
                                ' Your feedbacks are really important for us.'),
                      ),
                    ),
                  ),
                ),
                Center(
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
                          fontSize: 14),
                    ),
                    onPressed: () {
                      Map<String, dynamic> suggest_data = {
                        "feedback_suggestion": feedback.text,
                        "feedback_review": selectedoption.toString()
                      };
                      FirebaseFirestore.instance
                          .collection("Feedback")
                          .add(suggest_data);
                      feedback.clear();
                      Navigator.of(context).pop();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
