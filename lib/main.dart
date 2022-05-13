import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:vyam_2_final/Onbording_pages/onboarding1.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/register_email.dart';
import 'package:vyam_2_final/authintication/register_gender.dart';
import 'package:vyam_2_final/authintication/register_name.dart';
import 'package:vyam_2_final/authintication/regitration_from.dart';
import 'package:vyam_2_final/authintication/rphoto.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import 'Home/home_page.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("A bg message just showed up : ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
      await getNumber();
    }
    catch (e) {
    number = "";
  }


  await myLocation();
  await getInfo();
  // getAddress();
  getVisitingFlag();
  // print(GlobalUserData);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );



  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    return GetMaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(primarySwatch: Colors.grey),
      // Themes().lightTheme,

      // home: SplashScreen(),

      // theme: Themes().lightTheme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData &&  exist && _auth.currentUser!=null && number.isNotEmpty) {
            return HomePage();
          }

          return Onboarding1();
        },
      ),

      // initialRoute: ,
      getPages: [
        // GetPage(name: HomePage.id, page: () => HomePage()),
        GetPage(name: "/login", page: () => const LoginPage()),
        // GetPage(name: OtpPage.id, page: () => const OtpPage()),
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
