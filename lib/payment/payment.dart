import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:vyam_2_final/Home/bookings/success_book.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import 'package:vyam_2_final/payment/custom_api.dart';

import '../api/api.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var getData = Get.arguments;
  late PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int discount = total_discount;
  int gstTax = 18;
  // ignore: prefer_typing_uninitialized_variables
  var grandTotal;
  // ignore: prefer_typing_uninitialized_variables
  var totalDiscount;
  // ignore: prefer_typing_uninitialized_variables
  var taxPay;
  String amount = '';
  String booking_id = Get.arguments["booking_id"];
  final app_bar_controller = ScrollController();
  _couponpopup(context) => showDialog(
      context: context,
      builder: (context) => GestureDetector(
        onTap: (){
          Get.off(()=>const PaymentScreen(),arguments: getData);
        },
        child: AlertDialog(
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
      ));
  // getAnimation(){
  //   controller = AnimationController(
  //       vsync: this, value: 0.1, duration: const Duration(milliseconds: 1000));
  //   _concontroller = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 400));
  //
  //   scaleAnimation =
  //   CurvedAnimation(parent: controller, curve: Curves.easeInOutBack)
  //     ..addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {
  //         setState(() {
  //           Timer(const Duration(milliseconds: 150),
  //                   () => _concontroller.forward());
  //         });
  //       }
  //     });
  // }
  //

  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // print("${GlobalCouponApplied}");
    // GlobalCouponApplied?_couponpopup(context):const SizedBox();

    // print(GlobalUserData);
    GlobalCouponApplied=false;
    print(booking_id);

    setState(() {
      var price = getData["totalPrice"];
      setState(() {
        discount = total_discount;
      });
      print(discount);

      totalDiscount = ((price * discount) / 100).round();
      taxPay = ((price * gstTax) / 100).round();
      grandTotal = ((price - totalDiscount) + taxPay);
      amount = grandTotal.toString() + "00";
      FirebaseFirestore.instance
          .collection("bookings")
          .doc(number)
          .collection("user_booking")
          .doc(Get.arguments["booking_id"])
          .update({
        "total_price": price,
        // "total_discount":totalDiscount,
        "discount": totalDiscount,
        "grand_total": grandTotal,
        "tax_pay": taxPay,
      });
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  _payment() {
    var options = {
      'key': 'rzp_test_33NhqFvjcCXYkk',
      'amount': (GlobalCouponApplied?(grandTotal-int.parse(CouponDetailsMap)):grandTotal)*100,
      'name': 'Vyam Gym Booking',
      'description': 'Payment',
      // "order_id":"test_jukjktgtu",

      // 'prefill': {'contact': number.toString(), 'email': ''},

      'prefill': {'contact': "7407926060".toString(), 'email': GlobalUserData["email"].toString()},


      // 'prefill': {
      //   'contact': number.toString(),
      //   'email': GlobalUserData["email"].toString()
      // },

      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // response.orderId!.isEmpty || response.signature!.isEmpty
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // print(response.signature);
    //   print(response.paymentId);
    //   print(response.orderId);

      print("this is the game${response.signature}");
      print("the  theory${response.paymentId}");
      print("the  theory${response.paymentId}");
      print(response.orderId);
      if (response.orderId!=null || response.signature !=null) {
        Get.back();
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
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Payment Failed',
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
            ),
          ),
        );
      }else{
        var x =  Random().nextInt(9999-1000);
        FocusScope.of(context).unfocus();
        Get.offAll(() => SuccessBook(), arguments: {"otp_pass": x});

        // print(x);
        FirebaseFirestore.instance
            .collection("bookings")
            .doc(number)
            .collection("user_booking")
            .doc(getData["booking_id"])
            .update({
          "otp_pass": x.toString(),
          "booking_status": "upcoming",
          "payment_done": true,
        });
      }


    // } catch (e) {
    //   print(e);
    // }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // ignore: avoid_print
    // print(PaymentFailureResponse);
    // Get.off(PaymentScreen());
    print(response.code);
    print(response.message);
    print("payment faild");
    // Get.to(PaymentScreen());


      // var signature;
    // // response.
    //   print(response.signature);
    //   print(response.paymentId);
    //   print(response.orderId);
    //   if (response.orderId == null || response.signature == null) {
    //     Navigator.pop(context);
    //     showDialog(
    //       context: context,
    //       builder: (context) => GestureDetector(
    //         onTap: () {
    //           Get.off(() => const PaymentScreen(), arguments: getData);
    //         },
    //         child: AlertDialog(
    //           shape: const RoundedRectangleBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(16))),
    //           content: SizedBox(
    //             height: 180,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: const [
    //                   Icon(
    //                     Icons.cancel,
    //                     color: Colors.red,
    //                     size: 50,
    //                   ),
    //                   SizedBox(height: 15),
    //                   Text(
    //                     'Payment Failed',
    //                     style: TextStyle(
    //                         fontFamily: "Poppins",
    //                         fontSize: 16,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w700),
    //                   ),
    //                 ]),
    //           ),
    //         ),
    //       ),
    //     );
    //     return;
    //   }

    print("Failed");
    print("//////////////////////////////////////////////////////////////");
    print("Failure Handleeerr");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // ignore: avoid_print
    // Get.to(()=>PaymentScreen());
    print("////////////////////////////////////////");
    print(response.walletName);
    print("////////////////////////////////////////");

    print("////////////////////////////////////////");

    if (response.walletName == null) {
      Get.back();
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
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 50,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Payment Failed',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ]),
          ),
        ),
      );
    }else{
      var x =  Random().nextInt(9999);
      FocusScope.of(context).unfocus();
      Get.offAll(() => SuccessBook(), arguments: {"otp_pass": x});

      // print(x);
      FirebaseFirestore.instance
          .collection("bookings")
          .doc(number)
          .collection("user_booking")
          .doc(getData["booking_id"])
          .update({
        "otp_pass": x.toString(),
        "booking_status": "upcoming",
        "payment_done": true,
      });
    }

    print("Wallet");
    print("//////////////////////////////////////////////////////////////");
    print("Failure Handleeerr");
  }

  @override
  Widget build(BuildContext context) {
    // // var value = Get.arguments;
    // print(value);
    // if (total_discount>0){
    //     initState();
    // }

    return Scaffold(
        appBar: ScrollAppBar(
          controller: app_bar_controller,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            // "Add Your Location Here",
            "Booking Summary",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.white,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                // controller: app_bar_controller,
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: DetailBox(
                                  getData['gymName'].toString(),
                                  getData['gym_details']["branch"].toString(),
                                  getData["gym_details"]['address'].toString(),
                                  getData["gym_details"]['display_picture']),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(
                              color: Colors.black26,
                              height: 10,
                              thickness: .3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 10, bottom: 12),
                              child: SizedBox(
                                height: 114,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Workout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                color: Colors.green),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Text(
                                            getData['packageType'],
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 3, left: 10),
                                          child: Center(
                                            child: Text(
                                              "Package",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 3),
                                          child: Text(
                                            getData['totalMonths'] ?? "",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                // color: ,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 12, top: 3),
                                          child: Text(
                                            "Start Date",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              // fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, top: 3),
                                          child: Text(
                                            getData["startDate"].toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 12, top: 3),
                                          child: Text(
                                            "Valid Upto",
                                            style: GoogleFonts.poppins(
                                              // fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, top: 5),
                                          child: Text(
                                            getData["endDate"].toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Get.to(() => CouponDetails(), arguments: getData),
                        child: Card(
                          child: SizedBox(
                            height: 57,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 3, bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Apply promo code",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/icons/discount.png",
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                      GlobalCouponApplied ? RichText(
                                          text: TextSpan(
                                                style: GoogleFonts.poppins(
                                                  // fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                            children:  <TextSpan>[
                                              const TextSpan(
                                                text: "Promo "
                                              ),
                                              TextSpan(
                                                  text: "${GlobalCoupon} ",
                                                style: GoogleFonts.poppins(
                                                  // fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    color: Colors.amber),
                                              ),
                                              const TextSpan(
                                                  text: "Applied"
                                              ),
                                            ]

                                          )):
                                       Text(
                                        "No promo code selected",
                                        style: GoogleFonts.poppins(
                                            // fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  const Icon(
                                    CupertinoIcons.forward,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12, top: 10, bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 3),
                                child: Text(
                                  "Payment",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                      color: Colors.green,
                                      // fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 12, top: 3),
                                    child: Text(
                                      "Total Amount",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 3),
                                    child: Text(
                                      "₹${getData["totalPrice"]}",
                                      style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 12, top: 3),
                                    child: Text(
                                      "Discount",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 3),
                                    child: Text(
                                      "₹  ${GlobalCouponApplied? CouponDetailsMap.toString() :totalDiscount.toString()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 12, top: 3),
                                    child: Text(
                                      "GST",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 3),
                                    child: Text(
                                      "₹" + taxPay.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Grand Total",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Poppins",
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "₹ ${GlobalCouponApplied?(grandTotal-int.parse(CouponDetailsMap)):grandTotal.toString()}",
                                      style: const TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.asset("assets/icons/best discounts.png",
                                    height: 25, width: 25),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Best Discount",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset("assets/icons/secured payments.png",
                                    height: 25, width: 25),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Secured Payment",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Image.asset("assets/icons/customer support.png",
                                    height: 25, width: 25),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "24/7 support",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "₹ ${GlobalCouponApplied?(grandTotal-int.parse(CouponDetailsMap)):grandTotal.toString()} /-",
                        style: const TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Inc all taxes",
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .4,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      elevation: 8,
                      splashColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _bottomsheet(context);
                        // _payment();
                        // Get.to(() => Packeges(
                        //   getFinalID: widget.getID,
                        //   gymName: widget.gymName,
                        //   gymLocation: widget.gymLocation,
                        // ));
                      },
                      label: Text(
                        "Pay",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _bottomsheet(BuildContext context) async {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    bool onlinePay = true;
    // _controller = await _scaffoldKey.currentState.showBottomSheet
    return showModalBottomSheet(
        // isDismissible: false,
        isScrollControlled: true,
        // enableDrag: false,
        context: context,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Builder(builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                // height: 5,
                // height: 600,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0, top: 8),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Payment methods",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              onlinePay = false;
                            });

                            _PaymentScreenState();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/bi_cash.png",
                                width: 60,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Cash",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const Spacer(),
                              onlinePay == false
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.black,
                                      size: 15,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 5,
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection("bookings")
                                .doc(number)
                                .collection("user_booking")
                                .doc(booking_id)
                                .update({
                              "discount": GlobalCouponApplied?(int.parse(CouponDetailsMap)):totalDiscount,
                              "grand_total":  GlobalCouponApplied?(grandTotal-int.parse(CouponDetailsMap)).toString():grandTotal.toString(),
                              "tax_pay": taxPay,
                            });
                            _payment();
                            setState(() {
                              GlobalCouponApplied=false;
                              onlinePay = true;
                            });
                            _PaymentScreenState();

                            print(onlinePay);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/UPI-logo.png",
                                width: 60,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Online",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const Spacer(),
                              onlinePay == true
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.black,
                                      size: 15,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 5,
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        // height: 155,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8, right: 8, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment",
                                    style: GoogleFonts.poppins(
                                        // fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.green),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total amount",
                                        style: GoogleFonts.poppins(
                                            // fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹${getData["totalPrice"]}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Discount",
                                        style: GoogleFonts.poppins(
                                            // fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹  ${GlobalCouponApplied? CouponDetailsMap.toString() :totalDiscount.toString()}",
                                        style: GoogleFonts.poppins(
                                            // fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Grand Total",
                                        style: GoogleFonts.poppins(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹${GlobalCouponApplied?(grandTotal-int.parse(CouponDetailsMap)):grandTotal.toString()}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FloatingActionButton.extended(
                            backgroundColor: const Color(0xff292F3D),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text(
                              'Pay  ₹${GlobalCouponApplied?(grandTotal-int.parse(CouponDetailsMap)):grandTotal.toString()} securely',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              print('hhhhhhhhhhhhhh');
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}

class DetailBox extends StatelessWidget {
  final getGymName;
  final getLocation;
  final getLandmark;
  final image;
  const DetailBox(
      this.getGymName, this.getLandmark, this.getLocation, this.image,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 105,
              width: size.width * .42,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    getGymName,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.location_solid,
                        size: 20,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        getLandmark.toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    getLocation,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}



// class myBottomSheet extends StatefulWidget {
//   const myBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   State<myBottomSheet> createState() => _myBottomSheetState();
// }
//
// class _myBottomSheetState extends State<myBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: showModalBottomSheet(
//           ),
//     );
//   }
// }

