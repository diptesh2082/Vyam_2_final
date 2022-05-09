import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:vyam_2_final/Home/icons/home_icon_icons.dart';
import 'package:vyam_2_final/Home/profile/profile_page.dart';
import 'package:vyam_2_final/Home/views/explore.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/Home/views/noInternet.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/booking/bookings.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';
import 'package:vyam_2_final/exploreuo.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../api/api.dart';
import '../main.dart';
import 'icons/home_icon_icons.dart';

class HomePage extends StatefulWidget {
  static String id = "/HomePage";
  // const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool net=true;
  getInternet1()async{
    var listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          setState(() {
            net=true;
          });

          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            net=false;
          });

          break;
      }
    });
  }
// <<<<<<< sarvagya
  bool result=false;
  // getInternet()async{
  //    result = await InternetConnectionChecker().hasConnection;
  //   if(result == true) {
  //     print('YAY! Free cute dog pics!');
  //   } else {
  //     print('No internet :( Reason:');
  //
  //     print(InternetConnectionChecker().connectionStatus);
  //   }
  // }
  checkAvablity()async{
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("service status $serviceEnabled");
    if (!serviceEnabled || GlobalUserData["address"] == "") {
      showDialog(
        context: context,
        builder: (context) => WillPopScope(

          onWillPop: ()async {
            print("here this one");
            // Get.off(HomePage());
            return true;
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            content: SizedBox(
              height: 220,
              width: 180,
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/Group188.png",
                    height: 50,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Enable device location",
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Please enable location for accurate location and nearest gyms",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset("assets/icons/icons8-approval.gif",
                        //   height: 70,
                        //   width: 70,
                        // ),

                        // const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () async {
                            Position position = await determinePosition();
                            await GetAddressFromLatLong(position);
                            if (mounted) {
                              setState(() {
                                myaddress = myaddress;
                                address = address;
                                pin = pin;
                              });
                            }
                            await FirebaseFirestore.instance
                                .collection("user_details")
                                .doc(number)
                                .update({
                              "location":
                              GeoPoint(position.latitude, position.longitude),
                              "address": address,
                              // "lat": position.latitude,
                              // "long": position.longitude,
                              "pincode": pin,
                              "locality": locality,
                              "subLocality": locality,
                              // "number": number
                            });
                            await Get.offAll(() => HomePage());
                          },
                          child: Container(
                              height: 51,
                              width: 145,
                              decoration: BoxDecoration(
                                  color: HexColor("292F3D"),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, right: 3, top: 2, bottom: 2),
                                child: Center(
                                  child: Text(
                                    "Enable Location",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("FFFFFF")),
                                  ),
                                ),
                              )),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  getInfo() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }
// =======
  // getInfo()async{
  //   await checkExist(number);
  //   exist;
  //   // == false?Get.off(const LoginPage()):Get.off(()=>HomePage());
  // }
// >>>>>>> master

  int _counter = 0;
  @override
  void initState() {
// <<<<<<< sarvagya
  getInternet1();
  checkAvablity();
    getInfo();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/launcher_icon',
              ),
            ));
      }
    }
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    super.initState();
  }

  void showNotification(String title, String info) {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
      0,
      "${title} $_counter",
      "$info",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/launcher_icon'),
      ),
    );
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: Column(
          children: [
            ImageIcon(
              AssetImage("assets/icons/inactiveh.png"),

            ),
            Text(
              "Home",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        icon: Column(
          children: const [
            Icon(
              HomeIcon.home_active,
              // AssetImage("assets/icons/Vector.png"),
              // size: 30,
            ),
            Text(
              "Home",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // title: ("Home"),
        activeColorPrimary: Color(0xff292F3D),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Column(
          children: [
            ImageIcon(
              AssetImage("assets/icons/inactive.png"),
            ),
            Text(
              "Bookings",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        icon: Column(
          children: const [
            Icon(HomeIcon.active_1
                // AssetImage("assets/icons/active.png"),
                // size: 30,
                ),
            Text(
              "Bookings",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // title: ("Bookings"),
        activeColorPrimary: Color(0xff292F3D),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Column(
          children: [
            ImageIcon(
              AssetImage("assets/icons/Discoveryi.png"),

            ),
            Text(
              "Explore",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        icon: Column(
          children: const [
            Icon(
              HomeIcon.active_2,
              // AssetImage("assets/icons/Discovery.png"),
              size: 25,
            ),
            Text(
              "Explore",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // title: ("Explore"),
        activeColorPrimary: Color(0xff292F3D),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Column(
          children: [
            ImageIcon(
              AssetImage("assets/icons/Profilei.png"),
            ),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        icon: Column(
          children: const [
            Icon(HomeIcon.active
                // AssetImage("assets/icons/profile.png"),
                // size: 30,
                ),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // title: ("Profile"),
        activeColorPrimary: Color(0xff292F3D),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    FocusScope.of(context).unfocus();
    return [
      const FirstHome(),
      const BookingDetails(),
      const Exploreia(),
      ProfilePart(),
    ];
  }

  int currentIndex = 0;
  final backgroundColor = scaffoldColor;
  final appBarColor = scaffoldColor;
  // final HomeController controller = Get.put(HomeController());
  // final screens = [
  //   const FirstHome(),
  //   const BookingDetails(),
  //   const BookingDetails(),
  //   const BookingDetails(),
  //   // BookingDetails(),
  //   // NotificationDetails(),
  // ];
  @override
  void dispose() {
    // TODO: implement dispose
    // controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return net?Scaffold(
      backgroundColor: scaffoldColor,
      body: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: 65,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showNotification();
      //   },
      //   tooltip: 'Icrement',
      //   child: Icon(Icons.add),
      // ),
    ):NoInternet();
  }
}
