import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vyam_2_final/Home/bookings/review_screen.dart';

import 'package:auto_size_text/auto_size_text.dart';

class Trainer extends StatefulWidget {
  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  int _current1 = 1;
  List trainers = [
    "assets/images/trainer1.png",
    "assets/images/trainer2.png",
    "assets/images/trainer3.png",
  ];

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  final trainernames = ['Jake', 'Jim', 'Kim'];
  List tinforeview = ["4.7", "4.9", "5.0"];
  List tinfoclient = ["13", "100", "75"];
  List tinfoexp = ["10+", "7+", "13+"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Know your trainer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      body: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
              _current1.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            const Text("/", style: TextStyle(color: Colors.black)),
            Text(trainername.length.toString(),
                style: const TextStyle(color: Colors.black))
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView.builder(
                itemCount: trainers.length,
                controller: PageController(viewportFraction: 0.822),
                onPageChanged: (int index) => setState(() {
                  _current1 = index + 1;
                }),
                itemBuilder: ((_, i) {
                  return buildtrainer(context, i);
                })),
          ),
        ],
      ),
    );
  }

  Widget buildtrainer(BuildContext context, int index) => ListView(children: [
    Column(
      children: [
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),
                  Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //border: Border.all(width: 1),
                        image: DecorationImage(
                            image: AssetImage(trainers[index]),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        trainername[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  const Text(
                    'Transformers Gym',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  const Text(
                    'Branch - Barakar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tinforeview[index],
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      Text(
                        tinfoclient[index],
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      Text(
                        tinfoexp[index],
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Reviews',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      Text(
                        '   Clients',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      Text(
                        'Experience',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 15,
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'About',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: AutoSizeText(
                          '${trainernames[index]} is a professional trainer and nutritionist who has 10 years of experience in this field.',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Certifications',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.003,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "•  Golds gym certified trainer.",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.015,
                            ),
                            const Text(
                                "•  Golds gym certified nutritionist.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.015,
                            ),
                            const Text(
                                "•  All time calisthenics champion.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Specialization',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.042
                          ),
                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width * 0.90,
                            child: const AutoSizeText(
                              'Bodybuilding | Workout | Calesthenics | Zumba | HIIT | Cardio | Diet & Nutrition.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          height: 32,
                          width: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Colors.amber,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/insta_icon.png"))),
                        ),
                      ),
                      Text(
                        '@${trainernames[index].toLowerCase()}_xyz',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Reviews',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      Text(
                        tinforeview[index],
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      const Text(
                        '(33 reviews)',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height:
                          MediaQuery.of(context).size.height * 0.054,
                          child: Stack(
                            children: [
                              Container(
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
                              Positioned(
                                left: MediaQuery.of(context).size.width *
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
                                left: MediaQuery.of(context).size.width *
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
                                left: MediaQuery.of(context).size.width *
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
                        width: MediaQuery.of(context).size.width * 0.001,
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Review()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    ),
  ]);
}