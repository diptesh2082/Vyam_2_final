import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vyam_2_final/Home/profile/profile_page.dart';
import 'package:vyam_2_final/Home/views/explore.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/booking/bookings.dart';
import 'package:vyam_2_final/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  static String id = "/HomePage";
  // const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          children: const [
            ImageIcon(
              AssetImage("assets/icons/Vector.png"),
              size: 30,
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
            ImageIcon(
              AssetImage("assets/icons/active.png"),
              size: 30,
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
            ImageIcon(
              AssetImage("assets/icons/Discovery.png"),
              size: 30,
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
            ImageIcon(
              AssetImage("assets/icons/profile.png"),
              size: 30,
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
  Widget build(BuildContext context) {
    return Scaffold(
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
