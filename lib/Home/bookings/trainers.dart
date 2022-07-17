import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'know_trainer.dart';
class Trinerss extends StatelessWidget {
  final gymID;
  final docs;
  const Trinerss({Key? key,required this.gymID,required this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("product_details")
            .doc("${gymID}")
            .collection("trainer")
            .where("eligible", isEqualTo: true)
            .orderBy("position")
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amberAccent,
              ),
            );
          }
          // if (snapshot.hasError) {
          //   return const Center(
          //     child: Text("Theres no trainers"),
          //   );
          // }
          if (snapshot.hasData == false) {
            return Container();
          }
          var trainerdoc = snapshot.data!.docs;
          print(trainerdoc);
          print(
              "+++++++++++++++++++++++++++++++++++++++++++++++");
          return trainerdoc.length == 0
              ? SizedBox()
              : SizedBox(
              height:
              145, //MediaQuery.of(context).size.height / 4.7,
              child: GestureDetector(
                onTap: () {
                  Get.to(
                          () => Trainer(
                        gym_name: docs["name"],
                        gym_brunch:
                        docs["branch"],
                      ),
                      arguments: {
                        "gym_id": gymID,
                        "image":
                        docs["display_picture"]
                      });
                },
                child: Card(
                    elevation: .3,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            12.0)),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets
                                .all(8.0),
                            child: Row(
                              children: [
                                Text('Trainers',
                                    style:
                                    GoogleFonts
                                        .poppins(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                    )),
                                Spacer(),
                                Icon(
                                  Icons
                                      .arrow_forward_ios_outlined,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(
                                left: 8.0),
                            child: SizedBox(
                                height: 100,
                                //MediaQuery.of(context).size.height /
                                //  9,
                                child: ListView
                                    .builder(
                                    shrinkWrap:
                                    true,
                                    itemCount:
                                    trainerdoc
                                        .length,
                                    physics:
                                    const PageScrollPhysics(),
                                    scrollDirection:
                                    Axis
                                        .horizontal,
                                    itemBuilder:
                                        (context,
                                        index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  if (trainerdoc[index]['image'] != null || trainerdoc[index]['image'] != "")
                                                    Container(
                                                      height: 65,
                                                      width: 65,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          //border: Border.all(width: 1),
                                                          image: DecorationImage(image: CachedNetworkImageProvider(trainerdoc[index]['image'], maxHeight: 350, maxWidth: 450), fit: BoxFit.cover)),
                                                    ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(trainerdoc[index]['name'],
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                            ],
                                          ),
                                        ],
                                      );
                                    })),
                          ),
                        ])),
              ));
        });
  }
}
