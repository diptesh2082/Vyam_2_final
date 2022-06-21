import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:vyam_2_final/Home/icons/profileicon_icons.dart';
import 'package:vyam_2_final/Home/profile/About_Us.dart';
import 'package:vyam_2_final/Home/profile/Contact_Us.dart';
import 'package:vyam_2_final/Home/profile/faq.dart';
import 'package:vyam_2_final/Home/profile/privacyPolicy.dart';
import 'package:vyam_2_final/Home/profile/profile.dart';
import 'package:vyam_2_final/Home/views/explore.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/authintication/login.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import 'Terms_&_Conditions.dart';

String male =
    "https://firebasestorage.googleapis.com/v0/b/vyam-f99ab.appspot.com/o/user_images%2FAvatar%20(1).png?alt=media&token=e30afe98-5559-4288-94e9-3bc734f047d9";
String female =
    "https://firebasestorage.googleapis.com/v0/b/vyam-f99ab.appspot.com/o/user_images%2FAvatar.png?alt=media&token=4cd8e6ae-d54c-45d1-aede-9b695982dba6";

class ProfilePart extends StatefulWidget {
  ProfilePart({Key? key}) : super(key: key);

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart> {
  final String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.findnearestfitness.vyam';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> share() async {
    await FlutterShare.share(
      title: ' ',
      text: 'https://vyam.page.link/vyamFirst',
      linkUrl: 'https://vyam.page.link/vyamFirst',
      //chooserTitle: 'Example Chooser Title'
    );
  }

  UserDetails userDetails = UserDetails();
  String name = "";
  String email = "";
  String phone = "";
  String gender = "";
  var imageUrl = "";
  // final id = number;
  bool Loading = true;
  DefaultCacheManager manager = new DefaultCacheManager();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future cacheImage(BuildContext context, String e) => precacheImage(
        CachedNetworkImageProvider(e),
        context,
      );
  // Future getUserData() async {
  //   print("user is here" + number);
  //   DocumentReference userName =
  //       FirebaseFirestore.instance.collection('user_details').doc(number);
  //   userName.snapshots().listen((snapshot) {
  //     try {
  //       if (snapshot.exists) {
  //         setState(() {
  //           name = snapshot.get('name').toString();
  //           // print(number);
  //           email = snapshot.get('email').toString();
  //           phone = snapshot
  //               .get('userId')
  //               .toString()
  //               .substring(3, snapshot.get('userId').toString().length);
  //           gender = snapshot.get("gender").toString();
  //           imageUrl = snapshot.get("image");
  //           cacheImage(context, snapshot.get("image"));
  //
  //           Loading = false;
  //         });
  //       }
  //     } catch (e) {
  //       print("/////////////////////////////////////");
  //       print(e);
  //       setState(() {
  //         name = "";
  //         // print(number);
  //         email = "";
  //         phone = "";
  //         imageUrl = "";
  //         Loading = false;
  //       });
  //     }
  //     Loading = false;
  //   });
  // }

