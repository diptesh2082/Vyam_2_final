import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Amenites extends StatefulWidget {
  const Amenites({Key? key,required this.amenites}) : super(key: key);
  final amenites;
  @override
  State<Amenites> createState() => _AmenitesState();
}

class _AmenitesState extends State<Amenites> {
  var documents;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('amenities')
            .where('gym_id', arrayContains: widget.amenites)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          documents = snapshot.data.docs;
          return documents.isNotEmpty
              ? ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return amenities(index);
              }),
              separatorBuilder: (context, _) => SizedBox(
                width: 8,
              ),
              itemCount: documents.length)
              : SizedBox();
        },
      ),
    );
  }
  Widget amenities(int index) => FittedBox(
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.amber,
          child: Image(
            image: CachedNetworkImageProvider(
              documents[index]['image'],
            ),
            width: 26.5,
            height: 26.5,
          ),
        ),

        SizedBox(
          width: 90,
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
    ),
  );
}
