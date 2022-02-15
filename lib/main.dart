import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/Themes/themes.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/otp_screen.dart';
import 'package:vyam_2_final/authintication/regitration_from.dart';
import 'Home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes().lightTheme,

      home: LoginPage(),
      // initialRoute: ,
      getPages: [
        GetPage(name: HomePage.id, page: () => HomePage()),
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: OtpPage.id, page: () => OtpPage()),
        GetPage(
            name: RegistrationPage.id, page: () => const RegistrationPage()),
      ],
    );
  }
}
