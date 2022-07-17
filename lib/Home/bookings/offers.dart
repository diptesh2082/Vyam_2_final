import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Offers extends StatelessWidget {
  final gymID;
  const Offers({Key? key,required this.gymID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      // width: MediaQuery.of(context).size.width*.9,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.
          collection("product_details").
          doc(gymID).
          collection("offers").
          snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: Container());
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context,int index) {
                  return buildButton(
                    context: context,
                    text: snapshot.data!.docs[index]["title"].toString(),
                    subText:  snapshot.data!.docs[index]["offer"].toString(),
                    onClicked: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => buildSheet(),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
  Widget buildButton({
    required String text,
    required VoidCallback onClicked,
    required String subText,
    required context,
  }) =>
      GestureDetector(
        // style: ElevatedButton.styleFrom(
        //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        // ),
        onTap: onClicked,
        child: Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              height: 60,
              // width: 25,
              width: MediaQuery.of(context).size.width*.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/new discount.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          subText,
                          style:  GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      );
  Widget buildSheet() => Container();
}
