import 'package:app_settings/app_settings.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/Home/icons/profileicon_icons.dart';
import 'package:vyam_2_final/Home/views/Catagory.dart';
import 'package:vyam_2_final/Home/views/genarate%20list.dart';
import 'package:vyam_2_final/Home/views/gymStream.dart';
import 'package:vyam_2_final/Home/views/location.dart';
import 'package:vyam_2_final/Home/views/noInternet.dart';
import 'package:vyam_2_final/Home/views/progressCard.dart';
import 'package:vyam_2_final/Home/views/search_function.dart';

import 'package:vyam_2_final/api/api.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';
import 'package:vyam_2_final/controllers/location_controller.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import '../../Notifications/notification.dart';
import '../home_page.dart';
import 'gyms.dart';

class FirstHome extends StatefulWidget {
  const FirstHome({Key? key}) : super(key: key);

  // static bool get Loading => is;

  @override
  State<FirstHome> createState() => _FirstHomeState();
}

class _FirstHomeState extends State<FirstHome> {
  ActiveBookingApi activeBookingApi = ActiveBookingApi();

  double finaldaysLeft = 0;
  double progress = 0;
  var getPercentage;
  var progressColor;
  var getdata;
  var textColor;
  var user_data;
  String getDays = '0';
  int totalDays = 0;
  var myaddress;
  var address;
  bool isLoading = true;
  var value2;

  var day_left;
  final auth = FirebaseAuth.instance;

  var location = Get.arguments;
  // Stream<List<DocumentSnapshot>> stream={};
  Geoflutterfire geo = Geoflutterfire();

  // Create a geoFirePoint
  GeoFirePoint center =
      Geoflutterfire().point(latitude: 12.960632, longitude: 77.641603);

// get the collection reference or query
  var collectionReference =
      FirebaseFirestore.instance.collection('product_details');

  double radius = 50;
  String field = 'position';

  Stream<List<DocumentSnapshot>> stream = Geoflutterfire()
      .collection(
          collectionRef:
              FirebaseFirestore.instance.collection('product_details'))
      .within(
          center:
              Geoflutterfire().point(latitude: 12.960632, longitude: 77.641603),
          radius: 50,
          field: 'position');
  getStream() async {
    stream.listen((snapshot) {
      if (snapshot.isEmpty) {
        print(snapshot.length);
        print("****************************************");
      }
      if (snapshot.isNotEmpty) {
        print(snapshot.length);
        print("****************************************");
      }
    });
    // return stream;
  }

