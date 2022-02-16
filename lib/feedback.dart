import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'gym_details.dart';
import 'review_screen.dart';

/*class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Feedback(),
      ),
    );
  }
}*/

class Feedback1 extends StatefulWidget {
  @override
  _Feedback1State createState() => _Feedback1State();
}

class _Feedback1State extends State<Feedback1> {
  int selectedvalue = 0;
  TextEditingController suggestion = new TextEditingController();
  void onChange(int value) {
    setState(() {
      selectedvalue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
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
                options: ["Bad", "Okay", "Good", "Great", "Awesome"],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Add your suggestions',
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
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      controller: suggestion,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintMaxLines: 4,
                          hintStyle: TextStyle(
                              fontFamily: 'poppins',
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    suggestion.clear();

                    Map<String, dynamic> suggest_data = {
                      "feedback": suggestion.text,
                      "feedback_review": selectedvalue.toString()
                    };
                    FirebaseFirestore.instance
                        .collection("Feedback")
                        .add(suggest_data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
