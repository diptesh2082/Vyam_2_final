import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:vyam2/feedback.dart';
import 'package:vyam2/gym_details.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double value1 = 5;
  double ratingvalue = 0;
  //int selectedvalue = 0;
  final int starCount = 5;
  double srating = 0.0;
  TextEditingController title = new TextEditingController();
  TextEditingController exp = new TextEditingController();
  var _ratingController = new TextEditingController();
  //CollectionReference collectionReference =
  //  FirebaseFirestore.instance.collection('user_details');

  Widget buildstar(BuildContext context, int index) {
    if (index >= srating) {
      Icon(Icons.star_border);
    } else if (index > srating - 1 && index < srating) {
      Icon(Icons.star_half);
    } else {
      Icon(Icons.star);
    }
    return new InkResponse(
        child: Icon(
      Icons.star,
      color: Colors.amber,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Reviews',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'poppins',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen1()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              label: const Text(
                'Write a review',
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white),
              ),
              backgroundColor: Colors.black,
              onPressed: openreviewcard
              //() {
              //Navigator.push(context,
              //  MaterialPageRoute(builder: (context) => Feedback1()));
              //sdss},
              ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer reviews',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(
                        starCount, (index) => buildstar(context, index)),
                  ),
                  Text('4.7 out of 5 ',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.012,
              ),
              Text(
                '(113 reviews)',
                style: TextStyle(
                    fontFamily: 'poppins',
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
                      Text(
                        '5 star',
                        style: TextStyle(
                            fontFamily: 'poppins',
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
                        trailing: Text(
                          '60%',
                          style: TextStyle(
                              fontFamily: 'poppins',
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
                      Text(
                        '4 star',
                        style: TextStyle(
                            fontFamily: 'poppins',
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
                        trailing: Text(
                          '30%',
                          style: TextStyle(
                              fontFamily: 'poppins',
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
                      Text(
                        '3 star',
                        style: TextStyle(
                            fontFamily: 'poppins',
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
                        trailing: Text(
                          '15%',
                          style: TextStyle(
                              fontFamily: 'poppins',
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
                      Text(
                        '2 star',
                        style: TextStyle(
                            fontFamily: 'poppins',
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
                        trailing: Text(
                          '5%',
                          style: TextStyle(
                              fontFamily: 'poppins',
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
                      Text(
                        '1 star',
                        style: TextStyle(
                            fontFamily: 'poppins',
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
                        trailing: Text(
                          '10%',
                          style: TextStyle(
                              fontFamily: 'poppins',
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
              Divider(
                height: 30,
                indent: 8,
                endIndent: 20,
                thickness: 1.2,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Reviews')
                    .doc('Transformer Gym')
                    .collection("9045291663")
                    .snapshots(),
                builder: ((context, AsyncSnapshot snapshot1) {
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user_details')
                          .snapshots(),
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                            leading: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  //border: Border.all(width: 1),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/trainer1.png"),
                                                      fit: BoxFit.cover)),
                                            ),
                                            title: Text(
                                              snapshot.data.docs[index]['name'],
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            )),
                                        Text(
                                          snapshot1.data.docs[index]
                                              ['experience'],
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                      }));
                }),

                /* Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ))),
                      child: Row(
                        children: [
                          Icon(Icons.feed_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Feedback',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        //openfeedback();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Feedback1()));
                      },
                    ),
                  ],
                ),
              ),*/
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openreviewcard() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final CollectionReference review =
                        await FirebaseFirestore.instance.collection('Reviews');
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
                          .doc("Transformer Gym")
                          .collection("9045291663")
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
            content: Container(
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
                        child: Align(
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
                        full: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                        empty: Icon(
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
                  Text(
                    'Add a title',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: Card(
                        child: TextField(
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      controller: title,
                      maxLines: 3,
                      decoration: InputDecoration(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.022,
                  ),
                  Text(
                    'Add a written review',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'poppins',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: Card(
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        controller: exp,
                        maxLines: 10,
                        decoration: InputDecoration(
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
                  )
                ],
              ),
            ),
          ));
}