  myLocation() async {
    try {
      await FirebaseFirestore.instance
          .collection('user_details')
          .doc(number)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          if (mounted)
            setState(() {
              user_data = snapshot.data();
              GlobalUserData = snapshot.data();
            });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          user_data = {};
          GlobalUserData = {};
          // GlobalUserLocation = "";
        });
      }
    }
  }

  NotificationApi notificationApi = NotificationApi();

  getAddressPin(var pin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getAddress();
    sharedPreferences.setString("pin", pin.toString());
    getAddress();
  }

  getUserDetails() async {
    Position position = await _determinePosition();
    await GetAddressFromLatLong(position);
    await getAddressPin(pin);
    try {
      await FirebaseFirestore.instance
          .collection("user_details")
          .doc(number)
          .update({
        "address": address,
        "lat": position.latitude,
        "long": position.longitude,
        "location": GeoPoint(
          position.latitude,
          position.latitude,
        ),
        "pincode": pin,
        "locality": locality.toLowerCase(),
      });
    } catch (e) {
      FirebaseFirestore.instance.collection("user_details").doc().set({
        "address": address,
        "lat": position.latitude,
        "long": position.longitude,
        "location": GeoPoint(
          position.latitude,
          position.latitude,
        ),
        "pincode": pin,
        "locality": locality.toLowerCase(),
        "from": "notfull"
      });
    }

    getAddressPin(pin);
    // myLocation();
  }

  late LocationPermission permission;

  getEverything() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await getUserId();
    await myLocation();
    // await userDetails.getData();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool showCard = false;

  final backgroundColor = Colors.grey[200];

  final appBarColor = Colors.grey[300];
  // final LocationController yourLocation = Get.find();
  // GymDetailApi gymDetailApi = GymDetailApi();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  TextEditingController searchController = TextEditingController();
  String pin = "";
  String locality = "";
  String subLocality = "";

  final app_bar_controller = ScrollController();
  String searchGymName = '';
  BannerApi bannerApi = BannerApi();
  bool result = false;
  var devicetoken;
  updateDeviceToken() async {
    devicetoken = await getDevicetoken();
    print(devicetoken);
    try {
      await FirebaseFirestore.instance
          .collection("user_details")
          .doc(number)
          .update({"device_token": devicetoken});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getStream();
    updateDeviceToken();
    print(devicetoken);

    print("running two times //////////////////");
    getEverything();

    // if (mounted) {
    //   setState(() {
    //     // myaddress = myaddress;
    //     address = address;
    //     pin = pin;
    //   });
    // }
    // print(address);

    super.initState();
  }

  ///////////////////////////////////////////////////////////////
  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: scaffoldColor,
                appBar: ScrollAppBar(
                  controller: app_bar_controller,
                  elevation: .0,
                  centerTitle: false,
                  backgroundColor: const Color(0xffF4F4F4),
                  leading: IconButton(
                    iconSize: 24,
                    icon: const Icon(
                      Profileicon.location,
                      color: Color(0xff3A3A3A),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await getAddressPin(pin);
                      if (mounted) {
                        setState(() {
                          // myaddress = myaddress;
                          address = address;
                          pin = pin;
                          GlobalUserLocation = user_data["address"];
                        });
                      }
                      Get.to(() => LocInfo());
                    },
                  ),
                  title: Transform(
                    transform: Matrix4.translationValues(-26, 0, 0),
                    child: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await getAddressPin(pin);
                        if (mounted) {
                          setState(() {
                            // myaddress = myaddress;
                            address = address;
                            pin = pin;
                            GlobalUserLocation = user_data["address"];
                          });
                        }
                        Get.to(() => LocInfo());
                      },
                      child: SizedBox(
                        width: size.width * .666,
                        height: 45,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (GlobalUserData["address"] == null)
                                Text(
                                  "Tap here to choose your Location",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff3A3A3A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              if (GlobalUserData["address"] != null)
                                Text(
                                  GlobalUserData["address"].toString() == ""
                                      ? "Tap here to choose your Location"
                                      : GlobalUserData["address"].toString(),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff3A3A3A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            IconButton(
                              // NOTIFICATION NUMBER CALLING
                              icon: Badge(
                                badgeContent: Text("1"),
                                borderRadius: BorderRadius.circular(5),
                                child: const ImageIcon(
                                  AssetImage("assets/icons/Notification.png"),
                                  size: 27,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => NotificationDetails());
                                print(GlobalUserData);
                              },
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                body: Snap(
                  controller: app_bar_controller.appBar,
                  child: SingleChildScrollView(
                    controller: app_bar_controller,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Divider(
                                  height: .3,
                                  thickness: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),

                              SizedBox(
                                height: 60,
                              ),

                              const SizedBox(
                                height: 9,
                              ),
                              // if (searchGymName.isEmpty)

                              Column(
                                children: [
                                  if (getPercentage != 100) ProgressCard(),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      Get.to(CouponDetails(
                                        cartValue: 100,
                                        type: '',
                                      ));
                                    },
                                    child: Banner(bannerApi: bannerApi),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Catagory(),
                                  const SizedBox(
                                    height: 7,
                                  ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 0,
                                      child: SizedBox(
                                        height: 30,
                                        width: 130,
                                        child: Center(
                                          child: Text(
                                            "Nearby Gyms",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  BuildBox()
                                  // LocationList()
                                ],
                              )
                            ],
                          ),
                          Positioned(top: 15, child: SearchIt()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Container Search(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .92,
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          autofocus: false,
          textAlignVertical: TextAlignVertical.bottom,
          onSubmitted: (value) async {
            FocusScope.of(context).unfocus();
          },
          controller: searchController,
          onChanged: (value) {
            if (value.length == 0) {
              FocusScope.of(context).unfocus();
            }
            if (mounted) {
              setState(() {
                searchGymName = value.toString();
              });
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Profileicon.search),
            hintText: 'Search',
            hintStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
    required this.bannerApi,
  }) : super(key: key);

  final BannerApi bannerApi;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: StreamBuilder<QuerySnapshot>(
        stream: bannerApi.getBanner,
        builder: (context, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        height: 143,
                        imageUrl: data.docs[index]["image"],
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
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
    );
  }
}

//Todo internet
// getInternet()async{
//   var listener = InternetConnectionChecker().onStatusChange.listen((status) {
//     switch (status) {
//       case InternetConnectionStatus.connected:
//         print('Data connection is available.');
//         // Get.offAll(HomePage());
//
//         break;
//       case InternetConnectionStatus.disconnected:
//
//         Get.offAll(NoInternet());
//         break;
//     }
//   });
// }

//Todo get details
// getProgressStatus() async {
//   try{
//     int finalDate = int.parse(getDays);
//
//     finalDate = totalDays - finalDate;
//     finaldaysLeft = finalDate / totalDays;
//     day_left = totalDays - int.parse(getDays);
//     // progress=double.parse((100 * getDays/totalDays).toInt());
//
//     getPercentage = 100 * int.parse(getDays.toString()) / totalDays;
//     progress = (double.parse(getPercentage.toString()) / 100);
//     // locationController.YourLocation(location);

//     if (getPercentage >= 90) {
//       progressColor = Colors.red;
//       textColor = Colors.red;
//       showCard = true;
//     }
//     if (getPercentage <= 89 && getPercentage >= 75) {
//       showCard = true;
//
//       progressColor = const Color.fromARGB(255, 255, 89, 0);
//       textColor = const Color.fromARGB(255, 255, 89, 0);
//     }
//     if (getPercentage <= 74 && getPercentage >= 50) {
//       progressColor = Colors.orange;
//       textColor = Colors.orange;
//       showCard = true;
//     }
//     if (getPercentage <= 49 && getPercentage >= 0) {
//       progressColor = Colors.yellow;
//       textColor = Colors.amberAccent;
//       showCard = true;
//     } else {
//       showCard = false;
//     }
//   }catch(e){
//     showCard=false;
//   }
// }

//TODO: check avalablity

// checkAvablity()async{
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   print("service status $serviceEnabled");
//   if (!serviceEnabled || GlobalUserData["address"] == "" || GlobalUserData["address"] == null) {
//     showDialog(
//       context: context,
//       builder: (context) => WillPopScope(
//
//         onWillPop: ()async {
//           print("here this one");
//           Get.back();
//           return true;
//         },
//         child: AlertDialog(
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(16))),
//           content: SizedBox(
//             height: 220,
//             width: 180,
//             child: Column(
//               children: [
//                 Image.asset(
//                   "assets/icons/Group188.png",
//                   height: 50,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "Enable device location",
//                   style: GoogleFonts.poppins(
//                       fontSize: 15, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                   width: 180,
//                   child: Text(
//                     "Please enable location for accurate location and nearest gyms",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Image.asset("assets/icons/icons8-approval.gif",
//                       //   height: 70,
//                       //   width: 70,
//                       // ),
//
//                       // const SizedBox(width: 15),
//                       GestureDetector(
//                         onTap: () async {
//                           Navigator.pop(context);
//                           Position position = await Geolocator.getCurrentPosition();
//
//                           setState(() {
//                             isLoading=true;
//                           });
//                           await GetAddressFromLatLong(position);
//                           if (mounted) {
//                             setState(() {
//                               myaddress = myaddress;
//                               address = address;
//                               pin = pin;
//                             });
//                           }
//                           await FirebaseFirestore.instance
//                               .collection("user_details")
//                               .doc(number)
//                               .update({
//                             "location":
//                             GeoPoint(position.latitude, position.longitude),
//                             "address": address,
//                             // "lat": position.latitude,
//                             // "long": position.longitude,
//                             "pincode": pin,
//                             "locality": locality,
//                             "subLocality": locality,
//                             // "number": number
//                           });
//                           // await Get.offAll(() => HomePage());
//                           setState(() {
//                             // myaddress = myaddress;
//                             address = address;
//                             pin = pin;
//                             GlobalUserLocation = user_data["address"];
//                             isLoading=false;
//                           });
//                           // Position position = await _determinePosition();
//                           // await GetAddressFromLatLong(position);
//                           // if (mounted) {
//                           //   setState(() {
//                           //     myaddress = myaddress;
//                           //     address = address;
//                           //     pin = pin;
//                           //   });
//                           // }
//                           // await FirebaseFirestore.instance
//                           //     .collection("user_details")
//                           //     .doc(number)
//                           //     .update({
//                           //   "location":
//                           //   GeoPoint(position.latitude, position.longitude),
//                           //   "address": address,
//                           //   // "lat": position.latitude,
//                           //   // "long": position.longitude,
//                           //   "pincode": pin,
//                           //   "locality": locality,
//                           //   "subLocality": locality,
//                           //   // "number": number
//                           // });
//                           // await Get.offAll(() => HomePage());
//                         },
//                         child: Container(
//                             height: 51,
//                             width: 145,
//                             decoration: BoxDecoration(
//                                 color: HexColor("292F3D"),
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 3, right: 3, top: 2, bottom: 2),
//                               child: Center(
//                                 child: Text(
//                                   "Enable Location",
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700,
//                                       color: HexColor("FFFFFF")),
//                                 ),
//                               ),
//                             )),
//                       ),
//                     ]),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// TODO: progress card

// ignore: non_constant_identifier_names
// Card ProgressCard(BuildContext context) {
//   return Card(
//     elevation: 5,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('bookings')
//             // .doc(number)
//             // .collection("user_booking")
//             .where("userId", isEqualTo: number)
//             .where("booking_status", isEqualTo: "active")
//             .snapshots(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const SizedBox();
//           }
//           if (!snapshot.hasData) {
//             return Container();
//           }
//           if (snapshot.hasData) {
//             final data = snapshot.requireData;
//             if (data.size == 0) {
//               return const SizedBox();
//             }
//             var document = snapshot.data.docs;
//             print("dee/////////////////");
//             print(document);
//             getProgressStatus();
//             return document.isNotEmpty
//                 ? ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 1,
//                     itemBuilder: (context, index) {
//
//                       // getDays = (data.docs[index]["booking_date"]
//                       //         .toDate()
//                       //         .difference(DateTime.now())
//                       //         .inDays).abs()
//                       //     .toString();
//                       // // getDays=getDays
//
//                       getDays = (DateTime.now().difference(data.docs[index]["booking_date"].toDate()).inDays).toString() ;
//
//                       totalDays =(data.docs[index]["plan_end_duration"].toDate().difference(data.docs[index]["booking_date"].toDate()).inDays) ;
//                       totalDays=totalDays.abs();
//                       print(totalDays);
//                       print(getDays);
//
//                       final percent = double.parse(
//                           (100 * int.parse(getDays.toString()) ~/ totalDays)
//                               .toStringAsFixed(1));
//                       print(percent);
//                       print(percent);
//
//                       if(percent>=0.0000000000000000000000000000000000000000001 && int.parse(getDays) >= -1){
//                         return
//                           Stack(
//                             children: [
//                               Container(
//                                   height: 130,
//                                   width: MediaQuery.of(context).size.width,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.white),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Row(children: [
//                                       if (finaldaysLeft != 0)
//                                         Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                     day_left != null
//                                                         ? day_left.toString()
//                                                         : "",
//                                                     style: GoogleFonts.poppins(
//                                                         color: textColor,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                         FontWeight.bold)),
//                                                 const SizedBox(
//                                                   width: 2,
//                                                 ),
//                                                 Text("days to go",
//                                                     style: GoogleFonts.poppins(
//                                                         color: Colors.black,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                         FontWeight.bold)),
//                                               ],
//                                             ),
//                                             // const SizedBox(
//                                             //   height: 5,
//                                             // ),
//                                             Text(
//                                                 data.docs[index]['gym_details']
//                                                 ["name"] ??
//                                                     "",
//                                                 style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w500)),
//                                             // const SizedBox(
//                                             //   height: 5,
//                                             // ),
//                                             Text("Stay Strong !",
//                                                 style: GoogleFonts.poppins(
//                                                     fontSize: 13,
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold)),
//                                           ],
//                                         ),
//                                       if (finaldaysLeft == 0)
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                           children: [
//                                             SizedBox(
//                                               width: 120,
//                                               child: Text(
//                                                   "Your Subscription has been expired",
//                                                   maxLines: 2,
//                                                   style: GoogleFonts.poppins(
//                                                       color: Colors.red,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight.bold)),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 print("buy");
//                                               },
//                                               child: Text("Buy new packages",
//                                                   style: GoogleFonts.poppins(
//                                                       color: Colors.red,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                       FontWeight.bold)),
//                                             ),
//                                           ],
//                                         ),
//                                       const Spacer(),
//                                       CircularPercentIndicator(
//                                         animation: true,
//                                         radius: 44,
//                                         lineWidth: 12.0,
//                                         percent: progress,
//                                         progressColor: progressColor,
//                                       ),
//                                     ]),
//                                   )),
//                               Positioned(
//                                 right: MediaQuery.of(context).size.width * .0895,
//                                 bottom: 53,
//                                 child: Text(
//                                   "${percent}%",
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 16, fontWeight: FontWeight.bold),
//                                 ),
//                               )
//                             ],
//                           );
//                       }
//                       return SizedBox();
//                     },
//                   )
//                 : Container();
//           }
//           return const CircularProgressIndicator();
//         }),
//   );
// }

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
