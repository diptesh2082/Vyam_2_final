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

class GymAll extends StatefulWidget {
  final type;
  const GymAll({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  State<GymAll> createState() => _GymAllState();
}

class _GymAllState extends State<GymAll> {
  List events = [];
  List notificationList = [];

  GymAllApi gymAll = GymAllApi();

  @override
  void initState() {
    super.initState();
    print("/////////"+widget.type);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body:
      // gymAll.getGymDetails ==null ? const Center(
      //   child: Text(
      //     "No nearby gyms in your area",
      //     style: TextStyle(
      //       fontWeight: FontWeight.w100,
      //       fontFamily: "Poppins",
      //       fontSize: 20,
      //     ),
      //   ),
      // ):
      Padding(
        padding:
            const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20),
        child: StreamBuilder(
          stream: gymAll.getGymDetails,
          builder: (context, AsyncSnapshot streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var document = streamSnapshot.data.docs;
              document = document.where((element) {
                return element
                    .get('service')
                    .toString()
                    .toLowerCase()
                    .contains("zumba");
              }).toList();
            print(widget.type);
              print(document);
            if (document==null){
              const Center(
                  child: Text(
                  "No nearby gyms in your area",
                  style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontFamily: "Poppins",
                  fontSize: 20,
              ),
            ),
            );
            }
            // print(document[0]);
            return   document.isNotEmpty
                ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: document.length,
              itemBuilder: (context, int index) {
                var distance=calculateDistance(GlobalUserData["location"].latitude, GlobalUserData["location"].longitude, document[index]["location"].latitude, document[index]["location"].longitude);
                distance=double.parse((distance).toStringAsFixed(1));
                // print(distance);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    // height: 195,
                    color: Colors.black,
                    child: GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        Get.to(
                                () => GymDetails(),
                            arguments: {
                              "id": document[index].id,
                              "location": document[index]
                              ["location"],
                              "name": document[index]["name"],
                              "docs": document[index],
                            });
                      },
                      child: Stack(
                        children: [
                          FittedBox(
                            child: CachedNetworkImage(
                              height: 210,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: document[index]
                              ["display_picture"] ??
                                  "",
                              progressIndicatorBuilder: (context, url,
                                  downloadProgress) =>
                                  Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress
                                              .progress)),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              // height: 195,
                              // width: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            // bottom: size.height * .008,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xaf000000),
                                    Colors.transparent
                                  ],
                                      begin: Alignment(0.0,1),
                                      end: Alignment(0.0,-.6)
                                  )
                              ),
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
                              width: size.width * .45,
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document[index]["name"] ?? "",
                                    textAlign: TextAlign.center,
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
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom:2,
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
                                mainAxisAlignment: MainAxisAlignment.end,
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
                                            fontWeight: FontWeight.w600),
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
                                        "$distance Km",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return  Container(
                  height: 15,
                );
              },
            )
                : const Center(
              child: Text(
                "No nearby gyms in your area",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontFamily: "Poppins",
                  fontSize: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
