// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/Home/views/gendergyms/gym_female.dart';
import 'package:vyam_2_final/Home/views/gendergyms/gym_male.dart';
import 'package:vyam_2_final/Home/views/gendergyms/gym_unisex.dart';
import 'package:vyam_2_final/Home/views/product_gym.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/booking/active.dart';
import 'package:vyam_2_final/booking/older.dart';
import 'package:vyam_2_final/booking/upcoming.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';

import 'gendergyms/gyms_gender.dart';

class GymOption extends StatefulWidget {
  const GymOption({Key? key}) : super(key: key);

  @override
  State<GymOption> createState() => _GymOptionState();
}

class _GymOptionState extends State<GymOption> {
  var _getIndex;
  var _finalColor;
  bool _all = true;
  bool _male = false;
  bool _female = false;
  bool _unisex = false;
  final Color _inactiveColor = HexColor("FFFFFF");
  final Color _maleColor = HexColor("292F3D");
  final Color _textInactive = HexColor("3A3A3A");
  final Color _textActive = HexColor("FFFFFF");
  var groupValue = 0;
  final appBarColor = Colors.grey[100];
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: HexColor("F5F5F5"),
        appBar: AppBar(
          bottom: TabBar(
              indicatorColor: HexColor("F5F5F5"),
              onTap: (index) {
                _getIndex = index;
                if (_getIndex == 0) {
                  setState(() {
                    _all = true;
                    _male = false;
                    _female = false;
                    _unisex = false;
                  });
                }
                if (_getIndex == 1) {
                  setState(() {
                    _all = false;
                    _male = true;
                    _female = false;
                    _unisex = false;
                  });
                }
                if (_getIndex == 2) {
                  setState(() {
                    _all = false;
                    _male = false;
                    _female = true;
                    _unisex = false;
                  });
                }
                if (_getIndex == 3) {
                  setState(() {
                    _all = false;
                    _male = false;
                    _female = false;
                    _unisex = true;
                  });
                }
              },
              tabs: [
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _all ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "All",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _all ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _male ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "Male",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _male ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _female ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "Female",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _female ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _unisex ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "Unisex",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _unisex ? _textActive : _textInactive),
                        ),
                      ),
                    )),
              ]),
          toolbarHeight: 80,
          // leading: Icon(
          //     CupertinoIcons.back,
          //     color: HexColor("3A3A3A"),
          //   ),
          //
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Gyms",
            style: GoogleFonts.poppins(
                color: HexColor("3A3A3A"),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [GymAll(), GymMale(), GymFeMale(), GymUnisex()]),
      ),
    );
  }
}

Widget buildSegment(String text) =>
    Text(text, style: const TextStyle(color: Colors.black));
