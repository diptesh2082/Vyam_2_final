import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Amenites extends StatelessWidget {
  const Amenites({Key? key, required this.amenites}) : super(key: key);
  final amenites;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('amenities')
            // .where('amenity_id', whereIn: widget.amenites)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var document = snapshot.data.docs;
          var documents = [];
          document.forEach((event) {
            if (amenites.contains(event["amenity_id"])) {
              documents.add(event);
            }
          });
          // documents = documents.where((element) {
          //   return widget.amenites.toList().contains(element
          //    .get('amenity_id').toString());
          //     // element
          //     //   .get('amenity_id')
          //     //   .toString().(widget.amenites);
          //
          //       // .contains();
          // }).toList();
          return documents.isNotEmpty
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return amenities(documents, index);
                  }),
                  separatorBuilder: (context, _) => SizedBox(
                      // width: 3,
                      ),
                  itemCount: documents.length)
              : SizedBox();
        },
      ),
    );
  }

  Widget amenities(List documents, int index) => Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber,
            // backgroundImage: CachedNetworkImageProvider(
            //       documents[index]['image'],
            //   // maxHeight: 30,
            //   // maxWidth: 30
            //     ),
            child: Container(
              height: 40,
              width: 40,
              child: Image(
                image: CachedNetworkImageProvider(
                  documents[index]['image'].toString(),
                ),
                // width: 30,
                // height:30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 38,
            child: Text(
              documents[index]['name'],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      );
}
