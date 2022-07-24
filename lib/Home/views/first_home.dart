import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vyam_2_final/Home/icons/profileicon_icons.dart';
import 'package:vyam_2_final/Home/views/Catagory.dart';

import 'package:vyam_2_final/Home/views/gymStream.dart';
import 'package:vyam_2_final/Home/views/location.dart';

import 'package:vyam_2_final/Home/views/progressCard.dart';
import 'package:vyam_2_final/Home/views/search_function.dart';

import 'package:vyam_2_final/api/api.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import 'package:vyam_2_final/golbal_variables.dart';
import '../../Notifications/notification.dart';

class FirstHome2 extends StatelessWidget {
  // final remoteConfig;
  const FirstHome2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirstHome(
      // remoteConfig: remoteConfig,
    );
  }
}

class FirstHome extends StatefulWidget {
// <<<<<<< HEAD
  // final FirebaseRemoteConfig remoteConfig;
  const FirstHome({Key? key}) : super(key: key);
// =======
//   final  remoteConfig;
//   const FirstHome({Key? key, required this.remoteConfig}) : super(key: key);
// >>>>>>> ba0f6c5150ab13a81b2225a1a112fe9af8b13a52

  // static bool get Loading => is;

  @override
  State<FirstHome> createState() => _FirstHomeState();
}

class _FirstHomeState extends State<FirstHome> {
  ActiveBookingApi activeBookingApi = ActiveBookingApi();
  final url =
      "https://play.google.com/store/apps/details?id=com.findnearestfitness.vyam";
  AlertDialog showAlertDialog(
      BuildContext context, FirebaseRemoteConfig remoteConfig) {
    Widget cancel = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Cancel"));
    Widget update = SizedBox(
        width: 140,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(247, 188, 40, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
          ),
          onPressed: () async {
            var urllaunchable = await canLaunch(url);
            if (urllaunchable) {
              await launch(url);
            } else {
              print("Try Again");
            }
          },
          child: Text(
            "Update Now",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ));

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0))),
      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      // title: ,
      content: Container(
        height: 550,
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 300, child: Image.asset('assets/icons/roc.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              remoteConfig.getString("Title"),
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(remoteConfig.getString("Message"),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 70,
            ),
            update,
          ],
        ),
      ),
      // actions: <Widget>[update],
    );
  }

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
              Get.find<GlobalUserData>().userData.value = snapshot.data()!;
            });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          user_data = {};
          Get.find<GlobalUserData>().userData.value = {};
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
    print(
        " +----+-+-+--+--+++++++++-----------++++++++++-------------+-+-+-+-+-+-+-+-+-+-");
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
      await FirebaseMessaging.instance.subscribeToTopic("push_notifications");
      await FirebaseMessaging.instance
          .subscribeToTopic("personalised_notification");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // getStream();]
// <<<<<<< HEAD
//     DefaultCacheManager().emptyCache();
//     print(
//         " +----+-+-+--+--+++++++++-----------++++++++++-------------+-+-+-+-+-+-+-+-+-+-");
// =======
//
    print(
        " +----+-+-+--+--+++++++++-----------++++++++++-------------+-+-+-+-+-+-+-+-+-+-");
// >>>>>>> ba0f6c5150ab13a81b2225a1a112fe9af8b13a52
    updateDeviceToken();
    print(
        " +----+-+-+--+--+++++++++-----------++++++++++-------------+-+-+-+-+-+-+-+-+-+-");
    getEverything();
    print(
        " +----+-+-+--+--+++++++++-----------++++++++++-------------+-+-+-+-+-+-+-+-+-+-");
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
// <<<<<<< HEAD
// =======
//     var update = false;
    // var update = widget.remoteConfig.getBool("Update");
