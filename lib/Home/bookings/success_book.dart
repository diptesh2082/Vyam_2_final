import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vyam_2_final/Home/bookings/feedback.dart';

class SuccessBook extends StatefulWidget {
  @override
  _SuccessBookState createState() => _SuccessBookState();
}

class _SuccessBookState extends State<SuccessBook>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, value: 0.1, duration: Duration(milliseconds: 8000));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: BorderRadius.circular(20),
        minHeight: MediaQuery.of(context).size.height * 0.05,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        panelBuilder: (sc) => PanelWidget(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: scaleAnimation,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 85,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Text(
                'Booking Successful!!',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              const Text(
                'Share the OTP with your \n  gym owner to start',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PanelWidget extends StatefulWidget {
  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Center(
          child: Container(
            width: 70,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Booking Details',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Booking ID :',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          Text(
                            '00123',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      const Text(
                        'Transformers gym',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      Row(children: const [
                        Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        Text('Barakar',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 14)),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Package  ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          Text(
                            '3 Months',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      const Text(
                        'Ends on: 6th May',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0035,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ))),
                        child:  Text(
                          'OTP : ${Get.arguments["otp_pass"]}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Container(
                      height: 190,
                      width: 190,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/rectangle_14.png"))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                  child: const Text(
                    'Leave a rating',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.09,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                  child: const Text(
                    'Track',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Feedback1()));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}