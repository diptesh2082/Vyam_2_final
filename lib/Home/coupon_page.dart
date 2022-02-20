import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/api/api.dart';
// import 'package:vyambooking/List/list.dart';

class CouponDetails extends StatefulWidget {
  CouponDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<CouponDetails> createState() => _CouponDetailsState();
}

class _CouponDetailsState extends State<CouponDetails> {
  List couponList = [];

  CouponApi couponApi = CouponApi();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: HexColor("3A3A3A"),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Coupons",
          style: GoogleFonts.poppins(
              color: HexColor("3A3A3A"),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
            color: Colors.transparent,
            child: const CupertinoTextField(
              placeholder: "Enter coupon code",
              padding: EdgeInsets.all(15),
              suffix: Text(
                "Apply",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          FutureBuilder(
              future: couponApi.getCouponData(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  couponList = snapshot.data as List;
                  print(couponList.length);

                  if (couponList.isEmpty) {
                    return Center(
                      child: Image.asset(
                        "assets/Illustrations/notification empty.png",
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SizedBox(
                        height: _height * 0.7,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: couponList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      elevation: 8,
                                      color: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: _width * 0.9,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 22.0,
                                                  left: 18,
                                                  bottom: 22),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            couponList[index]
                                                                    ['title']
                                                                .toUpperCase(),
                                                            style: GoogleFonts.poppins(
                                                                color: HexColor(
                                                                    "3A3A3A"),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            couponList[index]
                                                                    ['detail']
                                                                .toUpperCase(),
                                                            style: GoogleFonts.poppins(
                                                                color: HexColor(
                                                                    "3A3A3A"),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Code : " +
                                                                    couponList[index]
                                                                            [
                                                                            'code']
                                                                        .toUpperCase(),
                                                                style: GoogleFonts.poppins(
                                                                    color: HexColor(
                                                                        "3A3A3A"),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200),
                                                              ),
                                                              const SizedBox(
                                                                width: 490,
                                                              ),
                                                              const Text(
                                                                "Apply",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  );
                }
                return Center(
                  child: Image.asset(
                    "assets/Illustrations/notification empty.png",
                  ),
                );
              }),
        ],
      ),
    );
  }
}