// >>>>>>> ba0f6c5150ab13a81b2225a1a112fe9af8b13a52

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
                        if (Get.find<GlobalUserData>()
                            .userData
                            .value["address"] ==
                            null)
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
                        if (Get.find<GlobalUserData>()
                            .userData
                            .value["address"] !=
                            null)
                          Text(
                            Get.find<GlobalUserData>()
                                .userData
                                .value["address"]
                                .toString() ==
                                ""
                                ? "Tap here to choose your Location"
                                : Get.find<GlobalUserData>()
                                .userData
                                .value["address"]
                                .toString(),
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
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('bookings')
                              .where("userId", isEqualTo: number)
                              .where("booking_status",
                              isEqualTo: "upcoming")
                              .orderBy("order_date", descending: true)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: Container());
                            }
                            if (snapshot.hasError) {
                              return Center(child: Container());
                            }
                            // if(snapshot.data.docs.length==0){
                            //   return Center(child:Container());
                            // }

                            return Badge(
                              elevation:
                              snapshot.data.docs.isNotEmpty ? 2 : 0,
                              badgeColor: snapshot.data.docs.isNotEmpty
                                  ? Colors.red
                                  : Colors.white38,
                              position:
                              BadgePosition.topEnd(top: 7, end: 7),
                              child: IconButton(
                                // NOTIFICATION NUMBER CALLING
                                icon: const ImageIcon(
                                  AssetImage(
                                      "assets/icons/Notification.png"),
                                  size: 27,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  // await DefaultCacheManager().emptyCache();
                                  Get.to(() => NotificationDetails());
                                  // print(GlobalUserData);
                                },
                              ),
                            );
                          }),
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
              physics: ClampingScrollPhysics(),
              controller: app_bar_controller,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Obx(
                      () => Stack(
                    alignment: Alignment.topCenter,
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
                          // if (Get.find<Need>().search.value.isEmpty)
                          Column(
                            children: [
                              if (getPercentage != 100) ProgressCard(),
                              const SizedBox(
                                height: 9,
                              ),
                              Banner(bannerApi: bannerApi),
                              const SizedBox(
                                height: 15,
                              ),
                              // if (Get.find<Need>().search.value.isEmpty)
// <<<<<<< HEAD
//                                     Catagory(),
//                                     if (Get.find<Need>().search.value.isEmpty)
//                                       const SizedBox(
//                                         height: 7,
//                                       ),
//
//                                     if (Get.find<Need>().search.value.isEmpty)
//                                       const SizedBox(
//                                         height: 7,
//                                       ),
//                                     if (Get.find<Need>().search.value.isEmpty)
                              // BuildBox()
                              // LocationList()
// =======
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // if (getPercentage != 100)
                                  //   ProgressCard(),

                                  // Banner(bannerApi: bannerApi),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // if (Get.find<Need>().search.value.isEmpty)
                                  Catagory(),

                                  const SizedBox(
                                    height: 7,
                                  ),

                                  if (Get.find<Need>()
                                      .search
                                      .value
                                      .isEmpty)
                                    const SizedBox(
                                      height: 7,
                                    ),

                                  BuildBox()
                                  // LocationList()
                                ],
                              )
// >>>>>>> ba0f6c5150ab13a81b2225a1a112fe9af8b13a52
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
              // FocusScope.of(context).unfocus();
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
            return Center(child: Container());
          }
          if (streamSnapshot.hasError) {
            return Center(
              child: Container(),
            );
          }
          if (streamSnapshot.data.docs.isEmpty) {
            return Center(
              child: Container(),
            );
          }
          List data = [];
          streamSnapshot.data.docs.forEach((e) {
            if (e["area"] == true) {
              var distance = calculateDistance(
                  Get.find<GlobalUserData>()
                      .userData
                      .value["location"]
                      .latitude,
                  Get.find<GlobalUserData>()
                      .userData
                      .value["location"]
                      .longitude,
                  e["selected_area"].latitude,
                  e["selected_area"].longitude);
              distance = double.parse((distance).toStringAsFixed(1));
              if (distance <= 20) {
                data.add(e);
                // data.add(distance);
              }
            } else {
              data.add(e);
            }
          });

          return ListView.builder(
            // controller: _controller.,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  // FocusScope.of(context).unfocus();
                  if (data[index]["access"] == true &&
                      data[index]["navigation"] != "") {
                    Get.toNamed(data[index]["navigation"] ?? "", arguments: {
                      "gymId": data[index]["gym_id"] ?? "",
                    });
                    // print("hyufufytu");
                  }
                },
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          maxHeightDiskCache: 650,
                          maxWidthDiskCache: 650,
                          filterQuality: FilterQuality.medium,
                          height: 143,
                          width: 311,
                          fit: BoxFit.cover,
                          imageUrl: data[index]["image"].toString(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Container(),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
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
