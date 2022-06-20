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
  final package_name;
  const DatePickerScreen(
      {Key? key,
        required  this.getGymName,
        required this.getGymAddress,
        required this.packageType,
        required this.price,
        required this.gymId,
        required this.bookingId,
        required this.months,required this.package_name})
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
  void initState() {
    // TODO: implement initState
    print(widget.months);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
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
            "Choose single/multiple dates",
            style: GoogleFonts.poppins(
                color: HexColor("3A3A3A"),
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 26, 16, 10),
                child: SizedBox(
                  height: 327,
                  width: 400,
                  child: Card(
                    child: SfDateRangePicker(
                      // in
                      minDate: DateTime.now(),
                      maxDate: DateTime.utc(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day + 31),
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
                                Text('STARTS',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("3A3A3A"))),
                                Text(DateFormat("dd,MMMM").format(startDate),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("3A3A3A"))),
                                Text(DateFormat("EEEEE").format(startDate),
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("3A3A3A"))),
                              ],
                            ),
                            Icon(
                              Icons.arrow_circle_right_sharp,
                              size: 40,
                              color: HexColor('#FFCA00'),
                            ),
                            Column(
                              children: [
                                Text('ENDS',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("3A3A3A"))),
                                Text(DateFormat("dd,MMMM").format(endDate),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("3A3A3A"))),
                                Text(DateFormat("EEEE").format(endDate),
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("3A3A3A"))),
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
                await FirebaseFirestore.instance
                    .collection("bookings")
                    .doc(widget.bookingId)
                    .update({
                  "booking_date": startDate,
                  "plan_end_duration": endDate,
                  "totalDays": endDate.difference(startDate).inDays
                }).then((value) {
                  Get.to(
                    () => PaymentScreen(
                      endDate: DateFormat("dd, MMM, yyyy").format(endDate),
                    ),
                    duration: const Duration(milliseconds: 500),
                    arguments: {
                      "gymName": widget.getGymName,
                      "totalMonths": widget.months,
                      "packageType": widget.packageType,
                      "totalPrice": widget.price *
                          (1 + endDate.difference(startDate).inDays),
                      "startDate":
                          DateFormat("dd, MMM, yyyy").format(startDate),
                      "endDate": DateFormat("dd, MMM, yyyy").format(endDate),
                      "address": widget.getGymAddress,
                      "vendorId": widget.gymId,
                      "booking_id": widget.bookingId,
                      "gym_details": Get.arguments["docs"],
                      "totalDays": endDate.difference(startDate).inDays <=0?1:endDate.difference(startDate).inDays,
                      "booking_plan":widget.package_name,
                    },
                  );
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
