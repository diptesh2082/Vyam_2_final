// ignore_for_file: prefer_typing_uninitialized_variables, prefer_is_empty

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart' as core;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/Home/icons/home_icon_icons.dart';
import 'package:vyam_2_final/Home/views/location.dart';
import 'package:vyam_2_final/Home/views/yogaoptions.dart';
import 'package:vyam_2_final/Home/views/zumbaoption.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/splash_screen.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';
import 'package:vyam_2_final/controllers/location_controller.dart';
import 'package:vyam_2_final/controllers/package_controller.dart';
import 'package:vyam_2_final/gymtype/gymtype.dart';
import 'package:vyam_2_final/gymtype/yogatype.dart';
import 'package:vyam_2_final/gymtype/zumbatype.dart';
import '../../Notifications/notification.dart';
import 'gyms.dart';
const String api = "AIzaSyBdpLJQN_y-VtLZ2oLwp8OEE5SlR8cHHcQ";
core.GoogleMapsPlaces _places = core.GoogleMapsPlaces(apiKey: api);

class FirstHome extends StatefulWidget {
  // static bool loading=isLoading;
  const FirstHome({Key? key}) : super(key: key);

  // static bool get Loading => is;

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
  var user_data;
  String getDays = '0';
  int totalDays = 0;
  var myaddress ;
  var address;
  bool isLoading=true;
  // var location = Get.arguments;

