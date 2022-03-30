import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:vyam_2_final/Home/icons/home_icon_icons.dart';
import 'package:vyam_2_final/Home/profile/profile_page.dart';
import 'package:vyam_2_final/Home/views/explore.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/booking/bookings.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../api/api.dart';
import 'icons/home_icon_icons.dart';

class HomePage extends StatefulWidget {
  static String id = "/HomePage";
  // const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  getInfo()async{
    await checkExist(number);
    exist== false?Get.off(const LoginPage()):Get.off(()=>HomePage());
  }
  void initState() {
    // TODO: implement initState

   getInfo();
  }
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          children: const [
            Icon(
              HomeIcon.home_active,
              // AssetImage("assets/icons/Vector.png"),
              // size: 30,
            ),
            Text("Home",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            ),
            )
          ],
        ),
        // title: ("Home"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: const [
            Icon(
                HomeIcon.active_1
              // AssetImage("assets/icons/active.png"),
              // size: 30,
            ),
            Text("Bookings",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // title: ("Bookings"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: const [
            Icon(
                HomeIcon.active_2,
              // AssetImage("assets/icons/Discovery.png"),
              size: 25,
            ),
            Text("Explore",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            ),
            )
          ],
        ),
        // title: ("Explore"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: const [
            Icon(
                HomeIcon.active
              // AssetImage("assets/icons/profile.png"),
              // size: 30,
            ),
            Text("Profile",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // title: ("Profile"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    FocusScope.of(context).unfocus();
    return [
      const FirstHome(),
      const BookingDetails(),
      const Explore(),
       ProfilePart(),
    ];
  }

  int currentIndex = 0;
  final backgroundColor = Colors.grey[200];
  final appBarColor = Colors.grey[300];
  final HomeController controller = Get.put(HomeController());
  final screens = [
    const FirstHome(),
    const BookingDetails(),
    const BookingDetails(),
    const BookingDetails(),
    // BookingDetails(),
    // NotificationDetails(),
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    // controller.dispose();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
    );
  }
}
