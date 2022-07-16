import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';

class GymFemale extends StatefulWidget {
  final type;
  const GymFemale({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<GymFemale> createState() => _GymFemaleState();
}

class _GymFemaleState extends State<GymFemale> {
  List events = [];
  List notificationList = [];

  GymAllApi gymAll = GymAllApi();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("product_details")
              // .where("locality",
              // isEqualTo: GlobalUserData["locality"])
              .where("legit", isEqualTo: true)
              .orderBy("location")
              .snapshots(),
          builder: (context, AsyncSnapshot streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var documents = streamSnapshot.data.docs;
            documents.sort((a, b) {
              double d1 = calculateDistance(
                a["location"].latitude,
                a["location"].longitude,
                Get.find<GlobalUserData>().userData.value["location"].latitude,
                Get.find<GlobalUserData>().userData.value["location"].longitude,
              );
              double d2 = calculateDistance(
                b["location"].latitude,
                b["location"].longitude,
                Get.find<GlobalUserData>().userData.value["location"].latitude,
                Get.find<GlobalUserData>().userData.value["location"].longitude,
              );
              if (d1 > d2)
                return 1;
              else if (d1 < d2)
                return -1;
              else
                return 0;
            });
            documents = documents.where((element) {
              return element
                      .get('service')
                      .toString()
                      .toLowerCase()
                      .contains(widget.type) &&
                  ["unisex", "female"].contains(element.get("gender"));
            }).toList();

            var document = [];
            var distances = [];
            documents.forEach((e) {
              var distance = calculateDistance(
                  Get.find<GlobalUserData>().userData.value["location"].latitude,
                  Get.find<GlobalUserData>().userData.value["location"].longitude,
                  e["location"].latitude,
                  e["location"].longitude);
              distance = double.parse((distance).toStringAsFixed(1));
              if (distance <= 20) {
                document.add(e);
                distances.add(distance);
              }
            });

            return document.isNotEmpty
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: document.length,
                    itemBuilder: (context, int index) {

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // height: 195,
                            color: Colors.black,
                            child: GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();

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
                                          document[index]["gym_status"]
                                              ? Colors.transparent
                                              : Colors.black,
                                          BlendMode.color),
                                      child: CachedNetworkImage(
                                        height: 210,
                                        maxHeightDiskCache: 600,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: document[index]
                                                ["display_picture"] ??
                                            "",
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress)),
                                        errorWidget: (context, url, error) =>
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
                                    bottom: size.height * .009,
                                    left: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        // color: Colors.white10,
                                      ),
                                      height: size.height * .078,
                                      width: size.width * .6,
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            // "",
                                            document[index]["address"] ?? "",
                                            // textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 12,
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
                                        borderRadius: BorderRadius.circular(6),
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
                                                "${document[index]["rating"] ?? ""}",
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
                                                CupertinoIcons.location_solid,
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
                                  if (document[index]["gym_status"] == false)
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
                                  if (document[index]["gym_status"] == false)
                                    Positioned(
                                      top: 10,
                                      left: MediaQuery.of(context).size.width *
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
                        );

                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 15,
                      );
                    },
                  )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),

                SizedBox(
                  height: 25,
                ),
                Center(
                    child: Image.asset(
                        "assets/Illustrations/search_empty.png")),
                SizedBox(
                  height: 50,

                ),
                SizedBox(
                  width: 200,
                  height: 48,
                  child: Text(
                    "No fitness options found",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
