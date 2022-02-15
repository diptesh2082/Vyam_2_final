import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/controllers/packages/bookingDetails.dart';
import 'package:vyam_2_final/global_snackbar.dart';
import '';
import '../package_controller.dart';

class ZumbaList extends StatefulWidget {
  final getDocId;
  final gymName;
  ZumbaList({
    Key? key,
    required double width,
    required this.getDocId,
    required this.gymName,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  State<ZumbaList> createState() => _ZumbaListState();
}

class _ZumbaListState extends State<ZumbaList> {
  GlobalSnacbar globalSnacbar = GlobalSnacbar();
  BookingDetails bookingDetails = BookingDetails();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text("Zumba",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: HexColor("3A3A3A"),
                  fontWeight: FontWeight.w600)),
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("product_details")
                  .doc(widget.getDocId)
                  .collection("package")
                  .doc("normal_package")
                  .collection("zumba")
                  .snapshots(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  globalSnacbar.showError(
                      "Something went wrong", "Please try again");
                }
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  print(data.size);
                  if (data.size == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Coming Soon !! ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: widget._width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        data.docs[snapshot]['title']
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: HexColor("3A3A3A"),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                padding: const EdgeInsets.only(
                                                    top: 2.0,
                                                    bottom: 2.0,
                                                    left: 5,
                                                    right: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: HexColor(
                                                            "49C000"))),
                                                child: Text(
                                                  data.docs[snapshot]
                                                          ['discount'] +
                                                      "% off",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 9,
                                                      color:
                                                          HexColor("49C000")),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Rs "
                                                    "${int.parse(data.docs[snapshot]['original_price'])}",
                                                    style: GoogleFonts.poppins(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 15,
                                                        color:
                                                            HexColor("BFB9B9"),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    "Rs "
                                                    "${int.parse(data.docs[snapshot]["original_price"]) - (int.parse(data.docs[snapshot]["original_price"]) * int.parse(data.docs[snapshot]["discount"]) / 100).round()}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color:
                                                            HexColor("3A3A3A"),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Inc. of all taxes",
                                            style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                color: HexColor("B2B2B2"),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/zumbaCartoon.png",
                                        height: 70,
                                        color: Colors.yellow.shade600,
                                      ),
                                      const Spacer(),
                                      RaisedButton(
                                        elevation: 0,
                                        onPressed: () {
                                          print(widget.gymName);
                                          bookingDetails.bookingDetails(
                                              context,
                                              snapshot,
                                              data.docs,
                                              "Zumba ",
                                              widget.gymName);
                                        },
                                        color: HexColor("292F3D"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text("Buy now",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: HexColor("FFFFFF"),
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Coming Soon !! ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
