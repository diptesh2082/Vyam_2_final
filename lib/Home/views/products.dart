// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/api/api.dart';

class Products extends StatelessWidget {
  // const ProductGyms({Key? key}) : super(key: key);
  Products(this.controller, this.length);
  final List controller;
  final double length;

  GymDetailApi gymDetailApi = GymDetailApi();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .93,
      // height: 195,
      child: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: gymDetailApi.getGymDetails,
          builder: (context, AsyncSnapshot streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = streamSnapshot.requireData;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.size,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.to(
                              () => GymDetails(
                                // getID: data.docs,
                                // gymName: data.docs[index]["name"],
                                // gymLocation: data.docs[index]["address"],
                                // docs: data.docs[index],
                              ),
                              arguments: {
                                "pin":data.docs[index]["pincode"],
                                  "id": data.docs[index].id,
                                  "location": data.docs[index]["location"],
                              "docs": data.docs[index]
                              }
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              controller[index].imageAssets,
                              fit: BoxFit.cover,
                              height: size.height * .25,
                              width: size.width * .94,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: size.height * .009,
                          left: 5,
                          child: Container(
                            height: size.height * .078,
                            width: size.width * .45,
                            color: Colors.black12,
                            padding: const EdgeInsets.only(left: 8, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.docs[index]["name"],
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  data.docs[index]["address"],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
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
                          bottom: size.height * .008,
                          child: Container(
                            color: Colors.black12,
                            alignment: Alignment.bottomRight,
                            height: size.height * .09,
                            width: size.width * .22,
                            padding:
                                const EdgeInsets.only(right: 8, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    // SvgPicture.asset(
                                    //     'assets/Icons/rating star small.svg'),
                                    Icon(
                                      CupertinoIcons.star_fill,
                                      color: Colors.yellow,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "4.7",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    // SvgPicture.asset(
                                    //   'assets/Icons/Location.svg',
                                    //   color: Colors.white,
                                    // ),
                                    Icon(
                                      CupertinoIcons.location_solid,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "1 KM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
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
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
              // itemCount: 1,
              // children: [
              //
              // ],
            );
          },
        ),
      ),
    );
  }
}
