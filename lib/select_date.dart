// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vyam_2_final/payment/payment.dart';

class SelectDate extends StatefulWidget {
  final getGymName;
  final getGymAddress;
  final packageType;
  final price;

  const SelectDate(
      {Key? key,
      required this.months,
      required this.price,
      required this.packageType,
      required this.getGymName,
      required this.getGymAddress})
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
  var now = DateTime.now();
  var current_mon;
  var selected_week;
  var end_week;
  var end_mon;
  var getDays;
  var _focusedDay;
  var _selectedDay;
  String year = DateTime.now().year.toString();
  String day = DateTime.now().day.toString();
  String endday = DateTime.now().day.toString();

  @override
  void initState() {
    print(widget.getGymName);
    print(widget.months);
    print(widget.packageType);
    print(widget.price);
    if (widget.months.contains("PAY PER SESSION")) {
      getDays = 0;
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
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: _width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TableCalendar(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: _width * 0.9,
        child: FloatingActionButton.extended(
          elevation: 0,
          splashColor: Colors.amber,
          backgroundColor: HexColor("292F3D"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: () {
            startDate = months[current_mon - 1] + " " + day + ", " + year;
            endDate = months[end_mon - 1] + " " + endday + ", " + year;
            print((months[current_mon - 1] + " " + day + ", " + year));
            print(months[end_mon - 1] + " " + endday + ", " + year);
            Get.to(() => const PaymentScreen(), arguments: {
              "gymName": widget.getGymName,
              "totalMonths": widget.months,
              "packageType": widget.packageType,
              "totalPrice": widget.price,
              "startDate": startDate,
              "endDate": endDate,
              "address": widget.getGymAddress
            });
          },
          label: Text(
            "Proceed",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
