import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Home/profile/faq.dart';
import 'package:vyam_2_final/Home/profile/profile.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/authintication/regitration_from.dart';
String male="https://firebasestorage.googleapis.com/v0/b/vyam-f99ab.appspot.com/o/user_images%2FAvatar%20(1).png?alt=media&token=e30afe98-5559-4288-94e9-3bc734f047d9";
String female="https://firebasestorage.googleapis.com/v0/b/vyam-f99ab.appspot.com/o/user_images%2FAvatar.png?alt=media&token=4cd8e6ae-d54c-45d1-aede-9b695982dba6";
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
  String gender="";
  var imageUrl="";
  final id = number;
  bool Loading=true;

  Future getUserData() async {
    // print(number);
    DocumentReference userName =
    FirebaseFirestore.instance.collection('user_details').doc(id);
    userName.snapshots().listen((snapshot) {
      try{
        if (snapshot.exists)  {
          setState(()  {
            name =  snapshot.get('name');
            // print(number);
            email =  snapshot.get('email');
            phone =  snapshot.get('number');
            gender = snapshot.get("gender");
            imageUrl =  snapshot.get("image");

            Loading=false;
          });
        }
      }catch(e){
        name =  "";
        // print(number);
        email = "";
        phone =  "";
        imageUrl =  "";
        Loading=false;
      }


    });
  }
  // final FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  void initState() {
    // print(number);
    print(_auth.currentUser?.email);
    getUserData();
    print(imageUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print(_auth.currentUser?.uid);

    if (Loading) {
      return const Center(
      child: CircularProgressIndicator(),
    );
    } else {
      return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Colors.white,
          centerTitle: true,
          title:  Text(
            "Profile",
            style: GoogleFonts.poppins(
                // fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w700,
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
                  child: FittedBox(
                    child: Container(
                      // height: 151,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(
                            //   height: 9,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: size.width * .01),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Stack(children: [
                                            imageUrl == ""?
                                            CircleAvatar(
                                              // backgroundImage: ,
                                                radius: 51,

                                                backgroundColor: Colors.white,
                                                // MediaQuery.of(context).size.width * 0.3,
                                                backgroundImage:  gender.toLowerCase()=="male"?AssetImage("assets/Illustrations/Avatarmale.png"):AssetImage("assets/Illustrations/Avatar.png"),
                                            ): CircleAvatar(
                                              // backgroundImage: ,
                                              radius: 51,

                                              backgroundColor: Colors.white,
                                              // MediaQuery.of(context).size.width * 0.3,
                                              backgroundImage:  CachedNetworkImageProvider(imageUrl),
                                            ),
                                       
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width*.1,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.to(() => Profile());
                                            },
                                            icon: const Icon(Icons.edit))
                                      ],
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

                              ],
                            ),
                            const SizedBox(
                              height: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Divider(
                      color: Colors.black54,
                      thickness: .3,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        // print(imageUrl);
                        // print(id);
                        // Get.to(() => const MyOrdersScreen());
                      },
                      leading: const Icon(
                        CupertinoIcons.chat_bubble_text,
                        color: Colors.black54,
                      ),
                      title: const Text(
                        "Contact Us",
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
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
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
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
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
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
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
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
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
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
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
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
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                      ),
                    ),
                    const Divider(
                      thickness: .3,
                      height: 0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
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
                          getNumber();
                          print(number);
                          _auth.signOut();
                          Get.to(() => const LoginPage());
                          // setVisitingFlagFalse();

                        },
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
    }
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

// CircleAvatar(
// radius: size.width / 7,
// backgroundColor: Colors.yellowAccent,
// child: IconButton(
// iconSize: 50,
// onPressed: () {
// // pickImage(ImageSource.gallery);
// },
// icon: const Icon(
// Icons.add_a_photo_outlined,
// size: 70,
// color: Colors.black87,
// ),
// ),
// ),