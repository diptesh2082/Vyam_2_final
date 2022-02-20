// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/booking/older.dart';
import 'package:vyam_2_final/booking/upcoming.dart';
// import 'package:vyambooking/booking/active.dart';
// import 'package:vyambooking/booking/older.dart';
// import 'package:vyambooking/booking/upcoming.dart';

import 'active.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  var _getIndex;
  // ignore: unused_field
  var _finalColor;
  bool _upcoming = true;
  bool _active = false;
  bool _older = false;
  final Color _inactiveColor = HexColor("FFFFFF");
  final Color _activeColor = HexColor("292F3D");
  final Color _textInactive = HexColor("3A3A3A");
  final Color _textActive = HexColor("FFFFFF");

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    var _height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: HexColor("F5F5F5"),
        appBar: AppBar(
          bottom: TabBar(
              indicatorColor: HexColor("F5F5F5"),
              onTap: (index) {
                _getIndex = index;
                if (_getIndex == 0) {
                  setState(() {
                    _upcoming = true;
                    _active = false;
                    _older = false;
                  });
                }
                if (_getIndex == 1) {
                  setState(() {
                    _upcoming = false;
                    _active = true;
                    _older = false;
                  });
                }
                if (_getIndex == 2) {
                  setState(() {
                    _upcoming = false;
                    _active = false;
                    _older = true;
                  });
                }
              },
              tabs: [
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _upcoming ? _activeColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "Upcoming",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _upcoming ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _active ? _activeColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "Active",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _active ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _older ? _activeColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "Older",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _older ? _textActive : _textInactive),
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
            "Booking",
            style: GoogleFonts.poppins(
                color: HexColor("3A3A3A"),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              UpcomingEvent(width: _width),
              ActiveEvent(width: _width),
              OlderEvent(
                width: _width,
              )
            ]),
      ),
    );
  }
}
