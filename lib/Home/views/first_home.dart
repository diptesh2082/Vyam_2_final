// ignore_for_file: prefer_typing_uninitialized_variables, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart' as core;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';
import 'package:vyam_2_final/controllers/location_controller.dart';
import '../../Notifications/notification.dart';
import 'gyms.dart';

const String api = "AIzaSyBdpLJQN_y-VtLZ2oLwp8OEE5SlR8cHHcQ";
core.GoogleMapsPlaces _places = core.GoogleMapsPlaces(apiKey: api);

class FirstHome extends StatefulWidget {
  const FirstHome({Key? key}) : super(key: key);

  @override
  State<FirstHome> createState() => _FirstHomeState();
}

class _FirstHomeState extends State<FirstHome> {
  ActiveBookingApi activeBookingApi = ActiveBookingApi();

  double finaldaysLeft = 0;
  var getPercentage;
  var progressColor;
  var getdata;
  var textColor;
  var data;
  String getDays = '0';
  int totalDays = 0;
  String address = "your location";
  // var location = Get.arguments;

  myLocation() async {
    CollectionReference collectionReference =
        await FirebaseFirestore.instance.collection("user_details");
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
        address = data["address"];
      });
    });
  }

  UserDetails userDetails = UserDetails();
  NotificationApi notificationApi = NotificationApi();

  @override
  void initState() {
    userDetails.getData();
    // userLocation();
    myLocation();

    // int getDays = int.parse(daysLeft[0]["dayleft"]);
    // getDays = 28 - getDays;
    // finaldaysLeft = getDays / 28;
    // getPercentage = finaldaysLeft * 100;
    // if (getPercentage >= 90) {
    //   progressColor = Colors.red;
    // }
    // if (getPercentage <= 89 && getPercentage >= 75) {
    //   progressColor = const Color.fromARGB(255, 255, 89, 0);
    // }
    // if (getPercentage <= 74 && getPercentage >= 50) {
    //   progressColor = Colors.orange;
    // }
    // if (getPercentage <= 49 && getPercentage >= 0) {
    //   progressColor = Colors.yellow;
    // }

    super.initState();
  }

  getProgressStatus() {
    int finalDate = int.parse(getDays);
    finalDate = totalDays - finalDate;
    finaldaysLeft = finalDate / totalDays;
    getPercentage = finaldaysLeft * 100;
    // locationController.YourLocation(location);
    if (getPercentage >= 90) {
      progressColor = Colors.red;
      textColor = Colors.red;
    }
    if (getPercentage <= 89 && getPercentage >= 75) {
      progressColor = const Color.fromARGB(255, 255, 89, 0);
      textColor = const Color.fromARGB(255, 255, 89, 0);
    }
    if (getPercentage <= 74 && getPercentage >= 50) {
      progressColor = Colors.orange;
      textColor = Colors.orange;
    }
    if (getPercentage <= 49 && getPercentage >= 0) {
      progressColor = Colors.yellow;
      textColor = Colors.yellow;
    }
  }

  final backgroundColor = Colors.grey[200];

  final appBarColor = Colors.grey[300];
  // final LocationController yourLocation = Get.find();
  GymDetailApi gymDetailApi = GymDetailApi();

  final HomeController controller = Get.put(HomeController());
  final LocationController locationController = Get.put(LocationController());

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // Future<void> userLocation()async{
  //   final docUser= await FirebaseFirestore.instance.collection("user_list").doc("7407926060");
  //  final snapshot = await  docUser.get();
  //  if (snapshot.exists){
  //    setState(() {
  //      address=snapshot.data as String;
  //    });
  //
  //  }
  // }

  String pin = "";

  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    address = "${place.name},${place.street},${place.postalCode}";
    pin = "${place.postalCode}";
  }

  List<DocumentSnapshot> document = [];

  String searchGymName = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.grey[100],
        title: Transform(
          transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: Row(
            children: [
              IconButton(
                iconSize: 25,
                icon: const Icon(
                  CupertinoIcons.location,
                  color: Colors.black,
                ),
                onPressed: () async {
                  // Get.back();
                  Position position = await _determinePosition();
                  await GetAddressFromLatLong(position);
                  await UserApi.updateUserAddress(
                      address, [position.latitude, position.longitude], pin);

                  setState(() {
                    address = address;
                    pin = pin;
                  });
                  await FirebaseFirestore.instance
                      .collection("user_details")
                      .doc("7407926060")
                      .update({
                    "address": address,
                    "lat": position.latitude,
                    "long": position.longitude,
                    "pin": pin
                  });
                },
              ),
              SizedBox(
                width: size.width * .55,
                child: Text(
                  address,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.bell_fill,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(const NotificationDetails());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CupertinoSearchTextField(
                onChanged: (value) {
                  setState(() {
                    searchGymName = value.toString();
                  });

                  print(searchGymName);
                },
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                onSubmitted: (value) {
                  // ignore: avoid_print
                  print('Submitted text: $value');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              if (getPercentage != 100) ProgressCard(context),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.to(CouponDetails());
                },
                child:
                    // StreamBuilder<QuerySnapshot>(
                    //   stream: ,
                    //   builder: ,
                    // )
                    SizedBox(
                  height: 140,
                  child: ListView.builder(
                    // controller: _controller.,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.boards.length,
                    itemBuilder: (context, int index) {
                      return SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            Image.asset(controller.boards[index].imageAssets),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.OptionsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, int index) {
                    return SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GymOption()));
                              },
                              child: Image.asset(
                                  controller.OptionsList[index].imageAssets)),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nearby Gyms",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .94,
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: gymDetailApi.getGymDetails,
                    builder: (context, AsyncSnapshot streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      document = streamSnapshot.data.docs;

                      if (searchGymName.length > 0) {
                        document = document.where((element) {
                          return element
                              .get('name')
                              .toString()
                              .toLowerCase()
                              .contains(searchGymName.toLowerCase());
                        }).toList();
                      }
                      return document.isNotEmpty
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: document.length,
                              itemBuilder: (context, int index) {
                                return Column(
                                  children: [
                                    Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            print("${document[index]["name"]}");
                                            Get.to(
                                                () => GymDetails(
                                                      getID: document[index].id,
                                                      gymLocation:
                                                          document[index]
                                                              ["location"],
                                                      gymName: document[index]
                                                          ["name"],
                                                    ),
                                                arguments: {
                                                  "id": document[index].id,
                                                  "location": document[index]
                                                      ["location"],
                                                  "name": document[index]
                                                      ["name"]
                                                });
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              "assets/photos/gym.jpg",
                                              fit: BoxFit.cover,
                                              height: size.height * .25,
                                              width: size.width * .94,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: size.height * .009,
                                          left: 5,
                                          child: Container(
                                            height: size.height * .078,
                                            width: size.width * .45,
                                            color: Colors.black26,
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  document[index]["name"],
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  document[index]["address"],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          bottom: size.height * .008,
                                          child: Container(
                                            color: Colors.black26,
                                            alignment: Alignment.bottomRight,
                                            height: size.height * .09,
                                            width: size.width * .22,
                                            padding: const EdgeInsets.only(
                                                right: 8, bottom: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: const [
                                                    // SvgPicture.asset(
                                                    //     'assets/Icons/rating star small.svg'),
                                                    Icon(
                                                      CupertinoIcons.star_fill,
                                                      color: Colors.yellow,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "4.7",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: const [
                                                    // SvgPicture.asset(
                                                    //   'assets/Icons/Location.svg',
                                                    //   color: Colors.white,
                                                    // ),
                                                    Icon(
                                                      CupertinoIcons
                                                          .location_solid,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "1 KM",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Poppins",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            )
                          : const Center(
                              child: Text(
                                "No nearby gyms in your area",
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                ),
                              ),
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Card ProgressCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: StreamBuilder<QuerySnapshot>(
          stream: activeBookingApi.getActiveBooking,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.hasData) {
              final data = snapshot.requireData;
              if (data.size == 0) {
                return SizedBox();
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  getDays = (data.docs[index]["daysLeft"]);
                  totalDays = int.parse(data.docs[index]["totalDays"]);

                  getProgressStatus();
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(children: [
                          if (finaldaysLeft != 1)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(data.docs[index]['daysLeft'],
                                        style: GoogleFonts.poppins(
                                            color: textColor,
                                            fontWeight: FontWeight.bold)),
                                    Text(" days to go",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(data.docs[index]['gym_name'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Stay Strong !",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          if (finaldaysLeft == 1)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Subscription has been expired",
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    print("buy");
                                  },
                                  child: Text("Buy new packages",
                                      style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          const Spacer(),
                          CircularPercentIndicator(
                            animation: true,
                            radius: 30.0,
                            lineWidth: 10.0,
                            percent: finaldaysLeft,
                            progressColor: progressColor,
                          ),
                        ]),
                      ));
                },
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
