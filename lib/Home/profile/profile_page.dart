import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/profile/faq.dart';
import 'package:vyam_2_final/Home/profile/profile.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/regitration_from.dart';

class ProfilePart extends StatefulWidget {
  ProfilePart({Key? key}) : super(key: key);

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserDetails userDetails = UserDetails();
  String name = "";
  String email = "";
  String phone = "";
  String id = "7407926060";

  Future getUserData() async {
    DocumentReference userName =
        await FirebaseFirestore.instance.collection('user_details').doc(id);
    userName.snapshots().listen((snapshot) {
      setState(() {
        name = snapshot.get('name');
        email = snapshot.get('email');
        phone = snapshot.get('number');
      });
      print(name);
      print(email);
      print(phone);
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final FirebaseAuth _auth =FirebaseAuth.instance;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: size.width * .01),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80),
                                        color: Colors.black,
                                      ),
                                      height: 115,
                                      width: 115,
                                    ),
                                  ),
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        radius: size.width / 7,
                                        backgroundColor: Colors.yellowAccent,
                                        child: IconButton(
                                          iconSize: 50,
                                          onPressed: () {
                                            // pickImage(ImageSource.gallery);
                                          },
                                          icon: const Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 70,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  email,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  phone,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(() => Profile());
                                  },
                                  icon: const Icon(Icons.edit)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black54,
                ),
                ListTile(
                  onTap: () {
                    // Get.to(() => const MyOrdersScreen());
                  },
                  leading: const Icon(
                    CupertinoIcons.chat_bubble_text,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    // Get.to(() => const MyOrdersScreen());
                  },
                  leading: const Icon(
                    CupertinoIcons.exclamationmark_bubble,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "About Us",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    // Get.to(() => const MyOrdersScreen());
                  },
                  leading: const Icon(
                    CupertinoIcons.news,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "Terms & Condition",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    // Get.to(() => const MyOrdersScreen());
                  },
                  leading: const Icon(
                    Icons.privacy_tip_outlined,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const Faq());
                  },
                  leading: const Icon(
                    Icons.forum_outlined,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "FAQ",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    // Get.to(() => const MyOrdersScreen());
                  },
                  leading: const Icon(
                    Icons.star_border_outlined,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "Rate Us",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    // Get.to(() => const MyOrdersScreen());
                  },
                  leading: const Icon(
                    Icons.share,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    "Share & Earn",
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black87,
                        ),
                        onPressed: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('number');
                          _auth.signOut();
                          Get.to(() => const LoginPage());
                        },
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}
// accountName: Text("Name",style: TextStyle(
// color: Colors.yellow
// ),),
// accountEmail: Text("email@gmail.com",style: TextStyle(
// color: Colors.yellow
// ),),
// currentAccountPicture: Icon(
// Icons.account_circle,
// size: 100,
// color: Colors.yellow,
// ),