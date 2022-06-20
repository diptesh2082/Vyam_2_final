import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api.dart';
import '../../golbal_variables.dart';
import '../bookings/gym_details.dart';

class BuildBox extends StatelessWidget {
  static final customCacheManager =
      CacheManager(Config("customCacheKey2", maxNrOfCacheObjects: 80));

  Widget build(BuildContext context) {
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (streamSnapshot.hasError) {
                return const Center(
                    child: Text("check your internet connection"));
              }

              var document = streamSnapshot.data.docs;
              if (document.isNotEmpty) {
                document.sort((a, b) {
                  double d1 = calculateDistance(
                    a["location"].latitude,
                    a["location"].longitude,
                    GlobalUserData["location"].latitude,
                    GlobalUserData["location"].longitude,
                  );
                  double d2 = calculateDistance(
                    b["location"].latitude,
                    b["location"].longitude,
                    GlobalUserData["location"].latitude,
                    GlobalUserData["location"].longitude,
                  );
                  if (d1 > d2)
                    return 1;
                  else if (d1 < d2)
                    return -1;
                  else
                    return 0;
                });
              }

              return document.isNotEmpty
                  ? Column(
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: document.length,
                          itemBuilder: (context, index) {
                            var distance = calculateDistance(
                                GlobalUserData["location"].latitude,
                                GlobalUserData["location"].longitude,
                                document[index]["location"].latitude,
                                document[index]["location"].longitude);
                            distance =
                                double.parse((distance).toStringAsFixed(1));
                            // print(distance);
                            if (distance <= 20
                                // && (document[index]["locality"].toString()
                                // .toLowerCase()
                                // .trim() == GlobalUserData["locality"].toString()
                                // .toLowerCase()
                                // .trim())
                                ) {
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
                                              arguments: {
                                                "gymId":document[index].id,

                                              });
                                        },
                                        child: Stack(
                                          children: [
                                            FittedBox(
                                              child: ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    document[index]
                                                            ["gym_status"]
                                                        ? Colors.transparent
                                                        : Colors.black,
                                                    BlendMode.color),
                                                child: CachedNetworkImage(
                                                  // cacheManager: customCacheManager,
                                                  maxHeightDiskCache: 680,
                                                  maxWidthDiskCache: 700,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  height: 210,
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  imageUrl: document[index]
                                                          ["display_picture"] ??
                                                      "",
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      Container(
                                                          color: Colors.black87.withOpacity(.5),
                                                          child: Center(child: Image.asset( "assets/Illustrations/vyam.png",
                                                            height: 120,
                                                            width: 200,
                                                          ))),
                                                  errorWidget: (context, url,
                                                          error) =>
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
                                                        BorderRadius.circular(
                                                            6),
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color(0xaf000000),
                                                          Colors.transparent
                                                        ],
                                                            begin: Alignment(
                                                                0.0, 1),
                                                            end: Alignment(
                                                                0.0, -.6))),
                                                alignment:
                                                    Alignment.bottomRight,
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
                                                      document[index]["name"] ??
                                                          "",
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
                                                      document[index]
                                                              ["address"] ??
                                                          "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: GoogleFonts.poppins(
                                                          // overflow:
                                                          // TextOverflow.ellipsis,
                                                          color: Colors.white,
                                                          // fontFamily: "Poppins",
                                                          fontSize: 12,
                                                          // fontStyle: FontStyle.italic,
                                                          fontWeight: FontWeight.w500),
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
                                                alignment:
                                                    Alignment.bottomRight,
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
                                                          CupertinoIcons
                                                              .star_fill,
                                                          color: Colors.yellow,
                                                          size: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${document[index]["rating"].toString()}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
                                                          "$distance Km",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
                                                          BorderRadius.circular(
                                                              6),
                                                      gradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            Color(0x31000000),
                                                            Color(0x56000000)
                                                          ],
                                                              begin: Alignment(
                                                                  0.0, 1),
                                                              end: Alignment(
                                                                  0.0, -.6))),
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  height: 210,
                                                  width: 500,
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                      fontWeight:
                                                          FontWeight.w400,
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
                            }
                            return Container();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: SizedBox(
                                            height: 40,
                                            width: 95,
                                            child: Image.asset(
                                                "assets/Illustrations/Keep_the.png")),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
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
                    )
                  : Column(
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
                        SizedBox(
                          height: 500,
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
