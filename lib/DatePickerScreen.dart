import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vyam_2_final/payment/payment.dart';
import 'golbal_variables.dart';

class DatePickerScreen extends StatefulWidget {
  final getGymName;
  final getGymAddress;
  final packageType;
  final price;
  final gymId;
  final bookingId;
  final months;
  const DatePickerScreen(
      {Key? key,
      this.getGymName,
      this.getGymAddress,
      this.packageType,
      this.price,
      this.gymId,
      this.bookingId,
      this.months})
      : super(key: key);

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  final TextStyle regularStyle = const TextStyle(
      color: Colors.black,
      fontFamily: 'PoppinsRegular',
      fontSize: 12,
      fontWeight: FontWeight.w400);

  final TextStyle boldStyle = const TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w700);

  final TextStyle buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  var totalDays;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 51),
                child: Text(
                  'Select a Date',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 26, 16, 10),
                child: SizedBox(
                  height: 327,
                  width: 400,
                  child: Card(
                    child: SfDateRangePicker(
                      minDate: DateTime.now(),
                      maxDate: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+31),
                      //Daddy Widget aka Calender Widget
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        // TextStyle of each date
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      view: DateRangePickerView.month,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                          // Week Names header widget
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(color: Colors.grey),
                          ),
                          firstDayOfWeek: 1,
                          dayFormat: 'EEE'),
                      selectionMode: DateRangePickerSelectionMode
                          .range, // Selection Pattern property
                      //header Style
                      headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      //Color Properties
                      rangeSelectionColor: const Color(0x66FFCA00),
                      startRangeSelectionColor: const Color(0xffFFCA00),
                      endRangeSelectionColor: const Color(0xffFFCA00),
                      todayHighlightColor: const Color(0xffFFCA00),

                      onSelectionChanged: _onSelectionChanged,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              //Card _ 2
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: SizedBox(
                  height: 159,
                  width: 400,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${widget.months}',
                          style: GoogleFonts.poppins(
                              // fontFamily: 'PoppinsSemiBold',
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('STARTS', style: regularStyle),
                                Text(DateFormat("dd,MMMM").format(startDate),
                                    style: boldStyle),
                                Text(DateFormat("E").format(startDate),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_circle_right_sharp,
                              size: 40,
                              color: HexColor('#FFCA00'),
                            ),
                            Column(
                              children: [
                                Text('ENDS', style: regularStyle),
                                Text(DateFormat("dd,MMMM").format(endDate),
                                    style: boldStyle),
                                Text(DateFormat("E").format(endDate),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: FloatingActionButton.extended(
              elevation: 0,
              splashColor: Colors.amber,
              backgroundColor: HexColor("292F3D"),
              autofocus: false,
              focusElevation: 4,
              // focusNode: FocusScope.of(context).unfocus();
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () async {
                print(endDate.difference(startDate).inDays);

                Get.to(
                  () => const PaymentScreen(),
                  duration: const Duration(milliseconds: 500),
                  arguments: {
                    "gymName": widget.getGymName,
                    "totalMonths": widget.months,
                    "packageType": widget.packageType,
                    "totalPrice": widget.price *
                        (1 + endDate.difference(startDate).inDays),
                    "startDate": DateFormat("MMMM,dd,yyyy").format(startDate),
                    "endDate": DateFormat("MMMM,dd,yyyy").format(endDate),
                    "address": widget.getGymAddress,
                    "vendorId": widget.gymId,
                    "booking_id": widget.bookingId,
                    "gym_details": Get.arguments["docs"],
                    "totalDays": endDate.difference(startDate).inDays+1
                  },
                );
                await FirebaseFirestore.instance
                    .collection("bookings")
                    .doc(widget.bookingId)
                    .update({
                  "booking_date": startDate,
                  "plan_end_duration": endDate,
                  "totalDays": endDate.difference(startDate).inDays
                });
              },
              label: Text(
                "Proceed",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    try {
      DateTime s_Date = args.value.startDate;
      DateTime e_Date = args.value.endDate;
      setState(() {
        startDate = s_Date;
        endDate = e_Date;
      });
    } catch (e) {
      print(e);
    }

    // print(DateFormat("dd,MMMM,yyyy").format(startDate));
    // print(DateFormat("dd,MMMM,yyyy").format(endDate));
  }
}
