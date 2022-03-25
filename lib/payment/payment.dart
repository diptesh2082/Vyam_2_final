import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vyam_2_final/Home/bookings/success_book.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/payment/custom_api.dart';

import '../api/api.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var getData = Get.arguments;

  int discount =total_discount;
  int gstTax = 18;
  // ignore: prefer_typing_uninitialized_variables
  var grandTotal;
  // ignore: prefer_typing_uninitialized_variables
  var totalDiscount;
  // ignore: prefer_typing_uninitialized_variables
  var taxPay;
  String amount = '';


  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {

    print(getData);

    // print(GlobalUserData);


    setState((){
      var price = getData["totalPrice"];
      setState(() {
        discount=total_discount;
      });
      print(discount);

      totalDiscount = ((price * discount) / 100).round();
      taxPay = ((price * gstTax) / 100).round();
      grandTotal = ((price - totalDiscount) + taxPay);
      amount = grandTotal.toString() + "00";
      FirebaseFirestore.instance.collection("bookings")
          .doc(number)
          .collection("user_booking")
          .doc(Get.arguments["booking_id"])
          .update({
            "total_price":price,
       // "total_discount":totalDiscount,
        "discount":totalDiscount,
       "grand_total":grandTotal,
       "tax_pay":taxPay,

      })
      ;
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
      'amount': amount,
      'name': 'Vyam Gym Booking',
      'description': 'Payment',

      'prefill': {'contact': number.toString(), 'email': ''},

      'prefill': {'contact': number.toString(), 'email': GlobalUserData["email"].toString()},

      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var x =Random().nextInt(999999);
    FocusScope.of(context).unfocus();
      Get.off(()=>SuccessBook(),
        arguments: {
        "otp_pass":x
        }
      );

      // print(x);
       FirebaseFirestore.instance.collection("bookings")
      .doc(number)
      .collection("user_booking")
      .doc(getData["booking_id"])
      .update(
         {
           "otp_pass": x.toString(),
           "booking_status": "upcoming",
           "payment_done": true,
         }
       );
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    // ignore: avoid_print
    print("Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // ignore: avoid_print
    print("Wallet");
  }


  @override
  Widget build(BuildContext context) {
    // // var value = Get.arguments;
    // print(value);
    // if (total_discount>0){
    //     initState();
    // }

    return Scaffold(
        appBar: CustomAppBar(
          backgroundColor: Colors.black87,
          title: "Your Order",
        ),
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.white,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
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
                                getData["gym_details"]['display_picture']
                              ),
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
                              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10,bottom: 12),
                              child: SizedBox(
                                height: 114,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding:
                                          EdgeInsets.only(left: 10),
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
                                          padding: const EdgeInsets.only(
                                              right: 15),
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
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 3),
                                          child: Text(
                                            getData['totalMonths']??"",
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
                        onTap: () => Get.to(() => CouponDetails(),arguments: getData),
                        child: Card(
                          child: SizedBox(
                            height: 57,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 3,bottom: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text(
                                        "No promo code selected",
                                        style: GoogleFonts.poppins(
                                          // fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey
                                        ),
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
                          padding: const EdgeInsets.only(left: 12.0,right: 12,top: 10,bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                             const EdgeInsets.only(left: 10,top: 3 ),
                                child:  Text(
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
                                    padding: const EdgeInsets.only(left: 12,top: 3 ),
                                    child: Text(
                                      "Total Amount",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12,top: 3 ),
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
                                    padding: const EdgeInsets.only(left: 12,top: 3 ),
                                    child: Text(
                                      "Discount",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12,top: 3 ),
                                    child: Text(
                                      "₹" + totalDiscount.toString(),
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
                                    padding: const EdgeInsets.only(left: 12,top: 3 ),
                                    child: Text(
                                      "GST",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12,top: 3 ),
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
                                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3),
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
                                      "₹" + grandTotal.toString(),
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
                                      fontWeight: FontWeight.w500
                                  ),
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
                                      fontWeight: FontWeight.w500
                                  ),
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
                                    fontWeight: FontWeight.w500
                                ),
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
                        "₹" + grandTotal.toString() + "/-",
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
                    width: MediaQuery.of(context).size.width*.4,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      elevation: 8,
                      splashColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _payment();
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
}

class DetailBox extends StatelessWidget {
  final getGymName;
  final getLocation;
  final getLandmark;
  final image;
  const DetailBox(this.getGymName, this.getLandmark, this.getLocation,this.image,
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
              child: Container(
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
                ),
              ))
        ],
      ),
    );
  }
}