

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:vyam_2_final/Onbording_pages/onboarding1.dart';

import 'package:vyam_2_final/api/api.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';
import 'package:vyam_2_final/controllers/location_controller.dart';
import '../../Notifications/notification.dart';
import '../home_page.dart';
import 'gyms.dart';

var GlobalUserData;
var GlobalUserLocation;
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
    try{
      await FirebaseFirestore.instance
          .collection('user_details')
          .doc(number)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // print('Document exists on the database');
          setState(() {
            user_data = documentSnapshot.data();
            GlobalUserData = documentSnapshot.data();
            GlobalUserLocation = user_data["pincode"];
          });
          print(GlobalUserLocation);
          // user_data=documentSnapshot.data();
        }
      });
    }catch(e){
      setState(() {
        user_data = {};
        GlobalUserData = {};
        GlobalUserLocation = user_data["pincode"];
      });
    }

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
    try{
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
        "locality": locality,
      });
    }catch(e){
      FirebaseFirestore.instance
          .collection("user_details")
          .doc()
          .set({
        "address": address,
        "lat": position.latitude,
        "long": position.longitude,
        "location": GeoPoint(
          position.latitude,
          position.latitude,
        ),
        "pincode": pin,
        "locality": locality,
        "from":"notfull"
      });
    }

    getAddressPin(pin);
    myLocation();
  }


  getEverything() async {
    await getUserId();
    // print("userid ${number}");
    await myLocation();
    // await getUserDetails();
    // await userDetails.getData();


    setState(() {
      isLoading = false;
    });
  }

  bool showCard = false;
  getProgressStatus() async {
    int finalDate = int.parse(getDays);
    // print(getDays);
    finalDate = totalDays - finalDate;
    finaldaysLeft = finalDate / totalDays;
    day_left = totalDays - int.parse(getDays);
    // progress=double.parse((100 * getDays/totalDays).toInt());
    getPercentage = 100 * int.parse(getDays.toString()) / totalDays;
    progress = double.parse(getPercentage.toString()) / 100;
    // locationController.YourLocation(location);
    print(getPercentage);
    if (getPercentage >= 90) {
      progressColor = Colors.red;
      textColor = Colors.red;
      showCard = true;
    }
    if (getPercentage <= 89 && getPercentage >= 75) {
      showCard = true;

      progressColor = const Color.fromARGB(255, 255, 89, 0);
      textColor = const Color.fromARGB(255, 255, 89, 0);
    }
    if (getPercentage <= 74 && getPercentage >= 50) {
      progressColor = Colors.orange;
      textColor = Colors.orange;
      showCard = true;
    }
    if (getPercentage <= 49 && getPercentage >= 0) {
      progressColor = Colors.yellow;
      textColor = Colors.amberAccent;
      showCard = true;
    } else {
      showCard = false;
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
  TextEditingController searchController = TextEditingController();
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
  final app_bar_controller = ScrollController();
  String searchGymName = '';
  BannerApi bannerApi = BannerApi();
  @override
  void initState() {
    // getUserId();
    getEverything();
    // print(number);
    // FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    // myLocation();
    // getUserDetails();
    userDetails.getData();
    getProgressStatus();

    // getNumber();
    // number=getUserId();
    // number==null?number=getUserId().toString():number=number;

    // print(address2);
    setState(() {
      // myaddress = myaddress;
      address = address;
      pin = pin;
    });
    // userLocation();
    // ProgressCard(context);

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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // setState(() {
    //   GlobalUserLocation= user_data["address"];
    // });

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: const Color(0xffF4F4F4),
            appBar: ScrollAppBar(
              controller: app_bar_controller,
              elevation: .0,
              centerTitle: false,
              backgroundColor: const Color(0xffF4F4F4),
              leading: IconButton(
                iconSize: 24,
                icon: const Icon(
                  CupertinoIcons.location,
                  color: Color(0xff3A3A3A),
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

                  setState(() {
                    // myaddress = myaddress;
                    address = address;
                    pin = pin;
                    GlobalUserLocation = user_data["address"];
                  });
                  Get.to(() => LocInfo());
                },
              ),
              title: Transform(
                transform: Matrix4.translationValues(-21, 0, 0),
                child: GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    // Get.back();
                    // print(_auth.currentUser?.uid);
                    // Position position = await _determinePosition();
                    // await GetAddressFromLatLong(position);
                    // await UserApi.updateUserAddress(
                    //     address, [position.latitude, position.longitude], pin
                    // );
                    await getAddressPin(pin);

                    setState(() {
                      // myaddress = myaddress;
                      address = address;
                      pin = pin;
                      GlobalUserLocation = user_data["address"];
                    });
                    Get.to(() => LocInfo());
                  },
                  child: SizedBox(
                    width: size.width * .606,
                    child: Text(
                      user_data["address"] ?? "your Location",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          color: const Color(0xff3A3A3A),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
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
            body: Snap(
              controller: app_bar_controller.appBar,
              child: SingleChildScrollView(
                controller: app_bar_controller,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Column(
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
                      Search(context),

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
                                            elevation: 0,
                                            color: const Color(0xffF4F4F4),
                                            child: CachedNetworkImage(
                                              imageUrl: data.docs[index]
                                                  ["image"],
                                              // progressIndicatorBuilder: (context,
                                                      // url, downloadProgress) =>
                                                  // Center(
                                                  //     child: CircularProgressIndicator(
                                                  //         value:
                                                  //             downloadProgress
                                                  //                 .progress)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )),
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
                                        Get.to(() => GymOption(), arguments: {
                                          "type": controller
                                              .OptionsList[index].type,
                                        });
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Image.asset(controller
                                          .OptionsList[index].imageAssets)),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
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
                      Container(child: buildGymBox())
                    ],
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
// showCard=true;
          },
          controller: searchController,
          onTap: () {
            FocusScope.of(context).unfocus();
// showCard=false;
// print(showCard);                  FocusScope.of(context).unfocus();
          },

          onChanged: (value) {
// print(value.toString());
          if (value.length==0){
            FocusScope.of(context).unfocus();
          }
//             FocusScope.of(context).unfocus();
            setState(() {
              searchGymName = value.toString();
// value2=value.toString();
            });
//
// print(searchGymName);
          },
// onEditingComplete: (){
//   setState(() {
//     // var value;
//     searchGymName=value2.toString();
//   });
// },
// onSubmitted: (value) {
//   // ignore: avoid_print
//   print('Submitted text: $value');
// },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  SizedBox buildGymBox() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .94,
      // height: 195,
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("product_details")
              .where("pincode", isEqualTo: user_data["pincode"])
              // .where("name",isGreaterThanOrEqualTo: searchGymName.toString())
              .snapshots(),
          builder: (context, AsyncSnapshot streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (streamSnapshot.hasError) {
              return const Center(
                  child: Text("check your internet connection"));
            }

            var document = streamSnapshot.data.docs;

            if (searchGymName.length > 0) {
              document = document.where((element) {
                return element
                    .get('name')
                    .toString()
                    .toLowerCase()
                    .contains(searchGymName.toString());
              }).toList();
            }
            // else {
            //   document = document.where((element) {
            //     return element
            //         .get('pincode')
            //         .toString()
            //         // .toLowerCase()
            //         .contains(address2.toString());
            //   }).toList();
            // }
            return document.isNotEmpty
                ? ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: document.length,
                    itemBuilder: (context, int index) {

                      return FittedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // height: 195,
                            color: Colors.black,
                            child: GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                // print("${document[index]["name"]} ${document[index].id}");
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
                                      "name": document[index]["name"],
                                      "docs": document[index],
                                    });
                              },
                              child: Stack(
                                children: [
                                  FittedBox(
                                    child: CachedNetworkImage(
                                      height: 210,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      imageUrl: document[index]
                                              ["display_picture"] ??
                                          "",
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress)),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      // height: 195,
                                      // width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    // bottom: size.height * .008,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        gradient: const LinearGradient(colors: [
                                          Color(0xaf000000),
                                          Colors.transparent
                                        ],
                                          begin: Alignment(0.0,1),
                                          end: Alignment(0.0,-.6)
                                        )
                                      ),
                                      alignment: Alignment.bottomRight,
                                      height: 210,
                                      width: 500,
                                      padding: const EdgeInsets.only(
                                          right: 8, bottom: 10),

                                    ),
                                  ),
                                  Positioned(
                                    bottom: size.height * .009,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        // color: Colors.white10,
                                      ),
                                      height: size.height * .078,
                                      width: size.width * .45,
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            document[index]["name"] ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            // overflow:
                                            // TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            // "",
                                            document[index]["address"] ?? "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: size.height * .008,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        // color: Colors.black26,
                                      ),
                                      alignment: Alignment.bottomRight,
                                      height: size.height * .09,
                                      width: size.width * .22,
                                      padding: const EdgeInsets.only(
                                          right: 8, bottom: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              // SvgPicture.asset(
                                              //     'assets/Icons/rating star small.svg'),
                                              const Icon(
                                                CupertinoIcons.star_fill,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${document[index]["rating"] ?? ""}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w600),
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
                                                CupertinoIcons.location_solid,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "1 KM",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return  Container(
                        height: 15,
                      );
                    },
                  )
                : SingleChildScrollView(
                    controller: app_bar_controller,
                    child: const Center(
                      child: Text(
                        "No nearby gyms in your area",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontFamily: "Poppins",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
          },
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
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .doc(number)
              .collection("user_booking")
              .where("booking_status", isEqualTo: "active")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const SizedBox();
            }
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.hasData) {
              final data = snapshot.requireData;
              if (data.size == 0) {
                return const SizedBox();
              }
              var document = snapshot.data.docs;
              return document.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        getDays = data.docs[index]["daysLeft"] ?? 0;
                        totalDays = data.docs[index]["totalDays"] ?? 0;
                        print(totalDays);
                        print(getDays);
                        final percent =
                            100 * int.parse(getDays.toString()) ~/ totalDays;
                        // print(snapshot.data.length,);
                        getProgressStatus();
                        return Stack(
                          children: [
                            Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(children: [
                                    if (finaldaysLeft != 1)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  day_left != null
                                                      ? day_left.toString()
                                                      : "",
                                                  style: GoogleFonts.poppins(
                                                      color: textColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text("days to go",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          Text(
                                              data.docs[index]['gym_name'] ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          Text("Stay Strong !",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    if (finaldaysLeft == 1)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Your Subscription has been expired",
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    const Spacer(),
                                    CircularPercentIndicator(
                                      animation: true,
                                      radius: 42.67,
                                      lineWidth: 12.0,
                                      percent: progress,
                                      progressColor: progressColor,
                                    ),
                                  ]),
                                )),
                            Positioned(
                              right: MediaQuery.of(context).size.width * .109,
                              bottom: 53,
                              child: Text(
                                "${percent}%",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        );
                      },
                    )
                  : Container();
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
