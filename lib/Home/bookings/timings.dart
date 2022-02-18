import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyam_2_final/Home/bookings/review_screen.dart';
import 'gym_details.dart';

class Timing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Timing_Screen(),
      ),
    );
  }
}

class Timing_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Timings',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Review()));
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: FittedBox(
            child: Column(
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    shadowColor: Colors.black,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Gym timings',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          ),
                          SizedBox(height: 10),
                          FittedBox(
                            child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Wrap(direction: Axis.vertical, children: const [
                                          Text(' Morning',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' Monday - Saturday',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' 6.00AM-12.00PM',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Text(' Sunday closed',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ])
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.06,
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.06,
                                    ),
                                    Column(
                                      children: [
                                        Wrap(direction: Axis.vertical, children: const [
                                          Text(' Evening',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' Monday - Saturday',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' 4.00PM-11.00PM',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Text(' Sunday closed',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ])
                                      ],
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    shadowColor: Colors.black,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Yoga timings',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Wrap(direction: Axis.vertical, children: const [
                                          Text(' Morning',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' Monday - Saturday',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' 6.00AM-12.00PM',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Text(' Sunday closed',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ])
                                      ],
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    shadowColor: Colors.black,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Zumba timings',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                            child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Wrap(direction: Axis.vertical, children: const [
                                          Text(' Morning',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' Monday - Saturday',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' 6.00AM-12.00PM',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Text(' Sunday closed',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ])
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.06,
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.06,
                                    ),
                                    Column(
                                      children: [
                                        Wrap(direction: Axis.vertical, children: const [
                                          Text(' Evening',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' Monday - Saturday',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(' 4.00PM-11.00PM',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Text(' Sunday closed',
                                              style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ])
                                      ],
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}