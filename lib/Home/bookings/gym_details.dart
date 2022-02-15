import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/Home/bookings/timings_details.dart';
import 'package:vyam_2_final/controllers/packages/packages.dart';

import 'know_trainer.dart';

class GymDetails extends StatefulWidget {
  final gymName;
  final getID;

  const GymDetails({Key? key, required this.getID, required this.gymName})
      : super(key: key);

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

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          ""
          "Gyms",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        //height: 800,
        color: Colors.white30,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
                //scrollDirection: Axis.vertical,
//                  shrinkWrap: true,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index, realIndex) {
                                final image = images[index];
                                return gymImages(image, index);
                              },
                              options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                              )),
                        ],
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: const [
                      Text(
                        'Transformers Gym',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text('OPEN NOW',
                          style: TextStyle(
                              color: Colors.lightGreen, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Row(children: const [
                    Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    Text(
                      'Barakar',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                    Spacer(),
                    Icon(Icons.assistant_direction, color: Colors.green),
                    Text('        ')
                  ]),
                  Row(children: const [
                    Spacer(),
                    Text('Navigate',
                        style: TextStyle(color: Colors.green, fontSize: 10)),
                    Text('     ')
                  ]),
                  const Text(
                    'Bus stand, Barakar, near pratham lodge',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.028),
                  FittedBox(
                    child: Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          //color: Colors.amber,
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/time_circle.png"))),
                        ),
                      ),
                      IntrinsicHeight(
                          child: Row(
                        children: [
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(' Morning (Mon-Sat)',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              SizedBox(height: 10),
                              Text('6.00AM-12.00PM',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12)),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(' Evening (Mon-Sat)',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              SizedBox(height: 10),
                              Text('4.00PM-11.00PM',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12)),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(' Sunday',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              SizedBox(height: 10),
                              Text(' Closed',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12)),
                            ],
                          ),
                        ],
                      )),
                    ]),
                  ),
                  Row(
                    children: [
                      const Text(' '),
                      const Spacer(),
                      GestureDetector(
                        child: const Text("View more",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Timing()));
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
                  const SizedBox(height: 12),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipscing elit. Sited turpis curabitur sed sed ut lacus vulputate sit. Sit lacus metus quis erat nec mattis erat ac ',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const Text('Read more',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 12),
                  const Text(
                    'Amenities',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  FittedBox(
                      child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 25,
                        width: 40,
                        child: const Icon(
                          Icons.ac_unit,
                          size: 11,
                        ),
                        //color: Colors.amber,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 40,
                        child: const Icon(
                          Icons.lock_rounded,
                          size: 11,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 40,
                        child: const Icon(
                          Icons.car_repair,
                          size: 11,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 40,
                        child: const Icon(
                          Icons.person_outline,
                          size: 11,
                        ),
                        //color: Colors.amber,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'A/C',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12.5),
                      ),
                      Text(
                        'Locker',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12.5),
                      ),
                      Text(
                        'Parking',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12.5),
                      ),
                      Text(
                        'P/T',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12.5),
                      ),
                    ],
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Trainers',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 18,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Trainer()));
                                    },
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
                                    return Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
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
                                    return Row(
                                      children: [
                                        Text(
                                          trainername[index],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                        ),
                                      ],
                                    );
                                  }),
                            )
                          ],
                        )),
                  ),
                  Card(
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.050,
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
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
                                const Spacer(),
                                GestureDetector(
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Trainer()));
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.200,
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
                              child: Text('Rules',
                                  style: TextStyle(
                                    fontSize: 14.5,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  const Text("•  Bring seperate shoes.",
                                      style: TextStyle(fontSize: 13)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  const Text("•  Re-rack equipments",
                                      style: TextStyle(fontSize: 13)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  const Text(
                                      "•  No heavy lifting without spotter",
                                      style: TextStyle(fontSize: 13)),
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
                        fontSize: 16,
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
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
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
                                    const AutoSizeText(
                                      'Best in class safety',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.5,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
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
                                        fontSize: 12.5,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
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
                                        fontSize: 12.5,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 8,
        splashColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Get.to(() => Packeges(
                getFinalID: widget.getID,
                gymName: widget.gymName,
              ));
        },
        label: Text(
          "Explorer Packages",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
}
