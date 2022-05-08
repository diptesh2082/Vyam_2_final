import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gyms.dart';
class Catagory extends StatelessWidget {
  const Catagory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('category')
        .orderBy("position")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator());
          }
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator());
          }
          var categoryDocs = snapshot.data.docs;
          return ListView.separated(
            shrinkWrap: true,
            itemCount: categoryDocs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return GestureDetector(
                child: Stack(
                  alignment:
                  AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: categoryDocs[index]
                        ['image'],
                        height: 150,
                        width: 124,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(15),
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
                      height: 150,
                      width: 124,
                      padding: const EdgeInsets.only(
                          right: 8, bottom: 10),
                    ),
                    Text(
                      categoryDocs[index]['name'] ?? "",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onTap: () async{
                  String type = await categoryDocs[index]['name'];
                  print(type);
                  await Get.to(() => GymOption(), arguments: {
                    "type": type.toLowerCase(),
                  });
                  FocusScope.of(context).unfocus();
                },
              );
            },
            separatorBuilder:
                (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          );
        },
      ),
    );
  }
}