  // var data;
  // await FirebaseFirestore.instance
  //     .collection('user_details')
  //     .doc(number)
  //     .get()
  //     .then((DocumentSnapshot documentSnapshot) {
  // if (documentSnapshot.exists) {
  // print('Document exists on the database');
  // setState(() {
  // user_data=documentSnapshot.data();
  // });
  myLocation() async {
    // number=getUserId();
    // print(number);
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(number)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        setState(() {
          user_data=documentSnapshot.data();
        });
        // user_data=documentSnapshot.data();
      }
    });
  }

  UserDetails userDetails = UserDetails();
  NotificationApi notificationApi = NotificationApi();

  getAddressPin(var pin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getAddress();
    sharedPreferences.setString("pin", pin.toString());
    getAddress();
  }

  // Future nearbyGyms(var document)async{
  //   document = await document.where((element) {
  //     return element
  //         .get('pincode')
  //         .toString()
  //         .toLowerCase()
  //         .contains(address2.toLowerCase());
  //   }).toList();
  // }
  getUserDetails() async {
    Position position = await _determinePosition();
    await GetAddressFromLatLong(position);
    // await UserApi.updateUserAddress(
    //     address, [position.latitude, position.longitude], pin
    // );
    await getAddressPin(pin);
    await FirebaseFirestore.instance
        .collection("user_details")
        .doc(number)
        .update({
      "address": address,
      "lat": position.latitude,
      "long": position.longitude,
      "pincode": pin,
      "locality": locality,
    });
    getAddressPin(pin);
    myLocation();
  }
  getEverything()async {
    await getUserId();
    await myLocation();
    await getUserDetails();
    await userDetails.getData();
    isLoading=false;

  }

  @override
  void initState() {
    // getUserId();
    getEverything();
    // print(number);
    // FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    // myLocation();
    // getUserDetails();
    // userDetails.getData();

    // getNumber();
    // number=getUserId();
    // number==null?number=getUserId().toString():number=number;

    print(address2);
    setState(() {
      myaddress = myaddress;
      address = address;
      pin = pin;

    });
    // userLocation();

    // getNumber();

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  String locality = "";
  String subLocality = "";
  GymAllApi gymAll = GymAllApi();
  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    address =
        "${place.subLocality},${place.locality},${place.name},${place.street},${place.postalCode}";
    pin = "${place.postalCode}";
    locality = "${place.locality}";
    subLocality = "${place.subLocality}";
  }

  // List<DocumentSnapshot> document = [];

  String searchGymName = '';
  BannerApi bannerApi = BannerApi();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return
      Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar:  AppBar(
        elevation: .0,
        centerTitle: false,
        backgroundColor: const Color(0xffF4F4F4),
        title: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            Transform(
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
                      FocusScope.of(context).unfocus();
                      // Get.back();
                      // print(_auth.currentUser?.uid);
                      // Position position = await _determinePosition();
                      // await GetAddressFromLatLong(position);
                      // await UserApi.updateUserAddress(
                      //     address, [position.latitude, position.longitude], pin
                      // );
                      await getAddressPin(pin);

                      setState((){
                        // myaddress = myaddress;
                        address = address;
                        pin = pin;
                      });
                      Get.to(()=>LocInfo());
                    },
                  ),
                  SizedBox(
                    width: size.width * .55,
                    child: Text(
                      user_data!=null ? user_data["address"]:"your Location",
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
          ],
        ),
        actions: [
          Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              IconButton(
                icon: const Icon(
                  HomeIcon.notification,
                  color: Colors.black,
                ),
                onPressed: () {
                  // print(number);
                  FocusScope.of(context).unfocus();

                  Get.to(const NotificationDetails());
                },
              ),
            ],
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(

                      onChanged: (value) {
                        // print(value.toString());
                        setState(() {

                          searchGymName = value.toString();
                        });
                        //
                        // print(searchGymName);
                      },
                      // onSubmitted: (value) {
                      //   // ignore: avoid_print
                      //   print('Submitted text: $value');
                      // },
                      decoration: InputDecoration(
                        prefixIcon: Image.asset("assets/images/Search.png"),
                        hintText: 'Search',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // CupertinoSearchTextField(
              //   onChanged: (value) {
              //     setState(() {
              //       searchGymName = value.toString();
              //     });
              //
              //     print(searchGymName);
              //   },
              //   decoration: BoxDecoration(
              //       color: Colors.grey[300],
              //       borderRadius: BorderRadius.circular(10)),
              //   onSubmitted: (value) {
              //     // ignore: avoid_print
              //     print('Submitted text: $value');
              //   },
              // ),
              // const SizedBox(
              //   height: 4,
              // ),
              const SizedBox(
                height: 12,
              ),
              if (getPercentage != 100) ProgressCard(context),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.to(CouponDetails());
                },
                child: SizedBox(
                  height: 135,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: bannerApi.getBanner,
                    builder: (context, AsyncSnapshot streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final data = streamSnapshot.requireData;
                      return ListView.builder(
                        // controller: _controller.,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.size,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Material(
                                    elevation: 5,
                                    color: const Color(0xffF4F4F4),
                                    child: Image.network(data.docs[index]["image"])),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          );
                        },
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
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.OptionsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, int index) {
                    return SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(()=>GymOption(),arguments: {
                                  "type":controller.OptionsList[index].type,
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Material(
                                elevation: 5,
                                color: const Color(0xffF4F4F4),
                                child: Image.asset(
                                    controller.OptionsList[index].imageAssets),
                              )),
                          const SizedBox(
                            width: 5,
                          )

                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {  return Divider(); },
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

                      var document = streamSnapshot.data.docs;

                      if (searchGymName.length > 0) {
                        document = document.where((element) {
                          return element
                              .get('name')
                              .toString()
                              .toLowerCase()
                              .contains(searchGymName.toLowerCase());
                        }).toList();
                      } else {
                        document = document.where((element) {
                          return element
                              .get('pincode')
                              .toString()
                              // .toLowerCase()
                              .contains(address2.toString());
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
                                            FocusScope.of(context).unfocus();
                                            // print("${document[index]["name"]}");
                                            Get.to(
                                                () => GymDetails(
                                                    // getID: document[index].id,
                                                    // gymLocation:
                                                    // document[index]
                                                    // ["location"],
                                                    // gymName: document[index]
                                                    // ["name"],
                                                    ),
                                                arguments: {
                                                  "id": document[index].id,
                                                  "location": document[index]
                                                      ["location"],
                                                  "name": document[index]
                                                      ["name"],
                                                  "docs": document[index]
                                                });
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Material(
                                              elevation: 5,
                                              color: const Color(0xffF4F4F4),
                                              child: Image.asset(
                                                "assets/photos/gym.jpg",
                                                fit: BoxFit.cover,
                                                height: size.height * .25,
                                                width: size.width * .94,
                                              ),
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
                                                  // overflow:
                                                  // TextOverflow.ellipsis,
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
                                                  // "",
                                                  document[index]["address"]??"",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                    // const SizedBox(
                                    //   height: 10,
                                    // )
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
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
      elevation: 5,
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
                return const SizedBox();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  getDays = (data.docs[index]["daysLeft"]??"0");
                  totalDays = int.parse(data.docs[index]["totalDays"] ?? "0") ;

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
                                    Text(data.docs[index]['daysLeft']??"",
                                        style: GoogleFonts.poppins(
                                            color: textColor,
                                            fontWeight: FontWeight.bold)),
                                    Text("days to go",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(data.docs[index]['gym_name']??"",
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
// isLoading ? Expanded(
//
// child: Container(
// color: Colors.white,
// child:
// // SplashScreen()
// const Center(
// child: CircularProgressIndicator(
// color: Colors.amberAccent,
// backgroundColor: Colors.white,
//
//
// ),
// ),
// ),
// ):