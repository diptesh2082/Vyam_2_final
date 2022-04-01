import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/Onbording_pages/onboarding1.dart';
import 'package:vyam_2_final/Themes/themes.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/otp_screen.dart';
import 'package:vyam_2_final/authintication/register_email.dart';
import 'package:vyam_2_final/authintication/register_gender.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/authintication/regitration_from.dart';
import 'package:vyam_2_final/authintication/rphoto.dart';
import 'package:vyam_2_final/authintication/splash_screen.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import 'Home/home_page.dart';

// bool visitingFlag = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getNumber();
  getAddress();
  getVisitingFlag();
  // visitingFlag = await getVisitingFlag();
  await myLocation();
  // print("UIYUIYUIYTUYTr${number}");
  print(GlobalUserData);
  // print(number);
  // print(number);
  // print(number);
  // bool? visitingFlag=await getVisitingFlag();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // progress() async{
  //   bool? visitingFlag=await getVisitingFlag();
  //   if (visitingFlag==true){
  //     return HomePage();
  //   }else if(visitingFlag==false){
  //     return const LoginPage();
  //   }
  // }

  // Future get visitingFlag => getVisitingFlag();
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',

      theme:ThemeData(
        primarySwatch: Colors.grey
      ),
      // Themes().lightTheme,

      // home: SplashScreen(),

      // theme: Themes().lightTheme,
      debugShowCheckedModeBanner: false,
      home: visiting_flag ? HomePage():  Onboarding1(),

      // initialRoute: ,
      getPages: [
        GetPage(name: HomePage.id, page: () => HomePage()),
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: OtpPage.id, page: () => const OtpPage()),
        GetPage(
            name: RegistrationPage.id, page: () => const RegistrationPage()),
        GetPage(name: Register1.id, page: () => Register1()),
        GetPage(name: Register2.id, page: () => Register2()),
        GetPage(name: Register3.id, page: () => Register3()),
        GetPage(name: Register4.id, page: () => Register4()),
      ],
    );
  }
}
