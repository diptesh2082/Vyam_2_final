import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/api.dart';
import '../../golbal_variables.dart';
import '../bookings/gym_details.dart';
class BuildBox extends StatefulWidget {
  @override
  State<BuildBox> createState() => _BuildBoxState();
}

class _BuildBoxState extends State<BuildBox> {
    //   Future<double> distanceFromMyLocation(Location location) async {
    //   double distance = await Geolocator.distanceBetween(
    //       GlobalUserData["location"].latitude,
    //       GlobalUserData["location"].longitude,
    //       location.latitude,
    //       location.longitude) /
    //       1000;
    //   return distance;
//     // }
// sortByDistance(List locationlist) async {
//
//       // make this an empty list by intializing with []
//       List<Map<String, dynamic>> locationListWithDistance = [];
//
//       // associate location with distance
//       for(var location in locationlist) {
//         double distance = calculateDistance(location.latitude,location.longitude, GlobalUserData["location"].latitude,
//           GlobalUserData["location"].longitude,);
//         locationListWithDistance.add({
//           'location': location,
//           'distance': distance,
//         });
//       }
//
//       // sort by distance
//       locationListWithDistance.sort((a, b) {
//         int d1 = a['distance'];
//         int d2 = b['distance'];
//         if (d1 > d2) return 1;
//         else if (d1 < d2) return -1;
//         else return 0;
//       });
//       print(locationListWithDistance);
//       print("-----------------------+++++++++++++++++++++++++++");
//       return locationListWithDistance;
//     }

  // final Map<String, dynamic> locationAndDistance;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child:  SizedBox(
        width: size.width * .94,
        // height: 195,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("product_details")
                .where("locality",isEqualTo: GlobalUserData["locality"])
                .orderBy("location")
                .where("legit",isEqualTo: true)
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
              document.sort((a, b) {
                double d1 = calculateDistance(a["location"].latitude,a["location"].longitude, GlobalUserData["location"].latitude, GlobalUserData["location"].longitude,);
                double d2 =  calculateDistance(b["location"].latitude,b["location"].longitude, GlobalUserData["location"].latitude, GlobalUserData["location"].longitude,);
                if (d1 > d2) return 1;
                else if (d1 < d2) return -1;
                else return 0;
              });


              return document.isNotEmpty
                  ? ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: document.length,
                itemBuilder: (context, index) {
                  var distance = calculateDistance(
                      GlobalUserData["location"].latitude,
                      GlobalUserData["location"].longitude,
                      document[index]["location"].latitude,
                      document[index]["location"].longitude);
                  distance = double.parse((distance).toStringAsFixed(1));
                  // print(distance);
                  if (distance <= 50 && (document[index]["locality"].toString().toLowerCase().trim() ==  GlobalUserData["locality"].toString().toLowerCase().trim())) {
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
                                Get.to(() => GymDetails(), arguments: {
                                  "id": document[index].id,
                                  "location": document[index]["location"],
                                  "name": document[index]["name"],
                                  "docs": document[index],
                                });
                              },
                              child: Stack(
                                children: [
                                  FittedBox(
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(document[index]["gym_status"]?Colors.transparent:Colors.black, BlendMode.color),
                                      child: CachedNetworkImage(
                                        height: 210,
                                        fit: BoxFit.cover,
                                        width:
                                        MediaQuery.of(context).size.width,
                                        imageUrl: document[index]
                                        ["display_picture"] ??
                                            "",
                                        progressIndicatorBuilder: (context,
                                            url, downloadProgress) =>
                                            Center(
                                                child:
                                                CircularProgressIndicator(
                                                    value:
                                                    downloadProgress
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
                                        borderRadius:
                                        BorderRadius.circular(6),
                                        // color: Colors.white10,
                                      ),
                                      height: size.height * .078,
                                      width: size.width * .45,
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
                                            textAlign: TextAlign.center,
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
                                            document[index]["address"] ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                overflow:
                                                TextOverflow.ellipsis,
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w600),
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
                                                "${document[index]["rating"].toString() }",
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
                                                "$distance Km",
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
                                  if(document[index]["gym_status"]==false)
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
                                  if(document[index]["gym_status"]==false)
                                    Positioned(
                                      top: 10,
                                      left: MediaQuery.of(context).size.width*.040,
                                      child: Text("*Temporarily closed",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red
                                        ),
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
                    width: 127,
                    height: 48,
                    child: Text("Coming soon in"
                        " your area",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Image.asset(
                          "assets/Illustrations/undraw_empty_street_sfxm 1.png"
                      )
                  ),
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

