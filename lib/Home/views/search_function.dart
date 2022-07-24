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
  // String searchGymName = '';
  FocusNode _node = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _node.unfocus();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 1000,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Obx(
            () => Column(
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
                          Future.delayed(Duration(milliseconds: 200),(){
                            _node.unfocus();
                          });

                          // FocusScope.of(context).unfocus();
                        }
                        // if(value.length!=0){
                          Get.find<Need>().search.value = value.toString().trim();
                        // }

                        // if (mounted) {
                        //   setState(() {
                        //     searchGymName = value.toString();
                        //   });
                        // }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Profileicon.search),
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (Get.find<Need>().search.value.isNotEmpty)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        buildGymBox(),
                        const SizedBox(
                          height: 500,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildGymBox() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .93,
      height: 700,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("product_details")
                  // .where("locality".toLowerCase(),
                  // isEqualTo: GlobalUserData["locality"])
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
                              Get.find<GlobalUserData>().userData.value["location"].latitude,
                              Get.find<GlobalUserData>().userData.value["location"].longitude,
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

                                        Get.to(
                                            () => GymDetails(
                                                  // gymID: document[index].id,
                                                ),
                                            arguments: {
                                              "gymId":document[index].id,

                                            });
                                      },
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          FittedBox(
                                            child: ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                  document[index]["gym_status"]
                                                      ? Colors.transparent
                                                      : Colors.black,
                                                  BlendMode.color),
                                              child: CachedNetworkImage(
                                                maxHeightDiskCache: 600,
                                                filterQuality:
                                                    FilterQuality.low,
                                                height: 210,
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                imageUrl: document[index]
                                                        ["display_picture"] ??
                                                    "",
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)),
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
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color(0xaf000000),
                                                        Colors.transparent
                                                      ],
                                                          begin:
                                                              Alignment(0.0, 1),
                                                          end: Alignment(
                                                              0.0, -.6))),
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
                                                            color: Colors.white,
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
                                                            color: Colors.white,
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
                        children: [
                          SizedBox(
                            height: 100,
                          ),
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
                      );
              },
            ),
            // if(document.length <4)
            Container(
              height: 550,
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
                            height: 10,
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
      ),
    );
  }
}
