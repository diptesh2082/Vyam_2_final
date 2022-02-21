import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/payment/custom_api.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var getData = Get.arguments;
  int discount = 20;
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {}
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
                                getData['landmark'].toString(),
                                getData['address'].toString(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.black26,
                              height: 10,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          "Workout",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                              fontSize: 17,
                                              color: Colors.green),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, top: 10),
                                        child: Text(
                                          getData['packageType'],
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                              fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 15, top: 10, left: 10),
                                        child: Center(
                                          child: Text(
                                            "Package",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, top: 10),
                                        child: Text(
                                          getData['totalMonths'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(left: 12, top: 5),
                                        child: Text(
                                          "Start Date",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, top: 5),
                                        child: Text(
                                          getData["startDate"],
                                          style: const TextStyle(
                                              fontSize: 15,
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
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(left: 12, top: 5),
                                        child: Text(
                                          "Valid Upto",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, top: 5),
                                        child: Text(
                                          getData["endDate"],
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: GestureDetector(
                          onTap: () => Get.to(() => CouponDetails()),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Apply promo code",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/icons/discount.png",
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      "No promo code selected",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                const EdgeInsets.only(left: 10, top: 2),
                                child: const Text(
                                  "Payment",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: "Poppins",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12, top: 5),
                                    child: Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 5),
                                    child: Text(
                                      "₹${getData["totalPrice"]}",
                                      style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12, top: 5),
                                    child: Text(
                                      "Discount",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 5),
                                    child: Text(
                                      "₹" + totalDiscount.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
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
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12, top: 5),
                                    child: Text(
                                      "GST",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 5),
                                    child: Text(
                                      "₹" + taxPay.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                        height: 15,
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
                                const Text(
                                  "Best Discount",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset("assets/icons/secured payments.png",
                                    height: 25, width: 25),
                                const Text(
                                  "Secured Payment",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                )
                              ],
                            ),
                            Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Image.asset("assets/icons/customer support.png",
                                    height: 25, width: 25),
                                const Text(
                                  "24/7 support",
                                  style: TextStyle(fontFamily: "Poppins"),
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
                const SizedBox(
                  width: 80,
                ),
                SizedBox(
                  height: 50,
                  width: 190,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    elevation: 8,
                    splashColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
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
  const DetailBox(this.getGymName, this.getLandmark, this.getLocation,
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
                      maxLines: 1,
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