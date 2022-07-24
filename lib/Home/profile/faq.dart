import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  // List check=[].(0, 10,[false]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title:  Text(
          'FAQ',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("faq").snapshots(),
          builder: (context,AsyncSnapshot snapshot) {
            var doc=snapshot.data.docs;
            List d=[];
            doc.forEach((e){
              d.add(true);
            });


            print(d);
            return ListView.builder(
                itemCount: doc.length,
                itemBuilder: (context, index) {

                  // final faq = "";
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                      decoration: BoxDecoration(
                        // color: Colors.white12,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(16),
                          child: Tile(index: index, doc: doc, d: d,)),
                    ),
                  );
                });
          }
      ),
    );
  }


}
class Tile extends StatefulWidget {
  var doc;
  var index;
  var d;

  Tile({Key? key,required this.doc,required this.index,required this.d}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        child: ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 500),
          elevation: 0,
          expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
          children: [
            ExpansionPanel(
              body: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white12,
                ),

                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Divider(
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Text(
                      widget.doc[widget.index]["answer"].toString(),
                      style:  GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 14,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          height: 1.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.doc[widget.index]["question"].toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
              isExpanded: widget.d[widget.index],
            )
          ],
          expansionCallback: (int item, bool status) {
            setState(() {
              widget.d[widget.index]= ! widget.d[widget.index];
            });
          },
        ),
      ),
    );
  }
}
