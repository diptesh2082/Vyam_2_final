import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../golbal_variables.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String text =
      '''VYAM - the all-in-one GYM booking app. The VYAM app allows you to work out anytime, anywhere avoiding membership and admission charges.
Ever searched for ‘gym near me’ or ‘fitness centers near me'? Then the all-in-one gym booking mobile application is for you. VYAM is the first app in West Bengal which gives you access to find gyms in Asansol and near-abouts. You can locate nearby gyms, book your slot/session whenever you want. With VYAM the free gym app you can discover top-rated gyms at your fingertips and book fitness appointments.
Why VYAM?
Compare Fitness Studios/GYMs through prices, pictures, and reviews and get the best deal with amazing gifts and cashbacks. Making fitness available at low costs with a secure and safe environment abiding by the rules implemented by the Indian government with unisex and only girls timing.
FEATURES:
VYAM will automatically show nearby gyms and fitness centers.
Users can avoid paying full-time membership and just PAY-PER-USE.
Users will be able to book slots at their convenience.
MISSION:
  – 1 platform for all fitness freaks and beginners too.
  – 1 platform for all gyms and fitness studios.
  – Make fitness affordable and available for every human.
Any doubts, questions, queries, tension, or concerns, please mail us at support@vyam.co.in
Or call us at +91 91026 91777''';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          title: Text("About Us"),
          centerTitle: true,
          foregroundColor: Color(0xff3A3A3A),
          backgroundColor: Color(0xffE5E5E5),
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context, false),
            color: Color(0xff3A3A3A),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      textStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// VYAM - the all-in-one GYM booking app. The VYAM app allows you to work out anytime, anywhere avoiding membership and admission charges.
// Ever searched for ‘gym near me’ or ‘fitness centers near me'? Then the all-in-one gym booking mobile application is for you. VYAM is the first app in West Bengal which gives you access to find gyms in Asansol and near-abouts. You can locate nearby gyms, book your slot/session whenever you want. With VYAM the free gym app you can discover top-rated gyms at your fingertips and book fitness appointments.
// Why VYAM?
// Compare Fitness Studios/GYMs through prices, pictures, and reviews and get the best deal with amazing gifts and cashbacks. Making fitness available at low costs with a secure and safe environment abiding by the rules implemented by the Indian government with unisex and only girls timing.
// FEATURES:
// VYAM will automatically show nearby gyms and fitness centers.
// Users can avoid paying full-time membership and just PAY-PER-USE.
// Users will be able to book slots at their convenience.
// MISSION:
//   – 1 platform for all fitness freaks and beginners too.
//   – 1 platform for all gyms and fitness studios.
//   – Make fitness affordable and available for every human.
// Any doubts, questions, queries, tension, or concerns, please mail us at support@vyam.co.in
// Or call us at +91 91026 91777