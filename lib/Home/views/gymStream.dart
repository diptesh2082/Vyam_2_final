import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api.dart';
import '../../golbal_variables.dart';
import '../bookings/gym_details.dart';

class BuildBox extends StatelessWidget {

  final search;
  static final customCacheManager =
      CacheManager(Config("customCacheKey2", maxNrOfCacheObjects: 80));

   BuildBox({Key? key, required this.search}) : super(key: key);

  Widget build(BuildContext context) {
    print("tdghhhhhhhhhhhghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(search);
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SizedBox(
        width: size.width * .94,
        // height: 195,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("product_details")
                // .where("locality", isEqualTo: GlobalUserData["locality"])
                .orderBy("location")
                .where("legit", isEqualTo: true)
                .snapshots(),
            builder: (context, AsyncSnapshot streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Container());
              }
              if (streamSnapshot.hasError) {
                return const Center(
                    child: Text("check your internet connection"));
              }

              var documents = streamSnapshot.data.docs;
              documents.sort((a, b) {
                double d1 = calculateDistance(
                  a["location"].latitude,
                  a["location"].longitude,
                  Get.find<GlobalUserData>()
                      .userData
                      .value["location"]
                      .latitude,
                  Get.find<GlobalUserData>()
                      .userData
                      .value["location"]
                      .longitude,
                );
                double d2 = calculateDistance(
                  b["location"].latitude,
                  b["location"].longitude,
                  Get.find<GlobalUserData>()
                      .userData
                      .value["location"]
                      .latitude,
                  Get.find<GlobalUserData>()
                      .userData
                      .value["location"]
                      .longitude,
                );
                if (d1 > d2)
                  return 1;
                else if (d1 < d2)
                  return -1;
                else
                  return 0;
              });

              // document = document.where((element) {
              //   return element
              //       .get('gender')
              //       .toString()
              //       .toLowerCase()
              //       .contains("male");
              // }).toList();
              var document = [];
              var distances = [];

              documents.forEach((e) {
                var distance = calculateDistance(
                    Get.find<GlobalUserData>()
                        .userData
                        .value["location"]
                        .latitude,
                    Get.find<GlobalUserData>()
                        .userData
                        .value["location"]
                        .longitude,
                    e["location"].latitude,
                    e["location"].longitude);
                distance = double.parse((distance).toStringAsFixed(1));
                if (distance <= 20) {
                  document.add(e);
                  distances.add(distance);
                }
              });
              if(search){
                if (Get.find<Need>().search.value.length > 0) {
                  document = document.where((element) {
                    return element
                        .get('name')
                        .toString()
                        .toLowerCase()
                        .contains(
                        Get.find<Need>().search.value.toString()) ||
                        element.get('branch').toString().toLowerCase().contains(
                            Get.find<Need>().search.value.toString()) ||
                        element
                            .get('address')
                            .toString()
                            .toLowerCase()
                            .contains(Get.find<Need>().search.value.toString());
                  }).toList();
                }
              }

              print(distances);

              if (document.isNotEmpty) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 0,
                        child: SizedBox(
                          height: 30,
                          width: 130,
                          child: Center(
                            child: Text(
                              "Nearby Gyms",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: document.length,
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Material(
                              elevation: 5,
                              child: Container(
                                // height: 195,
                                color: Colors.black,
                                child: GestureDetector(
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    // var viku=await Geolocator.distanceBetween(GlobalUserData["location"].latitude,
                                    //     GlobalUserData["location"].longitude,
                                    //     document[index]["location"].latitude,
                                    //     document[index]["location"].longitude);
                                    // print(viku);
                                    Get.to(
                                        () => GymDetails(
                                            // gymID: document[index].id,
                                            ),
                                        duration: Duration(milliseconds: 300),
                                        arguments: {
                                          "gymId": document[index].id,
                                        });
                                  },
                                  child: Stack(
                                    children: [
                                      FittedBox(
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              document[index]["gym_status"]
                                                  ? Colors.transparent
                                                  : Colors.black,
                                              BlendMode.color),
                                          child: CachedNetworkImage(
                                            // cacheManager: customCacheManager,
                                            maxHeightDiskCache: 600,
                                            maxWidthDiskCache: 800,
                                            filterQuality: FilterQuality.high,
                                            height: 210,
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            imageUrl: document[index]
                                                    ["display_picture"]
                                                .toString(),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                                    color: Colors.black87
                                                        .withOpacity(1),
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Image.asset(
                                                          "assets/Illustrations/vyam.png",
                                                          height: 120,
                                                          width: 200,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .5,
                                                          child:
                                                              LinearProgressIndicator(
                                                            color:
                                                                Colors.yellow,
                                                          ),
                                                        )
                                                      ],
                                                    ))),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            // height: 195,
                                            // width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        // bottom: size.height * .008,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xaf000000),
                                                    Colors.transparent
                                                  ],
                                                  begin: Alignment(0.0, 1),
                                                  end: Alignment(0.0, -.6))),
                                          alignment: Alignment.bottomRight,
                                          height: 210,
                                          width: 500,
                                          padding: const EdgeInsets.only(
                                              right: 8, bottom: 10),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 2,
                                        left: 8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            // color: Colors.white10,
                                          ),
                                          height: size.height * .078,
                                          width: size.width * .6,
                                          padding: const EdgeInsets.only(
                                              left: 0, bottom: 10),
                                          child: Column(
                                            // mainAxisAlignment:
                                            // MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document[index]["name"] ?? "",
                                                // textAlign: TextAlign.center,
                                                maxLines: 1,
                                                // overflow:
                                                // TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                // "",
                                                document[index]["address"]
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.poppins(
                                                    // overflow:
                                                    // TextOverflow.ellipsis,
                                                    color: Colors.white,
                                                    // fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    // fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 5,
                                        bottom: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            // color: Colors.black26,
                                          ),
                                          alignment: Alignment.bottomRight,
                                          height: 60,
                                          width: 100,
                                          padding: const EdgeInsets.only(
                                              right: 8, bottom: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // SvgPicture.asset(
                                                  //     'assets/Icons/rating star small.svg'),
                                                  const Icon(
                                                    CupertinoIcons.star_fill,
                                                    color: Colors.yellow,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${document[index]["rating"].toString()}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // SvgPicture.asset(
                                                  //   'assets/Icons/Location.svg',
                                                  //   color: Colors.white,
                                                  // ),
                                                  const Icon(
                                                    CupertinoIcons
                                                        .location_solid,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${distances[index]} Km",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (document[index]["gym_status"] ==
                                          false)
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          // bottom: size.height * .008,
                                          child: Container(
                                            // child:
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0x31000000),
                                                      Color(0x56000000)
                                                    ],
                                                    begin: Alignment(0.0, 1),
                                                    end: Alignment(0.0, -.6))),
                                            alignment: Alignment.bottomRight,
                                            height: 210,
                                            width: 500,
                                            padding: const EdgeInsets.only(
                                                right: 8, bottom: 10),
                                          ),
                                        ),
                                      if (document[index]["gym_status"] ==
                                          false)
                                        Positioned(
                                          top: 10,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .040,
                                          child: Text(
                                            "*Temporarily closed",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 20,
                        );
                      },
                    ),
                    // if(document.length <4)
                    Container(
                      height: 400,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120,
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
                                        height: 40,
                                        width: 95,
                                        child: Image.asset(
                                            "assets/Illustrations/Keep_the.png")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: SizedBox(
                                        height: 55,
                                        width: 140,
                                        child: Image.asset(
                                            "assets/Illustrations/Grind_on.png")),
                                  ),
                                  SizedBox(
                                      height: 25,
                                      width: 225,
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
                    ),
                    // if(document.length >=4)
                    //   SizedBox(
                    //     height: 20,
                    //   ),
                  ],
                );
              }

              return search? Column(
                children: [
                  // SizedBox(
                  //   height: 100,
                  // ),
                  Center(
                    child: Material(
                      elevation: .2,
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      // decoration: BoxDecoration(
                      //   color: Colors.white
                      // ),
                      child: Center(
                          child: Image.asset(
                            "assets/Illustrations/search empty.png",
                            height: MediaQuery.of(context).size.width * .95,
                            width: MediaQuery.of(context).size.width * .95,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ):SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 127,
                      height: 48,
                      child: Text(
                        "Coming soon in"
                        " your area",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: Image.asset(
                            "assets/Illustrations/undraw_empty_street_sfxm 1.png")),
                    SizedBox(height: 20),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Follow Us",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            var urllaunchable = await canLaunch(
                                "https://www.instagram.com/vyam.app/?hl=en");
                            if (urllaunchable) {
                              await launch(
                                  "https://www.instagram.com/vyam.app/?hl=en");
                            } else {
                              print("Try Again");
                            }
                          },
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset('assets/icons/insta.png'),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            var urllaunchable = await canLaunch(
                                'https://www.facebook.com/VYAM.application/');
                            if (urllaunchable) {
                              await launch(
                                  'https://www.facebook.com/VYAM.application/');
                            } else {
                              print("Try Again");
                            }
                          },
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset('assets/icons/1.png'),
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   width: 20,
                    // ),
                    // InkWell(
                    //   onTap: () async {
                    //     var urllaunchable = await canLaunch(url);
                    //     if (urllaunchable) {
                    //       await launch(url);
                    //     } else {
                    //       print("Try Again");
                    //     }
                    //   },
                    //   child: SizedBox(
                    //     height: 40,
                    //     width: 40,
                    //     child: Image.asset('assets/icons/twitter.png'),
                    //   ),
                    // ),

                    SizedBox(
                      height: 350,
                    ),
                    Container(
                      // height: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
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
                                        height: 40,
                                        width: 95,
                                        child: Image.asset(
                                            "assets/Illustrations/Keep_the.png")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: SizedBox(
                                        height: 55,
                                        width: 140,
                                        child: Image.asset(
                                            "assets/Illustrations/Grind_on.png")),
                                  ),
                                  SizedBox(
                                      height: 25,
                                      width: 225,
                                      child: Image.asset(
                                          "assets/Illustrations/Group_187.png")),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
