import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/golbal_variables.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var visitingFlag = getUserId();
    // setVisitingFlag();
    // Timer(
    //     Duration(seconds: 2),
    //
    // Get.offAll(()=>const LoginPage());
    // );
    // visitingFlag! ?
    // Get.off(
    //     ()=>visitingFlag != null ? HomePage():LoginPage(),
    //   duration: const Duration(seconds: 1,milliseconds: 500),
    // );
    //
    Timer(
      const Duration(seconds: 1),
      () {
        print("////////////////////////");
        print(number);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(color: Colors.black
            // gradient: LinearGradient(colors: [
            //   Color.fromRGBO(00, 00, 00, 1),
            //   // Color.fromRGBO(75, 80, 77, 1),
            // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
            ),
        child: Center(
          child: Image.asset(
            'assets/Illustrations/vyam.png',
            height: 250,
            width: 270,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
