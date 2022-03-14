import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:vyam_2_final/Home/bookings/review_screen.dart';
import 'package:vyam_2_final/Home/bookings/timings.dart';
import 'package:vyam_2_final/Home/bookings/timings_details.dart';
import 'package:vyam_2_final/controllers/packages/packages.dart';

import 'package:vyam_2_final/Home/bookings/know_trainer.dart';

import '../views/explore.dart';

class GymDetails extends StatefulWidget {
  // final gymName;
  // final getID;
  // final gymLocation;
  //
  // const GymDetails(
  //     {Key? key,
  //       required this.getID,
  //       required this.gymName,
  //       required this.gymLocation})
  //     : super(key: key);

  @override
  _GymDetailsState createState() => _GymDetailsState();
}

class _GymDetailsState extends State<GymDetails> {
  List trainers = [
    "assets/images/trainer1.png",
    "assets/images/trainer2.png",
    "assets/images/trainer3.png",
  ];

  final images = [
    "assets/images/rectangle_14.png",
    "assets/images/transf1.jpeg",
    "assets/images/transf2.jpeg",
    "assets/images/transf3.jpeg",
    "assets/images/transf5.jpeg",
  ];

  List<IconData> icons = [
    Icons.ac_unit,
    Icons.lock_rounded,
    Icons.car_repair,
    Icons.person_outline,
    Icons.access_alarm,
  ];

