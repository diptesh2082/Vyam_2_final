import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/global_snackbar.dart';
import 'package:vyam_2_final/payment/payment.dart';
// import 'package:vyambooking/List/list.dart';

bool GlobalCouponApplied=false;
var GlobalCoupon;
String CouponDetailsMap="0";
class CouponDetails extends StatefulWidget {
  CouponDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<CouponDetails> createState() => _CouponDetailsState();
}

class _CouponDetailsState extends State<CouponDetails> {
  // List couponList = [];
  var getData=Get.arguments;
  var coupon;
  bool coupon_applied=false;
  Map coupon_list={};

  CouponApi couponApi = CouponApi();
  _couponpopup(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        content: SizedBox(
          height: 180,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "VYAM30 Applied",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                Text(
                  "You save 50.00",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
              ]),
        ),
      ));

  @override
  void initState() {
    coupon_list.clear();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width*.96,
              child: Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                color: Colors.transparent,
                child:  CupertinoTextField(
                  autofocus: false,
                  onChanged: (value){
                    coupon=value.trim().toLowerCase();
                   // print(coupon);
                  },

                  placeholder: "Enter coupon code",
                  // padding: EdgeInsets.all(15),
                  suffix: Row(
                    children: [
                      GestureDetector(
                        onTap: ()async{

                          if(coupon_list.containsKey(coupon)){
                            coupon_applied=true;
                            GlobalCoupon=coupon;
                            setState(() {
                              CouponDetailsMap=coupon_list[coupon];
                              GlobalCouponApplied=true;
                            });

                              Get.back();
                            // Get.off(()=>const PaymentScreen(),arguments: getData);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16))),
                                content: SizedBox(
                                  height: 180,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "VYAM30 Applied",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          "You save 50.00",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ]),
                                ),
                              ),
                            );


                          }else{
                            coupon_applied=false;
                            GlobalCouponApplied=false;
                            GlobalCoupon=null;
                            CouponDetailsMap="0";
                          }

                          if (coupon_applied==true){
                            setState(() {
                              total_discount=int.parse(coupon_list[coupon]);
                            });


                            // Get.off(()=>const PaymentScreen(),arguments: getData);
                            FocusScope.of(context).unfocus();
                            Get.snackbar("coupon applyed", "congratulations",backgroundColor: Colors.grey[200],snackPosition: SnackPosition.BOTTOM);
                            // const GetSnackBar(title: "wrong coupon",message: "kindely put diffrent one",);

                          }else{
                            Get.snackbar( "wrong coupon","kindely put diffrent one",backgroundColor: Colors.grey[200],snackPosition: SnackPosition.BOTTOM);
                            // const GetSnackBar(title: "wrong coupon",message: "kindely put diffrent one",);
                            total_discount=0;
                          }
                          // print(coupon_applied);
                          // print(total_discount);
                        },
                        child: const Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('coupon').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                    var documents = snapshot.data.docs;
                    print(documents);


                    if (documents.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Image.asset(
                              "assets/Illustrations/notification empty.png",
                            ),
                          ],
                        ),
                      );
                    }
                  coupon_list={};
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          height: _height * 0.7,
                          width: _width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: documents.length,
                              itemBuilder: (context, index) {

                                coupon_list.addAll(
                                    {
                                      documents[index]["code"].toString().toLowerCase(): documents[index]["discount"]
                                });
                                print(coupon_list);
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
                                                              documents[index]
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
                                                              documents[index]
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
                                                                      documents[index]
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
                                                                // const Spacer(),
                                                                const SizedBox(
                                                                  // width: MediaQuery.of(context).size.width*.2,
                                                                ),
                                                                // const Text(
                                                                //   "Apply",
                                                                //   style:
                                                                //       TextStyle(
                                                                //     color: Colors
                                                                //         .red,
                                                                //   ),
                                                                //   textAlign:
                                                                //       TextAlign
                                                                //           .end,
                                                                // )
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

                  return Center(
                    child: Image.asset(
                      "assets/Illustrations/notification empty.png",
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
