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

class CouponDetails extends StatefulWidget {
  final cartValue;
  final String type;
  CouponDetails({
    Key? key,required this.cartValue,required this.type,
  }) : super(key: key);

  @override
  State<CouponDetails> createState() => _CouponDetailsState();
}

class _CouponDetailsState extends State<CouponDetails> {
  // List couponList = [];
  var getData = Get.arguments;
  var coupon;
  bool coupon_applied = false;


  FocusNode myNode=FocusNode();
  var couponDoc;


  CouponApi couponApi = CouponApi();
  TextEditingController couponController = TextEditingController();
  couponClass myCouponController = Get.put(couponClass());

  @override
  void initState() {
    coupon_list.clear();
    print( widget.type.toLowerCase());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // myCouponController.dispose();
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (coupon_applied == true)
          // coupon_applied = true;
          setState(() {
            GlobalCoupon = coupon;
            CouponDetailsMap = coupon_list[coupon];
            GlobalCouponApplied = true;
          });
        print(GlobalCoupon);
        print(CouponDetailsMap);
        return true;
      },
      child: Scaffold(
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
                width: MediaQuery.of(context).size.width * .96,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  color: Colors.transparent,
                  child: CupertinoTextField(
                    autofocus: false,
                    controller: couponController,
                    focusNode: myNode,
                    // onChanged: (value){
                    //   coupon=value.trim().toLowerCase();
                    //  // print(coupon);
                    // },

                    placeholder: "Enter coupon code",
                    // padding: EdgeInsets.all(15),
                    suffix: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            coupon = await couponController.text
                                .trim()
                                .toLowerCase();
                            print(coupon);

                            if (coupon_list.containsKey(coupon)) {
                              coupon_applied = true;
                              GlobalCoupon = coupon;
                              setState(() {
                                CouponDetailsMap = coupon_list[coupon];
                                GlobalCouponApplied = true;
                              });

                              Get.back();
                              // Get.off(()=>const PaymentScreen(),arguments: getData);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  content: SizedBox(
                                    height: 160,
                                    width: 160,
                                    child: FittedBox(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/icons8-approval.gif",
                                              height: 70,
                                              width: 70,
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            Text(
                                              "$coupon Applied",
                                              style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "You save ${coupon_list[coupon]}",
                                              style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              coupon_applied = false;
                              GlobalCouponApplied = false;
                              GlobalCoupon = null;
                              CouponDetailsMap = "0";
                            }

                            if (coupon_applied == true) {
                              setState(() {
                                // total_discount=int.parse(coupon_list[coupon]);
                              });

                              // Get.off(()=>const PaymentScreen(),arguments: getData);
                              FocusScope.of(context).unfocus();
                              // Get.snackbar("coupon applyed", "congratulations",backgroundColor: Colors.grey[200],snackPosition: SnackPosition.BOTTOM);
                              // const GetSnackBar(title: "wrong coupon",message: "kindely put diffrent one",);

                            } else {
                              Get.snackbar(
                                  "wrong coupon", "kindely put diffrent one",
                                  backgroundColor: Colors.grey[200],
                                  snackPosition: SnackPosition.BOTTOM);
                              // const GetSnackBar(title: "wrong coupon",message: "kindely put diffrent one",);
                              total_discount = 0;
                            }
                            // print(coupon_applied);
                            // print(total_discount);
                          },
                          child: Text(
                            "Apply",
                            style: GoogleFonts.poppins(
                                color: HexColor("EB5757"),
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
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
                  stream: FirebaseFirestore.instance
                      .collection('coupon')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

// <<<<<<< thed
//                     var documents = snapshot.data.docs;
//                     print(documents);
//                     var list = [];
//                     // list.addAll({documents[0]["code"].toString().toLowerCase(): documents[index]["discount"]);
//                     print(list);

//                     if (documents.isEmpty) {
//                       return Center(
//                         child: Column(
//                           children: [
//                             const SizedBox(
//                               height: 60,
//                             ),
//                             Image.asset(
//                               "assets/Illustrations/notification empty.png",
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     coupon_list = {};
//                     return SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 30.0),
//                         child: SizedBox(
//                           height: _height * 0.7,
//                           width: _width,
//                           child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: documents.length,
//                               itemBuilder: (context, index) {
//                                 coupon_list.addAll({
//                                   documents[index]["code"]
//                                           .toString()
//                                           .toLowerCase():
//                                       documents[index]["discount"]
//                                 });
//                                 print(coupon_list);
//                                 return SafeArea(
//                                   child: Stack(
//                                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                                     alignment: Alignment.centerLeft,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: GestureDetector(
//                                           onTap: () async {
//                                             if (mounted) {
//                                               setState(() {
//                                                 couponController.text =
//                                                     documents[index]["code"]
//                                                         .toString();
// =======
                      var documents = snapshot.data.docs;
                    if (widget.type.toString().toLowerCase()=="pay per session"){
                      documents = documents.where((element){
                        return element.
                        get('package_type')
                            .toString()
                            .toLowerCase()
                            .contains(widget.type.toString().toLowerCase());
                      }).toList();
                    }else{
                      documents = documents.where((element){
                        return element
                            .get('package_type')
                            .toString()
                            .toLowerCase()
                            .contains("package");
                      }).toList();
                    }

                      couponDoc=snapshot.data.docs;
                      print(couponDoc);
                      var list=[];
                      // list.addAll({documents[0]["code"].toString().toLowerCase(): documents[index]["discount"]);
                      print(list);


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
                                  return SafeArea(
                                    child: Stack(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: ()async{
                                              if(mounted) {
                                                setState(() {
                                                couponController.text=  documents[index]["code"].toString();
// >>>>>>> master
                                                myNode.requestFocus();
                                              });
                                            }

                                            // print(coupon_applied);
                                            // print(total_discount);
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: Container(
                                              height: 140,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //     top: 41,
                                      //     child: CircleAvatar(
                                      //       radius: 20,
                                      //       backgroundColor: Colors.grey.shade100,
                                      //     )),
                                      Positioned(
                                        left: 12,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(9),
                                              bottomLeft: Radius.circular(9)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.yellowAccent,
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  Color(0xffFF8008),
                                                  Color(0xffFFC837)
                                                ])
                                                // borderRadius: BorderRadius.only(topLeft:,bottomLeft: 5)
                                                ),
                                            height: 140,
                                            width: 31,
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Center(
                                                child: Text(
                                                  "${documents[index]["tag"]}"
                                                      .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                  // textDirection: TextDirection(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                            ),
                                        if(widget.cartValue <= int.parse(documents[index]["minimum_cart_value"]))
                                          Positioned(
                                            left:12,
                                            child: ClipRRect(
                                              borderRadius:BorderRadius.only(topLeft: Radius.circular(9),bottomLeft: Radius.circular(9)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellowAccent,
                                                    gradient: LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors: [
                                                          Color(0xff656669),
                                                          Color(0xff323133)
                                                        ])
                                                  // borderRadius: BorderRadius.only(topLeft:,bottomLeft: 5)
                                                ),

                                                height: 140,
                                                width: 31,
                                                child: RotatedBox(

                                                  quarterTurns: -1,
                                                  child: Center(
                                                    child: Text(
                                                      "${documents[index]["tag"]}".toUpperCase(),
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14
                                                      ),
                                                      // textDirection: TextDirection(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Positioned(
                                          left: 50,
                                          top:20,
                                          child: FittedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      documents[index]['code']
                                                          .toUpperCase(),
                                                      style: GoogleFonts.poppins(
                                                          color: HexColor("3A3A3A"),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    if(widget.cartValue <= int.parse(documents[index]["minimum_cart_value"]))
                                                    Text(
                                                      "Not Applicable",
                                                      style: GoogleFonts.poppins(
                                                          color:Colors.red,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500,

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  documents[index]['detail']
                                                      .toUpperCase()??"",
                                                  style: GoogleFonts.poppins(
                                                      color: HexColor("3A3A3A"),
// >>>>>>> master
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  maxLines: 2,
                                                ),
                                ]
                                              ),
    )
    )
                                            ],
                                          ),
                                        ),
// <<<<<<< thed
//                                       ),
//                                       // Positioned(
//                                       //   top: 12,
//                                       //   left: _width*.5,
//                                       //   child: const DottedLine(
//                                       //     direction: Axis.vertical,
//                                       //     lineLength: 100,
//                                       //     dashGapLength: 8,
//                                       //     lineThickness: 1.5,
//                                       //     dashColor: Colors.amber,
//                                       //   ),
//                                       // ),
//                                       Positioned(
//                                         top: 10,
//                                         right: 8,
//                                         child: TextButton(
//                                           onPressed: () async {
//                                             coupon = documents[index]['code']
//                                                 .trim()
//                                                 .toLowerCase();
//                                             print("////////////" + coupon);

//                                             if (coupon_list.containsKey(
//                                                 documents[index]['code']
//                                                     .trim()
//                                                     .toLowerCase())) {
//                                               coupon_applied = true;
//                                               myCouponController
//                                                   .GlobalCouponApplied
//                                                   .value = true;
//                                               myCouponController
//                                                   .GlobalCoupon.value = coupon;
//                                               myCouponController
//                                                   .CouponDetailsMap
//                                                   .value = coupon_list[coupon];
//                                               setState(() {
//                                                 GlobalCoupon =
//                                                     documents[index]['code'];
//                                                 CouponDetailsMap =
//                                                     documents[index]
//                                                         ['discount'];
//                                                 GlobalCouponApplied = true;
//                                               });
//                                               print(GlobalCoupon);
//                                               print(GlobalCouponApplied);
//                                               print(CouponDetailsMap);
//                                               Get.back();
//                                               // Navigator.of(context).pop([GlobalCoupon,CouponDetailsMap,GlobalCouponApplied]);
//                                               // Get.off(()=>const PaymentScreen(),arguments: getData);
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (context) =>
//                                                     AlertDialog(
//                                                   shape:
//                                                       const RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           16))),
//                                                   content: SizedBox(
//                                                     height: 160,
//                                                     width: 160,
//                                                     child: FittedBox(
//                                                       child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Image.asset(
//                                                               "assets/icons/icons8-approval.gif",
//                                                               height: 70,
//                                                               width: 70,
//                                                             ),
//                                                             const SizedBox(
//                                                               height: 9,
//                                                             ),
//                                                             Text(
//                                                               "$coupon Applied",
//                                                               style: const TextStyle(
//                                                                   fontFamily:
//                                                                       "Poppins",
//                                                                   fontSize: 14,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600),
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 6),
//                                                             Text(
//                                                               "You save ${coupon_list[coupon]}",
//                                                               style: const TextStyle(
//                                                                   fontFamily:
//                                                                       "Poppins",
//                                                                   fontSize: 16,
//                                                                   color: Colors
//                                                                       .green,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600),
//                                                             ),
//                                                           ]),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             }
// =======
                                        // Positioned(
                                        //   top: 12,
                                        //   left: _width*.5,
                                        //   child: const DottedLine(
                                        //     direction: Axis.vertical,
                                        //     lineLength: 100,
                                        //     dashGapLength: 8,
                                        //     lineThickness: 1.5,
                                        //     dashColor: Colors.amber,
                                        //   ),
                                        // ),
                                        Positioned(
                                          top: 10,
                                          right: 8,
                                          child: TextButton(
                                            onPressed: () async{

                                              coupon =  documents[index]['code']
                                                  .trim().toLowerCase();
                                              print("////////////"+coupon);
                                              print("////////////"+documents[index]['offer_type'].toString());
                                              print("////////////"+documents[index]['minimum_cart_value']);
                                              print("////////////"+documents[index]['max_dis']);
                                              print("////////////"+documents[index]['discount']);
                                              print("////////////"+documents[index]['offer_type'].toString());

                                              if (coupon_list.containsKey(documents[index]['code']
                                                  .trim().toLowerCase()) && widget.cartValue>=int.parse(documents[index]['minimum_cart_value'])) {
                                                if(documents[index]['offer_type']==true && widget.cartValue >= int.parse(documents[index]["minimum_cart_value"])){
                                                  coupon_applied = true;
                                                  myCouponController.GlobalCouponApplied.value=true;
                                                  myCouponController.GlobalCoupon.value=coupon;
                                                  int dex=(widget.cartValue * (int.parse(documents[index]['discount'].toString())/100)).toInt();
                                                  print(dex);
                                                  if(dex >= int.parse(documents[index]['max_dis'].toString())){
                                                    myCouponController.CouponDetailsMap.value= documents[index]['max_dis'];
                                                  }if(dex < int.parse(documents[index]['max_dis'].toString())){
                                                    myCouponController.CouponDetailsMap.value= dex.toString();
                                                  }

                                                  setState(() {
                                                    GlobalCoupon =  documents[index]['code'];
                                                    CouponDetailsMap =  documents[index]['discount'];
                                                    GlobalCouponApplied = true;
                                                  });
                                                  print(GlobalCoupon);
                                                  print(GlobalCouponApplied);
                                                  print(CouponDetailsMap);
                                                  Get.back();
                                                  // Navigator.of(context).pop([GlobalCoupon,CouponDetailsMap,GlobalCouponApplied]);
                                                  // Get.off(()=>const PaymentScreen(),arguments: getData);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.all(Radius.circular(16))),
                                                      content: SizedBox(
                                                        height: 160,
                                                        width: 160,
                                                        child: FittedBox(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/icons/icons8-approval.gif",
                                                                  height: 70,
                                                                  width: 70,
                                                                ),
                                                                const SizedBox(
                                                                  height: 9,
                                                                ),
                                                                Text(
                                                                  "$coupon Applied",
                                                                  style: const TextStyle(
                                                                      fontFamily: "Poppins",
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                                const SizedBox(height: 6),
                                                                Text(
                                                                  "You save ${coupon_list[coupon]}",
                                                                  style: const TextStyle(
                                                                      fontFamily: "Poppins",
                                                                      fontSize: 16,
                                                                      color: Colors.green,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                if(documents[index]['offer_type']==false && widget.cartValue >= int.parse(documents[index]["minimum_cart_value"])){
                                                  coupon_applied = true;
                                                  myCouponController.GlobalCouponApplied.value=true;
                                                  myCouponController.GlobalCoupon.value=coupon;
                                                  int dex=int.parse(documents[index]['discount'].toString());
                                                  print(dex);
                                                  // if(dex >= int.parse(documents[index]['max_dis'].toString())){
                                                  //   myCouponController.CouponDetailsMap.value= documents[index]['max_dis'];
                                                  // }if(dex < int.parse(documents[index]['max_dis'].toString())){
                                                    myCouponController.CouponDetailsMap.value= dex.toString();
                                                  // }

                                                  setState(() {
                                                    GlobalCoupon =  documents[index]['code'];
                                                    CouponDetailsMap =  documents[index]['discount'];
                                                    GlobalCouponApplied = true;
                                                  });
                                                  print(GlobalCoupon);
                                                  print(GlobalCouponApplied);
                                                  print(CouponDetailsMap);
                                                  Get.back();
                                                  // Navigator.of(context).pop([GlobalCoupon,CouponDetailsMap,GlobalCouponApplied]);
                                                  // Get.off(()=>const PaymentScreen(),arguments: getData);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.all(Radius.circular(16))),
                                                      content: SizedBox(
                                                        height: 160,
                                                        width: 160,
                                                        child: FittedBox(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/icons/icons8-approval.gif",
                                                                  height: 70,
                                                                  width: 70,
                                                                ),
                                                                const SizedBox(
                                                                  height: 9,
                                                                ),
                                                                Text(
                                                                  "$coupon Applied",
                                                                  style: const TextStyle(
                                                                      fontFamily: "Poppins",
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                                const SizedBox(height: 6),
                                                                Text(
                                                                  "You save ${coupon_list[coupon]}",
                                                                  style: const TextStyle(
                                                                      fontFamily: "Poppins",
                                                                      fontSize: 16,
                                                                      color: Colors.green,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                // coupon_applied = true;
                                                // myCouponController.GlobalCouponApplied.value=true;
                                                // myCouponController.GlobalCoupon.value=coupon;
                                                // myCouponController.CouponDetailsMap.value= coupon_list[coupon];
                                                // setState(() {
                                                //   GlobalCoupon =  documents[index]['code'];
                                                //   CouponDetailsMap =  documents[index]['discount'];
                                                //   GlobalCouponApplied = true;
                                                // });
                                                // print(GlobalCoupon);
                                                // print(GlobalCouponApplied);
                                                // print(CouponDetailsMap);
                                                //   Get.back();
                                                // // Navigator.of(context).pop([GlobalCoupon,CouponDetailsMap,GlobalCouponApplied]);
                                                // // Get.off(()=>const PaymentScreen(),arguments: getData);
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (context) => AlertDialog(
                                                //     shape: const RoundedRectangleBorder(
                                                //         borderRadius:
                                                //         BorderRadius.all(Radius.circular(16))),
                                                //     content: SizedBox(
                                                //       height: 160,
                                                //       width: 160,
                                                //       child: FittedBox(
                                                //         child: Column(
                                                //             crossAxisAlignment:
                                                //             CrossAxisAlignment.center,
                                                //             mainAxisAlignment:
                                                //             MainAxisAlignment.center,
                                                //             children: [
                                                //               Image.asset(
                                                //                 "assets/icons/icons8-approval.gif",
                                                //                 height: 70,
                                                //                 width: 70,
                                                //               ),
                                                //               const SizedBox(
                                                //                 height: 9,
                                                //               ),
                                                //               Text(
                                                //                 "$coupon Applied",
                                                //                 style: const TextStyle(
                                                //                     fontFamily: "Poppins",
                                                //                     fontSize: 14,
                                                //                     fontWeight: FontWeight.w600),
                                                //               ),
                                                //               const SizedBox(height: 6),
                                                //               Text(
                                                //                 "You save ${coupon_list[coupon]}",
                                                //                 style: const TextStyle(
                                                //                     fontFamily: "Poppins",
                                                //                     fontSize: 16,
                                                //                     color: Colors.green,
                                                //                     fontWeight: FontWeight.w600),
                                                //               ),
                                                //             ]),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // );
                                              }

                                              if (coupon_applied == true) {
                                                setState(() {
                                                  // total_discount=int.parse(coupon_list[coupon]);
                                                });
// >>>>>>> master

                                            if (coupon_applied == true) {
                                              setState(() {
                                                // total_discount=int.parse(coupon_list[coupon]);
                                              });

                                              // Get.off(()=>const PaymentScreen(),arguments: getData);
                                              FocusScope.of(context).unfocus();
                                              // Get.snackbar("coupon applyed", "congratulations",backgroundColor: Colors.grey[200],snackPosition: SnackPosition.BOTTOM);
                                              // const GetSnackBar(title: "wrong coupon",message: "kindely put diffrent one",);

                                            } else {
                                              Get.snackbar("wrong coupon",
                                                  "kindely put diffrent one",
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                              // const GetSnackBar(title: "wrong coupon",message: "kindely put diffrent one",);
                                              total_discount = 0;
                                            }
                                          },
                                          child: Text(
                                            "Apply",
                                            style: GoogleFonts.poppins(
                                                color: HexColor("EB5757"),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
// <<<<<<< thed
//                                       ),
//                                       // Positioned(
//                                       //     top: 41,
//                                       //     right: 0,
//                                       //     child: CircleAvatar(
//                                       //       radius: 20,
//                                       //       backgroundColor: Colors.grey.shade100,
//                                       //     ))
//                                     ],
//                                   ),
//                                 );
//                               }),
// =======
                                        if( widget.cartValue<=int.parse(documents[index]['minimum_cart_value']))
                                        Positioned(

                                            child: Container(
                                              height: 144,
                                              width: _width,
                                              color: Colors.grey.withOpacity(.01),
                                            ),
                                        top: 10,
                                        left: 0,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
// >>>>>>> master
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
      ),
    );
  }
}
