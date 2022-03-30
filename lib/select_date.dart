// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import 'package:vyam_2_final/payment/payment.dart';

import 'api/api.dart';

class SelectDate extends StatefulWidget {
  final getGymName;
  final getGymAddress;
  final packageType;
  final price;
  final gymId;
  final bookingId;

  const SelectDate(
      {Key? key,
      required this.months,
      required this.price,
      required this.packageType,
      required this.getGymName,
      required this.getGymAddress,
       required this.gymId, this.bookingId})
      : super(key: key);
  final String months;

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List weeks = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  var startDate;
  var endDate;
  var totalDays;
  var now = DateTime.now();
  var current_mon;
  var selected_week;
  var end_week;
  var end_mon;
  var getDays;
  var _focusedDay;
  var _pressedDay;
  var _selectedDay;
  bool swap=false;
  String year = DateTime.now().year.toString( );
  String day = DateTime.now().day.toString();
  String endday = DateTime.now().day.toString();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  final bookings= FirebaseFirestore.instance.collection("bookings").doc(number).collection("user_booking");
  addBookingData(){

  }

  @override
  void initState() {

    total_discount=0;
    if (widget.months.contains("PAY PER SESSION")) {
      getDays = 1;
    }
    if (widget.months.contains("1")) {
      getDays = 28;
    }
    if (widget.months.contains("3")) {
      getDays = 84;
    }
    if (widget.months.contains("6")) {
      getDays = 168;
    }
    _selectedDay = DateTime.now();
    selected_week = now.weekday;
    current_mon = now.month;
    end_mon = DateTime.now().add(Duration(days: getDays)).month;
    end_week = DateTime.now().add(Duration(days: getDays)).weekday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: HexColor("3A3A3A"),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Select a date",
          style: GoogleFonts.poppins(
              color: HexColor("3A3A3A"),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: _width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: TableCalendar(
                      pageJumpingEnabled: false,
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          weekdayStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },

                      // onDayLongPressed: (selectedDay, pressedDay) => setState(() {
                      //   _selectedDay = selectedDay;
                      //   print(_selectedDay);
                      //   _focusedDay = DateTime.now();
                      //   print(_focusedDay);
                      //   day = _selectedDay.day.toString();
                      //   endday = _selectedDay
                      //       .add(Duration(days: getDays))
                      //       .day
                      //       .toString();
                      //   current_mon = _selectedDay.month;
                      //   selected_week = _selectedDay.weekday;
                      //
                      //   end_mon = _selectedDay.add(Duration(days: getDays)).month;
                      //   end_week =
                      //       _selectedDay.add(Duration(days: getDays)).weekday;
                      // }),
                      onDaySelected: (selectedDay, focusedDay) => setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = _selectedDay;
                        day = _selectedDay.day.toString();
                        endday = _selectedDay
                            .add(Duration(days: getDays))
                            .day
                            .toString();
                        current_mon = _selectedDay.month;
                        selected_week = _selectedDay.weekday;

                        end_mon = _selectedDay.add(Duration(days: getDays)).month;
                        end_week =
                            _selectedDay.add(Duration(days: getDays)).weekday;
                      }),
                      calendarStyle: CalendarStyle(
                          canMarkersOverflow: true,
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor("FFCA00"),
                          ),
                          todayDecoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          )),
                      headerStyle: HeaderStyle(
                          leftChevronIcon: Image.asset("assets/icons/Arrow.png"),
                          rightChevronIcon:
                              Image.asset("assets/icons/Arrow01.png"),
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HexColor("3A3A3A"))),
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2050),
                      focusedDay: _selectedDay,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: _width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.months,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: HexColor("3A3A3A")),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("STARTS",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("3A3A3A"))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(months[current_mon - 1] + " " + day,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("3A3A3A"))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(weeks[selected_week - 1],
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("3A3A3A"))),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor("FFCA00")),
                                child: Center(
                                  child: Image.asset(
                                      "assets/icons/Arrow - Right.png"),
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("ENDS",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("3A3A3A"))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(months[end_mon - 1] + " " + endday,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("3A3A3A"))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(weeks[end_week - 1],
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("3A3A3A")))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton: SizedBox(
        width: _width * 0.9,
        child:  FloatingActionButton.extended(
          elevation: 0,
          splashColor: Colors.amber,
          backgroundColor: HexColor("292F3D"),
          autofocus: false,
          focusElevation: 4,
          // focusNode: FocusScope.of(context).unfocus();
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: () async {
            // FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
            // DateTime(int.parse(year),end_mon,int.parse(endday))
            // FocusScope.of(context).n;
            startDate = DateTime(int.parse(year),current_mon,int.parse(day));
                // months[current_mon - 1] + ", " + day + ", " + year;
            endDate = DateTime(int.parse(year),end_mon,int.parse(endday));
                // months[end_mon - 1] + ", " + endday + ", " + year;
            totalDays =DateTime(int.parse(year),end_mon,int.parse(endday)).difference(DateTime(int.parse(year),current_mon,int.parse(day))).inDays+1;
            print(startDate);
            print(endDate);
            // print((months[current_mon - 1] + " ," + day + ", " + year));
            // print(months[end_mon - 1] + ", " + endday + ", " + year);

            await FirebaseFirestore.instance.collection("bookings")
                .doc(number)
                .collection("user_booking")
                .doc(widget.bookingId)
                .update({
               "booking_date":startDate,
              "plan_end_duration":endDate,
              "totalDays":totalDays
            });
            Get.to(() => const PaymentScreen(),
              duration: const Duration(milliseconds: 500),
              arguments: {
              "gymName": widget.getGymName,
              "totalMonths": widget.months,
              "packageType": widget.packageType,
              "totalPrice": widget.price,
              "startDate": (months[current_mon - 1] + " ," + day + ", " + year),
              "endDate": (months[end_mon - 1] + ", " + endday + ", " + year),
              "address": widget.getGymAddress,
              "vendorId":widget.gymId,
              "booking_id":widget.bookingId,
              "gym_details":Get.arguments["docs"]
            },
            );
          },
          label: Text(
            "Proceed",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        )
               // : Container(),
      ),
    );
  }
}
