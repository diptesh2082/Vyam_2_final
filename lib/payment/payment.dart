// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/payment/custom_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var getData = Get.arguments;
  int discount = 0;
  int gstTax = 18;
  var grandTotal;
  var totalDiscount;
  var taxPay;
  String amount = '';
  String promocode = "";
  String _selectedPromocode = "No promo code Selected";
  String buttonTitle = "Apply";
  Color _color = Colors.black;

  final Razorpay _razorpay = Razorpay();
  CouponApi couponApi = CouponApi();

  @override
  void initState() {
    couponApi.getCouponData();
    setState(() {
      var price = getData["totalPrice"];
      totalDiscount = ((price * discount) / 100).round();
      taxPay = ((price * gstTax) / 100).round();
      grandTotal = ((price - totalDiscount) + taxPay);
      amount = grandTotal.toString() + "00";
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

  getDiscountValues() {
    for (int i = 0; i < couponApi.couponList.length; i++) {
      if (couponApi.couponList[i]['code'].toLowerCase() ==
          promocode.toLowerCase()) {
        discount = int.parse(couponApi.couponList[i]['discount']);
        setState(() {
          _selectedPromocode = couponApi.couponList[i]['code'].toUpperCase();
          _color = Colors.green;
          buttonTitle = "Applied";
          var price = getData["totalPrice"];
          totalDiscount = ((price * discount) / 100).round();
          taxPay = ((price * gstTax) / 100).round();
          grandTotal = ((price - totalDiscount) + taxPay);
          amount = grandTotal.toString() + "00";
        });
      }
    }
  }

  TextEditingController textEditingController = TextEditingController();

  _payment() {
    var options = {
      'key': 'rzp_test_XsqSZDutXoetVT',
      'amount': amount,
      'name': 'Vyam Gym Booking',
      'description': 'Payment',
      'prefill': {'contact': '', 'email': ''},
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

  //After Successfull Payment
  void _handlePaymentSuccess(PaymentSuccessResponse response) {}
  //After Unsuccessfull Payment
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Wallet");
  }

  showDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 8,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextFormField(
                  controller: textEditingController,
                  onChanged: (((value) {
                    promocode = value;
                  })),
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Enter Promocode"),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(CouponDetails());
                        },
                        child: const Text("Available Coupons")),
                    const Spacer(),
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          getDiscountValues();
                        },
                        child: Text(
                          "Apply",
                          style: GoogleFonts.poppins(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // // var value = Get.arguments;
    // print(value);
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
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: DetailBox(
                              getData['gymName'], getData['address'])),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.yellow,
                        height: 10,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                    "Workout",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  child: Text(
                                    getData['packageType'].toUpperCase(),
                                    style: const TextStyle(
                                        // color: Colors.greenAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 15, top: 10, left: 10),
                                  child: Center(
                                    child: Text(
                                      "Package",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  child: Text(
                                    getData['totalMonths'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 5),
                                  child: Text(
                                    "Start Date",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 5),
                                  child: Text(
                                    getData["startDate"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 5),
                                  child: Text(
                                    "Valid Upto",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 5),
                                  child: Text(
                                    getData["endDate"],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: Colors.yellow,
                        height: 10,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Apply promo code",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        _selectedPromocode,
                                        style: const TextStyle(),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  child: Container(
                                    height: 38,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _color),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialogBox();
                                        },
                                        child: Text(
                                          buttonTitle,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Divider(
                              color: Colors.yellow,
                              height: 10,
                              thickness: 1,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 10, top: 2),
                              child: const Text(
                                "Payment",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 5),
                                  child: Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 5),
                                  child: Text(
                                    "${getData["totalPrice"]}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 5),
                                  child: Text(
                                    "Discount",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 5),
                                  child: Text(
                                    totalDiscount.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, top: 5),
                                  child: Text(
                                    "GST",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 5),
                                  child: Text(
                                    taxPay.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.yellow,
                        height: 10,
                        thickness: .5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12, top: 5),
                              child: Text(
                                "Grand Total",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12, top: 5),
                              child: Text(
                                grandTotal.toString(),
                                style: const TextStyle(
                                    // color: Colors.greenAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Colors.black12,
                        height: 12,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Icon(
                                  Icons.privacy_tip_sharp,
                                  // color: Colors.yellowAccent,
                                  size: 50.0,
                                ),
                                Text(
                                  "Secured Payment",
                                  style: TextStyle(),
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.airline_seat_flat_sharp,
                                  // color: Colors.yellowAccent,
                                  size: 50.0,
                                ),
                                Text(
                                  "Best Discount",
                                  style: TextStyle(),
                                )
                              ],
                            ),
                            Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.settings,
                                  // color: Colors.yellowAccent,
                                  size: 50.0,
                                ),
                                const Text(
                                  "Customer support",
                                  style: TextStyle(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        // onTap: () => Get.to(OrderScreen()),
                        child: SizedBox(
                          width: 195,
                          child: FlatButton(
                            onPressed: () {
                              print("pay");
                              _payment();
                              // Get.to(() => OrderScreen());
                            },
                            height: 54,
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),

                            // width: 150,
                            // alignment: Alignment.center,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(15),
                            //   gradient: LinearGradient(
                            //     colors: [
                            //       Colors.yellow,
                            //       Colors.yellowAccent
                            //     ]
                            //   ),
                            // ),
                            child: const Text(
                              "Pay",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}

class DetailBox extends StatelessWidget {
  final getGymName;
  final getLocation;
  DetailBox(this.getGymName, this.getLocation);
  int totalDistance = 7;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 131,
              width: size.width * .45,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/transf1.jpeg'),
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
                  getGymName.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text(
                      'Distance :',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      totalDistance.toString(),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
