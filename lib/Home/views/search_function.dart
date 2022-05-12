import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../icons/profileicon_icons.dart';

class SearchIt extends StatefulWidget {
  const SearchIt({Key? key}) : super(key: key);

  @override
  State<SearchIt> createState() => _SearchItState();
}

class _SearchItState extends State<SearchIt> {
  // TextEditingController searchController = TextEditingController();
  String searchGymName = '';
  FocusNode _node =FocusNode();
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .92,
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextField(
                    focusNode: _node,
                    autofocus: false,
                    textAlignVertical: TextAlignVertical.bottom,
                    onSubmitted: (value) async {
                      FocusScope.of(context).unfocus();
                    },
                    // controller: searchController,
                    onChanged: (value) {
                      if (value.length == 0) {
                        _node.unfocus();
                        // FocusScope.of(context).unfocus();
                      }
                      Get.find<Need>().search.value=value.toString();
                      // if (mounted) {
                      //   setState(() {
                      //     searchGymName = value.toString();
                      //   });
                      // }
                    },
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Profileicon.search),
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                  child:   Column(
                    children: [
                      if (Get.find<Need>().search.value.isNotEmpty)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // height: (searchGymName.length<=2)?500:null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            buildGymBox(),
                            const SizedBox(
                              // height: 500,
                            )
                          ],
                        ),

                      ),
                      if(_node.hasFocus)
                        Container(
                          color: Colors.white,
                          height: 4000,
                        )
                    ],
                  ),

              ),



            ],
          ),
        ],
      ),
    );
  }
  SizedBox buildGymBox() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .94,
      // height: 195,
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("product_details")
              .where("locality".toLowerCase(),
              isEqualTo: GlobalUserData["locality"].toLowerCase())
              .orderBy("location")
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

            if (Get.find<Need>().search.value.length > 0) {
              document = document.where((element) {
                return element
                    .get('name')
                    .toString()
                    .toLowerCase()
                    .contains(Get.find<Need>().search.value.toString()) ||element
                    .get('branch')
                    .toString()
                    .toLowerCase()
                    .contains(Get.find<Need>().search.value.toString()) || element
                    .get('address')
                    .toString()
                    .toLowerCase()
                    .contains(Get.find<Need>().search.value.toString());
              }).toList();
            }
            //  document.where((element) {
            //   print(element);
            // });

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
                if (distance <= 50) {
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
                : SingleChildScrollView(
              // controller: app_bar_controller,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Container(
                      width: size.width * .9,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Material(
                        elevation: .2,
                        borderRadius: BorderRadius.circular(15),
                        // decoration: BoxDecoration(
                        //   color: Colors.white
                        // ),
                        child: Center(
                          child: Text(
                            "No nearby gyms in your area",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