  // final FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  void initState() {
    // getUserData();
    Loading = false;
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
          backgroundColor: scaffoldColor,
          appBar: AppBar(
            elevation: 0.3,
            backgroundColor: scaffoldColor,
            centerTitle: true,
            title: Text(
              "Profile",
              style: GoogleFonts.poppins(
                  // fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot>(
              stream:FirebaseFirestore.instance.collection('user_details').doc(number).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){

                  return Center(child: CircularProgressIndicator());
                }
                var doc=snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FittedBox(
                        // scrollDirection: Axis.horizontal,
                        child: Container(
                          // height: 151,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(
                                //   height: 9,
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: size.width * 0),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Stack(children: [
                                                doc?.get("image") == "" ||  doc?.get("image") == "null" ||   doc?.get("image") == null
                                                    ? CircleAvatar(
                                                        // backgroundImage: ,
                                                        radius: 51,

                                                        backgroundColor:
                                                            Colors.white,
                                                        // MediaQuery.of(context).size.width * 0.3,
                                                        backgroundImage:  doc?.get("gender")
                                                                    .toLowerCase() ==
                                                                "male"
                                                            ? const AssetImage(
                                                                "assets/Illustrations/Avatarmale.png")
                                                            :doc?.get("gender")
                                                            .toLowerCase() =="female"?AssetImage(
                                                                "assets/Illustrations/Avatar.png"):
                                                        AssetImage(
                                                            "assets/Illustrations/user.png")
                                                  ,
                                                      )
                                                    : CircleAvatar(
                                                        // backgroundImage: ,
                                                        radius: 51,
                                                        backgroundColor:
                                                            Colors.white,
                                                        // MediaQuery.of(context).size.width * 0.3,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                              doc?.get("image"),
                                                          scale: 1,
                                                        ),
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
                                    // Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              doc?.get("name") == "" ?   "no name": doc?.get("name"),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .1,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  print(name);
                                                  print(email);
                                                  print(number);
                                                  Get.to(() => Profile(),
                                                      arguments: {
                                                        "name":  doc?.get("name"),
                                                        "email":  doc?.get("email"),
                                                        "imageUrl":  doc?.get("image"),
                                                        "number":  doc?.get("number"),
                                                        "gender":
                                                        doc?.get("gender").toLowerCase()
                                                      });
                                                },
                                                icon: const ImageIcon(AssetImage(
                                                    "assets/icons/profile-edit.png")))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                child: Text(
                                                  doc?.get("email") != "null"
                                                      ? doc?.get("email")
                                                      : "no email",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "+91-",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  doc?.get("number") != ""
                                                      ? doc?.get("number")
                                                      : "no Phone number",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                      Column(
                        children: [
                          const Divider(
                            color: Colors.black54,
                            thickness: .3,
                            height: 0,
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const ContactUs());
                            },
                            leading: const Icon(
                              Profileicon.contact_us__1_,
                              color: Colors.black54,
                            ),
                            title: Text(
                              "Contact Us",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: .3,
                            height: 0,
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const AboutUs());
                            },
                            leading: ImageIcon(
                              AssetImage("assets/icons/about_us.png"),
                              color: Colors.black54,
                            ),
                            title: Text(
                              "About Us",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: .3,
                            height: 0,
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const TermsAndCondition());
                            },
                            leading: const ImageIcon(
                              AssetImage("assets/icons/terms_and_conditions.png"),
                              color: Colors.black54,
                            ),
                            title: Text(
                              "Terms & Condition",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: .3,
                            height: 0,
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const PrivacyPolicy());
                            },
                            leading: const ImageIcon(
                              AssetImage("assets/icons/privacy_policy.png"),
                              color: Colors.black54,
                            ),
                            title: Text(
                              "Privacy Policy",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
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
                            leading: const ImageIcon(
                              AssetImage("assets/icons/faq.png"),
                              color: Colors.black54,
                            ),
                            title: Text(
                              "FAQ",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: .3,
                            height: 0,
                          ),
                          ListTile(
                            onTap: () {
                              launch(playStoreUrl);
                            },
                            leading: const ImageIcon(
                              AssetImage("assets/icons/rate_us.png"),
                              color: Colors.black54,
                            ),
                            title: Text(
                              "Rate Us",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: .3,
                            height: 0,
                          ),
                          TextButton(
                            onPressed: () async {
                              share();
                              print('PRESSED');
                            },
                            child: ListTile(
                              // onTap: ()async {
                              //   print(number);
                              //   print('SHARE BUTTON PRESSED');
                              //   // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: api);
                              //   // PlacesSearchResponse response =await _places.searchNearbyWithRadius(Location(lng: 31.0424,lat: 42.421,), 100);
                              //   // // Get.to(() => const MyOrdersScreen());
                              //   // print(response.toJson());
                              //
                              // },
                              leading: const ImageIcon(
                                AssetImage("assets/icons/share_app.png"),
                                color: Colors.black54,
                              ),
                              title: Text(
                                "Share",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
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
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: SizedBox(
                      //     height: 37,
                      //     width: 110,
                      //     child: ElevatedButton(onPressed: (){
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => LoginPage()),
                      //
                      //       );
                      //     }, child: Text("Log Out",
                      //       style: GoogleFonts.poppins(
                      //           color: Color(0xffffffff)
                      //       ),
                      //     )
                      //       ,style: ElevatedButton.styleFrom(
                      //         primary: Color(0xff292F3D),
                      //       ),
                      //
                      //     ),
                      //   ),
                      // ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff292F3D),
                              ),
                              onPressed: () async {
                                // SharedPreferences sharedPreferences =
                                //     await SharedPreferences.getInstance();
                                // sharedPreferences.remove('number');
                                // getNumber();
                                // print(number);
                               await manager.emptyCache();
                                await _googleSignIn.signOut();
                                await _auth.signOut();
                                // Get.back();
                                Get.offAll(() => const LoginPage());
                                setVisitingFlagFalse();
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
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: SizedBox(
                                    height: 38,
                                    width: 91,
                                    child: Image.asset(
                                        "assets/Illustrations/Keep_the.png")),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: SizedBox(
                                    height: 50,
                                    width: 134,
                                    child: Image.asset(
                                        "assets/Illustrations/Grind_on.png")),
                              ),
                              SizedBox(
                                  height: 21,
                                  width: 221,
                                  child: Image.asset(
                                      "assets/Illustrations/Group_187.png")),
                              const SizedBox(
                                height: 21,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ));
    }
  }
}
