import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'gym_details.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'review_screen.dart';

class TrainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Trainer(),
      ),
    );
  }
}

class Trainer extends StatefulWidget {
  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  int _current = 0;
  List trainers = [
    "assets/trainer1.png",
    "assets/trainer2.png",
    "assets/trainer3.png",
  ];

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  final trainernames = ['Jake', 'Jim', 'Kim'];

  void _onItemFocus(int index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Know your trainer',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 14,  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w600,),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Screen1()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: ScrollSnapList(
          itemBuilder: buildtrainer,
          itemCount: trainers.length,
          itemSize: MediaQuery.of(context).size.height,
          onItemFocus: _onItemFocus),
    );
  }

  Widget buildtrainer(BuildContext context, int index) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                //height: MediaQuery.of(context).size.height * 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
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
                          style: TextStyle(  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w600,
                               fontSize: 16),
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      'Transformers Gym',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    Text(
                      'Branch - Barakar',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(  fontFamily: 'poppins',
                                fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "4.7",
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'poppins',
                                  
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Text(
                          '13',
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'poppins',
                        
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Text(
                          '10+',
                          //textAlign: TextAlign.center,
                          style: TextStyle(  fontFamily: 'poppins',
                                  
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reviews',
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'poppins',
                              
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        Text(
                          '   Clients',
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,
                            
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        Text(
                          'Experience',
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'poppins',
                                      
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      indent: 20,
                      endIndent: 20,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(  fontFamily: 'poppins',
                                  
                                fontWeight: FontWeight.w700, fontSize: 14),
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
                            SizedBox(height: 12),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: AutoSizeText(
                                '${trainernames[index]} is a professional trainer and nutritionist who has 10 years of experience in this field.',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                  
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
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Certifications',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "•  Golds gym certified trainer.",
                          style: TextStyle(fontSize: 12,  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Text("•  Golds gym certified nutritionist.",
                            style: TextStyle(fontSize: 12,  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Text("•  All time calisthenics champion.",
                            style: TextStyle(fontSize: 12,  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,)),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Specialization',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14,  fontFamily: 'poppins',
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
                            SizedBox(height: 12),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: AutoSizeText(
                                'Bodybuilding | Workout | Calesthenics | Zumba | HIIT | Cardio | Diet & Nutrition.',
                                style: TextStyle(  fontFamily: 'poppins',
                                    
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
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            height: 32,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Colors.amber,
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/insta_icon.png"))),
                          ),
                        ),
                        Text('@${trainernames[index]}_xyz', style: TextStyle(  fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400, fontSize: 13),)
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.022,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Reviews',
                            style: TextStyle(  fontFamily: 'poppins',
                              
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          Text(
                            '4.7',
                            style: TextStyle(  fontFamily: 'poppins',
                                
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                          Text(
                            '(33 reviews)',
                            style: TextStyle(  fontFamily: 'poppins',
                                      
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          Spacer(),
                          GestureDetector(
                            child: Icon(
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
                    ),
                  ],
                ),
              )),
        ),
      );
}