  final amenities_name = [
    "A/C",
    "Locker",
    "Parking",
    "P/T",
    "Alarm",
  ];
  var doc =Get.arguments;

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  final List _isSelected = [true, false, false, false, false, false];
  int _current = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            //height: 800,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[100],
            margin: const EdgeInsets.symmetric(horizontal: 5.59),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height,
                child: ListView(

                    children: [
                      const SizedBox(
                        height: 6,
                      ),

                      ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CarouselSlider.builder(
                                itemCount: images.length,
                                itemBuilder: (context, index, realIndex) {
                                  final image = images[index];
                                  return gymImages(image, index);
                                },
                                options: CarouselOptions(
                                  height: 255,
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index + 1;
                                        for (int i = 0; i < images.length; i++) {
                                          if (i == index) {
                                            _isSelected[i] = true;
                                          } else {
                                            _isSelected[i] = false;
                                          }
                                        }
                                      });
                                    }),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width/3,
                                // right: 40,
                                bottom: 0,
                                child: SizedBox(
                                    height: 25,
                                    width: double.maxFinite,
                                    // color: Colors.black26,
                                    child: Row(
                                      children: [
                                        for (int i = 0; i < images.length; i++)
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Visibility(
                                                child: Container(
                                                  height: 2,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0),
                                                      color: _isSelected[i]
                                                          ? Colors.white
                                                          : Colors.grey),
                                                )),
                                          )
                                      ],
                                    )),
                              ),
                              Positioned(
                                // left: MediaQuery.of(context).size.width * 0.8,
                                right: 290,
                                // bottom: 10,
                                top: 0,
                                left: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: IconButton(onPressed: (){
                                    Get.back();
                                  }, icon: const Icon(Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              Positioned(
                                // left: MediaQuery.of(context).size.width * 0.8,
                                right: 10,
                                bottom: 10,
                                left: 280,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      height: 28,
                                      width:0,
                                      color: Colors.black45,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 0),
                                            child: Text(
                                              _current.toString(),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          const Text("/",
                                              style:
                                              TextStyle(color: Colors.white)),
                                          Text(images.length.toString(),
                                              style: const TextStyle(color: Colors.white))
                                        ],
                                      )),
                                ),
                              )
                            ],
                          )),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          Text(
                            '${doc["docs"]["name"]??""}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Text('OPEN NOW',
                              style: TextStyle(
                                  color: Colors.lightGreen, fontSize: 14)),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      Row(children:  [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        const Text(
                          'Barakar',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: (){
                              Get.to(() => const Explore(),
                                  arguments: {"location": doc?["location"]});
                            },
                            child: const Icon(Icons.assistant_direction, color: Colors.green)),
                        const Text('       ')
                      ]),
                      Row(children:  [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: GestureDetector(

                            child: const Text('Navigate',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Colors.green,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Timing()));
                            },
                          ),
                        ),


                      ]),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                       Text(
                        '${doc["docs"]["address"]??""}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      SizedBox(
                        height: 60,
                        child: FittedBox(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 51,
                                    width: 49,
                                    //color: Colors.amber,
                                    decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/time_circle.png"))),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IntrinsicHeight(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                            doc["docs"]["timings"]["gym"]["morning_days"] ??  "Morning",
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 10),
                                        Text(

                                            doc["docs"]["timings"]["gym"]["Morning"] ?? " no information"
                                            ,
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 10)),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(

                                            doc["docs"]["timings"]["gym"]["evening_days"] ?? "Evening",
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                fontSize: 10)),
                                        const SizedBox(height: 10),
                                        Text(
                                            doc["docs"]["timings"]["gym"]["Evening"] ?? "no information",
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 10)),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children:[
                                        Text(
                                            doc["docs"]["timings"]["gym"]["closed"] ?? "closed",
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                fontSize: 10)),
                                        const SizedBox(height: 10),
                                         Text(
                                           // "",
                                            doc["docs"]["timings"]["gym"]["closed"] != null ?'Closed':"no information",
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 10)),
                                      ],
                                    ),
                                  ],
                                )),
                          ]),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(' '),
                          const Spacer(),
                          GestureDetector(
                            child: const Text("View more",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    decoration: TextDecoration.underline,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                                Get.to(()=> Timing_Screen(),
                                  arguments: {
                                  "timings": doc["docs"]["timings"]
                                  }
                                );
                            },
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                            size: 20,
                          )
                        ],
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.022),
                      const ReadMoreText(
                        'Lorem ipsum dolor sit amet, consectetur adipscing elit. Sited turpis curabitur sed sed ut lacus vulputate sit. Sit lacus metus quis erat nec mattis erat ac  Lorem ipsum dolor sit amet, consectetur adipscing elit. Sited turpis curabitur sed sed ut lacus vulputate sit. Sit lacus metus quis erat nec mattis erat ac ',
                        trimLines: 3,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: 'Read Less',
                        moreStyle:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                        lessStyle:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      const Text(
                        'Amenities',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return amenities(index);
                            }),
                            separatorBuilder: (context, _) => SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            itemCount: amenities_name.length),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Text(
                        'Workouts',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.070,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              'Boxing | Cardio | Personal Training | Crossfit |  Zumba | Weight Training.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                        child: GestureDetector(
                          onTap: (){
                            FocusScope.of(context).unfocus();
                            Get.to(()=>Trainer());
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Trainers',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height / 9,
                                    child: ListView.builder(
                                        itemCount: trainers.length,
                                        physics: const PageScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 65,
                                                  width: 65,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      //border: Border.all(width: 1),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              trainers[index]),
                                                          fit: BoxFit.cover)),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.05,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height / 50,
                                    child: ListView.builder(
                                        itemCount: trainername.length,
                                        physics: const PageScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  trainername[index],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.09,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          // var mink=doc["docs"];
                          // print(mink);
                          // print();
                          Get.to(()=>Review(),
                            arguments: {
                              "gym_id":doc["id"],
                              "docs": doc["doc"],
                              "name":doc["name"]
                            }
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Reviews',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height:50,
                                    // MediaQuery.of(context).size.height * 0.050,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.05,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                        const Text(
                                          '4.7',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        ),
                                        const Text(
                                          ' | ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.grey),
                                        ),
                                        const Text(
                                          '(113 reviews)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Colors.grey),
                                        ),
                                        //  const Spacer(),
                                        SizedBox(
                                          width:
                                          MediaQuery.of(context).size.width * 0.2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width *
                                                0.28,
                                            height: MediaQuery.of(context).size.height *
                                                0.055,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 35,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      //border: Border.all(width: 1),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/trainer1.png"),
                                                          fit: BoxFit.cover)),
                                                ),
                                                Positioned(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.055,
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        //border: Border.all(width: 1),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/trainer2.png"),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.11,
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        //border: Border.all(width: 1),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/trainer3.png"),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.166,
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        //border: Border.all(width: 1),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/trainer1.png"),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          MediaQuery.of(context).size.width * 0.009,
                                        ),

                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.24,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.02,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Rules',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.015,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "•  Bring your towel and use it.",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      const Text("•  Bring seperate shoes.",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      const Text("•  Re-rack equipments",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      const Text(
                                          "•  No heavy lifting without spotter",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Text('Safety protocols',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      FittedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.18,
                                    width:
                                    MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                        ),
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5, color: Colors.white),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/safe1.png'),
                                                // fit: BoxFit.cover
                                              )),
                                        ),
                                        SizedBox(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                        ),
                                        const AutoSizeText(
                                          'Best in class safety',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              fontFamily: "Poppins"
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300))),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.18,
                                    width:
                                    MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5, color: Colors.white),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/safe2.png'),
                                                // fit: BoxFit.cover
                                              )),
                                        ),
                                        const AutoSizeText(
                                          'Proper sanitised equipments',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              fontFamily: "Poppins"
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                    )),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.18,
                                    width:
                                    MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 5, color: Colors.white),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/safe3.png'),
                                                // fit: BoxFit.cover
                                              )),
                                        ),
                                        const AutoSizeText(
                                          'Social Distancing at all times',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              fontFamily: "Poppins"
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300)))
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Want to know more ? ',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                          GestureDetector(
                              child:  const Text('Call now ',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.amber,
                                    fontFamily: 'poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onTap: null),
                          const Icon(
                            Icons.phone_in_talk,
                            size: 18,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        // width: MediaQuery.of(context).size.width,
        height: 66,
        width: MediaQuery.of(context).size.width*.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
       
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 51,
              width: MediaQuery.of(context).size.width*.82,
              child: FloatingActionButton.extended(
                // backgroundColor: Colors.white,
                elevation: 15,
                splashColor: Colors.amber,
                backgroundColor: const Color(0xff292F3D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  // print(doc["id"]);
                  Get.to(() =>
                      Packeges(
                      getFinalID: doc["id"],
                      gymName: doc["name"],
                      gymLocation: doc["location"],
                  )
                  );
                },
                label: Text(
                  "Explore Packages",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gymImages(String images, int index) => SizedBox(
    height: 70,
    width: double.infinity,
    child: Image.asset(
      images,
      fit: BoxFit.cover,
    ),
  );

  Widget amenities(int index) => Container(
    child: FittedBox(
      child: Column(
        children: [
          Container(
            height: 47.2,
            width: 40,
            child: Icon(
              icons[index],
              size: 16,
            ),
            //color: Colors.amber,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber.shade400,
            ),
          ),
          Text(
            amenities_name[index],
            //textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w300,
                fontSize: 8),
          ),
        ],
      ),
    ),
  );

}