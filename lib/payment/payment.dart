
import 'dart:math';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vyam_2_final/Home/bookings/success_book.dart';
import 'package:vyam_2_final/Home/coupon_page.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import '../api/api.dart';

 AndroidNotificationChannel? channel;
 FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
class PaymentScreen extends StatefulWidget {
  final endDate;
  final booking_id;
  const PaymentScreen({Key? key, required this.endDate, required this.booking_id}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var getData = Get.arguments;
  var gymData = Get.arguments["gym_details"];
  var months = Get.arguments["totalMonths"];
  // late PersistentBottomSheetController _controller; // <------ Instance variable
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  int discount = total_discount;
  int gstTax = 0;
  // ignore: prefer_typing_uninitialized_variables
  var grandTotal;

  var totalDiscount;

  var taxPay;
  String amount = '';
  // String booking_id = Get.arguments["booking_id"];
  final app_bar_controller = ScrollController();
  final cartValue = Get.arguments["totalPrice"];

  final type = Get.arguments["booking_plan"];
  final ven_id = Get.arguments["vendorId"];
  final ven_name = Get.arguments["gymName"];
  final branch = Get.arguments["branch"];
  bool simpl=false;
  getSimpl() async {
    try{
      await FirebaseFirestore.instance.collection("simpl").doc("simpl").snapshots().listen((event) {
        simpl=event["eligable"];
      });
    }catch(e){
      simpl=false;
    }

  }
  showNotification(String title, String info) async {
    // setState(() {
    //   _counter++;
    // });
    await flutterLocalNotificationsPlugin!.show(
      0,
      "${title}",
      "$info",
      NotificationDetails(
        android: AndroidNotificationDetails(channel!.id, channel!.name,
            channelDescription: channel!.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/launcher_icon'),
      ),
    );
  }

  final Razorpay _razorpay = Razorpay();
  // var booking_id=getData["booking_id"];
  var booking_details;

  bool isLoading = false;

  detDil() async {
    var price;
    setState(() {
      price = getData["totalPrice"];
      setState(() {
        discount = total_discount;
      });
      print(discount);

      totalDiscount = ((price * discount) / 100).round();
      taxPay = ((price * gstTax) / 100).round();
      grandTotal = ((price - totalDiscount) + taxPay);
      amount = grandTotal.toString();
    });
    await FirebaseFirestore.instance
        .collection("bookings")
        .doc(widget.booking_id)
        .update({
      "total_price": price,
      // "total_discount":totalDiscount,
      "discount": totalDiscount,
      "grand_total": grandTotal,
      "tax_pay": taxPay,
    });
  }


  @override
  void initState() {
    // print("//////////");
    getSimpl();
    print(widget.booking_id);
    // print(
    //   getData['totalMonths'],
    // );

    // print(type);
    detDil();
    myCouponController.GlobalCouponApplied.value = false;
    myCouponController.GlobalCoupon.value = "";
    myCouponController.CouponDetailsMap.value = "";
    // print(myCouponController.GlobalCouponApplied.value);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  couponClass myCouponController = Get.put(couponClass());

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
check_simpl()async{

  var response2 = await http.get(
    Uri.parse( 'https://sandbox-splitpay-api.getsimpl.com/api/v1/transaction_by_order_id/${widget.booking_id}/status',),
    headers:{
      'Content-Type':'application/json',
      'Authorization':'18c8e9a52d818f865cd0f7df2a254dc3'
    },
    // body: jsonEncode(obj)
  );
  print(response2.body);
  print(response2.statusCode);
  print("success");
  print("+++++++++++++++++++++++++++++++");
  if(response2.statusCode==200){
    print("success");
    print("+++++++++++++++++++++++++++++++");
  }
  var decodedResponse = jsonDecode(utf8.decode(response2.bodyBytes)) as Map;
  var uri = Uri.parse(decodedResponse['data']["status"] );
  print(decodedResponse);
  print(uri);
  if (uri.toString().toLowerCase()=="success")
    {
      try {
        var x = Random().nextInt(9999);
        if (x < 1000) {
          x = x + 1000;
        }
        FocusScope.of(context).unfocus();
        int booking_iiid = 0;
        // Future.wait();
        await FirebaseFirestore.instance
            .collection("bookings")
            .where("booking_status".toLowerCase(),
            whereIn: ["completed", "active", "upcoming", "cancelled"])
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            booking_iiid = await value.docs.length + 186;
          }
        })
            .then((value) async {
          await FirebaseFirestore.instance
              .collection("bookings")
              .doc(widget.booking_id)
              .update({
            "otp_pass": x.toString(),
            "booking_status": "upcoming",
            "payment_done": true,
            "payment_method": "online",
            "id": booking_iiid
          });
        })
            .then((value) async => {

                Get.offAll(() => SuccessBook(branch: branch, ven_name: ven_name, ven_id: ven_id, booking_id: widget.booking_id,), arguments: {
            "otp_pass": x,
            "booking_details": widget.booking_id
          }),

           await showNotification("Booking successful for " + ven_name,
                "Share OTP at the center to start."),

          await FirebaseFirestore.instance
              .collection("coupon")
              .doc(myCouponController.coupon_id.value)
              .collection("used_by")
              .doc()
              .set({
            "user":  Get.find<GlobalUserData>().userData.value["userId"],
            "user_name":  Get.find<GlobalUserData>().userData.value["name"],
            "vendor_id": gymData["gym_id"]
          }),
        });

        // :await showNotification("Booking Status You","Booking Unsuccessful");

        // booking_dCachetails["id"]!=null?

      } catch (e) {}
    }else{

  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(
                      16))),
          content: SizedBox(
            height: 200,
            width: 100,
            child: Stack(
              children: [
                Center(
                  child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .center,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        Image.asset(
                          "assets/icons/x.gif",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          "something wrong",
                          style: const TextStyle(
                              fontFamily:
                              "Poppins",
                              fontSize:
                              16,
                              fontWeight:
                              FontWeight.w600),
                        ),
                        const SizedBox(
                            height:
                            6),
                        Text(
                          "try again",
                          style: const TextStyle(
                              fontFamily:
                              "Poppins",
                              fontSize:
                              16,
                              color: Colors
                                  .red,
                              fontWeight:
                              FontWeight.w600),
                        ),
                      ]),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(
                            context);
                      },
                      child: Icon(
                        Icons
                            .cancel_outlined,
                        color: Colors
                            .black87,
                        size: 20,
                      ),
                    )),
              ],
            ),
          ),
        ),
  );
  }

}



  makeSure() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        content: SizedBox(
          height: 170,
          width: 280,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Proceed payment in cash ?",
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 38,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: HexColor("FFECB2"),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, right: 3, top: 2, bottom: 2),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("030202")),
                                  ),
                                ),
                              )),
                        ),
                        // Image.asset("assets/icons/icons8-approval.gif",
                        //   height: 70,
                        //   width: 70,
                        // ),

                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () async {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              Navigator.pop(context);
                              var x = Random().nextInt(9999);
                              if (x < 1000) {
                                x = x + 1000;
                              }
                              FocusScope.of(context).unfocus();
                              // await getBookingData(getData["booking_id"]);

                              setState(() {
                                isLoading = false;
                              });
                              int? booking_iiid;

                              await FirebaseFirestore.instance
                                  .collection("bookings")
                                  .where("booking_status".toLowerCase(),
                                  whereIn: [
                                    "completed",
                                    "active",
                                    "upcoming",
                                    "cancelled"
                                  ])
                                  .get()
                                  .then((value) async {
                                Get.offAll(() => SuccessBook(branch: branch, ven_name: ven_name, ven_id: ven_id, booking_id: widget.booking_id,), arguments: {
                                  "otp_pass": x,
                                  "booking_details": widget.booking_id
                                });
                                if (value.docs.isNotEmpty) {
                                  booking_iiid =
                                      await value.docs.length + 200;
                                }
                              })
                                  .then((value) async {
                                await FirebaseFirestore.instance
                                    .collection("bookings")
                                    .doc(widget.booking_id)
                                    .update({
                                  "otp_pass": x.toString(),
                                  "booking_status": "upcoming",
                                  "payment_done": false,
                                  "id": booking_iiid
                                });

                              }).then((value) async {
                                await FirebaseFirestore.instance
                                    .collection("coupon")
                                    .doc(myCouponController.coupon_id.value)
                                    .collection("used_by")
                                    .doc()
                                    .set({
                                  "user":  Get.find<GlobalUserData>().userData.value["userId"],
                                  "user_name":  Get.find<GlobalUserData>().userData.value["name"],
                                  "vendor_id": gymData["gym_id"]
                                });
                              });

                              // setState(() {
                              //   isLoading = false;
                              // });
                            } catch (e) {}
                          },
                          child: Container(
                              height: 38,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: HexColor("27AE60"),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, right: 3, top: 2, bottom: 2),
                                child: Center(
                                  child: Text(
                                    "Proceed",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("030105")),
                                  ),
                                ),
                              )),
                        ),
                      ]),
                ],
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.black87,
                      size: 20,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
  _simplpay() async {
    // var client = http.Client();
   var obj={
      "merchant_client_id": "8a54a9a0d2c99b86f81d23fff76e1537",
      "transaction_status_redirection_url": "D:/applications/Vyam_2_the_project_dev/lib/payment/payment.dart",
      "transaction_status_webhook_url": "http://localhost/transac/webhook.php",
      "order_id": "${widget.booking_id.toString()}",
      "user": {
        "phone_number": number.toString().substring(3, number.length),
        "email":  Get.find<GlobalUserData>().userData.value["email"].toString()
      },
      "billing_address": {
        "line1":  Get.find<GlobalUserData>().userData.value["address"].toString(),
        "line2": Get.find<GlobalUserData>().userData.value["locality"].toString(),
        "city": Get.find<GlobalUserData>().userData.value["subLocality"].toString(),
        "state": "West Bangal",
        "country": "India",
        "pincode": Get.find<GlobalUserData>().userData.value["pincode"].toString()
      },
      "items": [
        {
          "sku": "1",
          "quantity": "1",
          "rate_per_item": "1200"
        }
      ],
      "amount_in_paise":  (myCouponController.GlobalCouponApplied.value
          ? (grandTotal -
          int.parse(myCouponController.CouponDetailsMap.value))
          : grandTotal) *
          100,
    };

    try {
      var response = await http.post(
          Uri.parse( 'https://sandbox-splitpay-api.getsimpl.com/api/v1/transaction/initiate',),
          headers:{
            'Content-Type':'application/json',
            'Authorization':'18c8e9a52d818f865cd0f7df2a254dc3'
          },
          body: jsonEncode(obj)
      );

      print(response.body);
      print(response.statusCode);
      if(response.statusCode==200){

        Navigator.of(context).pop();
        Get.to(()=>simpl_pay(check_simpl: check_simpl, gymData: gymData, myCouponController: myCouponController, booking_id: widget.booking_id, grandTotal: grandTotal, getData: getData, totalDiscount: totalDiscount, simpl: simpl,),duration: Duration(milliseconds: 500));
        // _bottomsheet2(context);
        // print("success");
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) ;
        print(decodedResponse["data"]["redirection_url"]);

        var uri = Uri.parse(decodedResponse["data"]["redirection_url"] );
        //
        if (await canLaunch(uri.toString())) {
          await launch(uri.toString(),
          forceSafariVC: true,
            forceWebView: true,
            enableJavaScript: true,
          //   //   // universalLinksOnly:true
            // webOnlyWindowName:"/login"
          );
          return;
        } else {
          throw "Error occured trying to call that number.";
        }
        // var res=await client.get(uri);
        // print(jsonDecode(utf8.decode(res.bodyBytes)));

      }

      // decodedResponse.obs;
      // print(await client.get(uri));
      // response2.transform(utf8.decoder).listen((data) {
      //   contents.write(data);
      // }, onDone: () => completer.complete(contents.toString()));
      // return completer.future;
    } finally {
      // client.close();
    }
    // var app={
    //   "amount_in_paise":(myCouponController.GlobalCouponApplied.value
    //       ? (grandTotal -
    //       int.parse(myCouponController.CouponDetailsMap.value))
    //       : grandTotal) *
    //       100,
    //
    // };
  }
  // 'rzp_test_33NhqFvjcCXYkk'

  _payment() {
    var options = {
      'key': "rzp_live_7twfLFOgOjQnp1",
      'amount': (myCouponController.GlobalCouponApplied.value
              ? (grandTotal -
                  int.parse(myCouponController.CouponDetailsMap.value))
              : grandTotal) *
          100,
      'name': 'Vyam Gym Booking',
      'description': 'Payment',
      // "order_id":"test_jukjktgtu",

      'prefill': {
        'contact': number.toString().substring(3, number.length),
        'email':  Get.find<GlobalUserData>().userData.value["email"].toString()
      },

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
    //
    // print("this is the game${response.signature}");
    // print("the  theory${response.paymentId}");
    // print("the  theory${response.paymentId}");
    // print(response.orderId);

    try {
      var x = Random().nextInt(9999);
      if (x < 1000) {
        x = x + 1000;
      }
      FocusScope.of(context).unfocus();
      int booking_iiid = 0;
      // Future.wait();
      await FirebaseFirestore.instance
          .collection("bookings")
          .where("booking_status".toLowerCase(),
              whereIn: ["completed", "active", "upcoming", "cancelled"])
          .get()
          .then((value) async {
            if (value.docs.isNotEmpty) {
              booking_iiid = await value.docs.length + 186;
            }
          })
          .then((value) async {
        await FirebaseFirestore.instance
            .collection("bookings")
            .doc(widget.booking_id)
            .update({
          "otp_pass": x.toString(),
          "booking_status": "upcoming",
          "payment_done": true,
          "payment_method": "online",
          "id": booking_iiid
        }).then((value) {
          Get.offAll(() => SuccessBook(branch: branch, ven_name: ven_name, ven_id: ven_id, booking_id: widget.booking_id,), arguments: {
            "otp_pass": x,
            "booking_details": widget.booking_id
          });

        });




      }).then((value) async {
        await FirebaseFirestore.instance
            .collection("coupon")
            .doc(myCouponController.coupon_id.value)
            .collection("used_by")
            .doc()
            .set({
          "user":  Get.find<GlobalUserData>().userData.value["userId"],
          "user_name":  Get.find<GlobalUserData>().userData.value["name"],
          "vendor_id": gymData["gym_id"]
        });
      });

      // :await showNotification("Booking Status You","Booking Unsuccessful");

      // booking_dCachetails["id"]!=null?

    } catch (e) {}
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // ignore: avoid_print
    // print(PaymentFailureResponse);
    // Get.off(PaymentScreen());
    print(response.code);
    print(response.message);
    print("payment faild");
    Get.back();


    print("Failed");
    print("//////////////////////////////////////////////////////////////");
    print("Failure Handleeerr");
  }

  Future<void> _handleExternalWallet(ExternalWalletResponse response) async {
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
            child: Stack(
              children: [
                Column(
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
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.black87,
                        size: 20,
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      try {
        var x = Random().nextInt(9999);
        if (x < 1000) {
          x = x + 1000;
        }
        FocusScope.of(context).unfocus();
        int booking_iiid = 0;
        await FirebaseFirestore.instance
            .collection("bookings")
            .where("booking_status".toLowerCase(),
                whereIn: ["completed", "active", "upcoming", "cancelled"])
            .get()
            .then((value) async {
              if (value.docs.isNotEmpty) {
                booking_iiid = await value.docs.length + 186;
              }
            })
            .then((value) async {
              await FirebaseFirestore.instance
                  .collection("bookings")
                  .doc(getData["booking_id"])
                  .update({
                "otp_pass": x.toString(),
                "booking_status": "upcoming",
                "payment_done": true,
                "payment_method": "online",
                "id": booking_iiid
              });
            });
        await FirebaseFirestore.instance
            .collection("booking_notifications")
            .doc()
            .set({
          "title": "upcoming booking",
          "status": "upcoming",
          // "payment_done": false,
          "user_id": number.toString(),
          "user_name":  Get.find<GlobalUserData>().userData.value["name"],
          "vendor_id": ven_id,
          "vendor_name": ven_name,
          "time_stamp": DateTime.now(),
          "booking_id": widget.booking_id,
          "seen": false,
          "branch": branch
        }).then((value) async {
          Get.offAll(() => SuccessBook(branch: branch, ven_name: ven_name, ven_id: ven_id, booking_id: widget.booking_id,), arguments: {
            "otp_pass": x,
            "booking_details": widget.booking_id
          });
          if (myCouponController.GlobalCouponApplied.value == true) {
            await FirebaseFirestore.instance
                .collection("coupon")
                .doc(myCouponController.coupon_id.value)
                .collection("used_by")
                .doc()
                .set({
              "user":  Get.find<GlobalUserData>().userData.value["userId"],
              "user_name":  Get.find<GlobalUserData>().userData.value["name"],
              "vendor_id": gymData["gym_id"]
            });
          }
        });


    await (showNotification("Booking successful for " + ven_name, "Share OTP at the center to start."));
        // :await showNotification("Booking Status You","Booking Unsuccessful");

        // booking_dCachetails["id"]!=null?

      } catch (e) {}
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

    return isLoading
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          )
        : Scaffold(
            appBar: ScrollAppBar(
              controller: app_bar_controller,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              title: InkWell(
                onTap: () {
                  print(ven_name);
                },
                child: const Text(
                  // "Add Your Location Here",
                  "Booking Summary",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
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
                            elevation: 0.2,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: DetailBox(
                                      getData['gymName'].toString(),
                                      getData['gym_details']["branch"]
                                          .toString(),
                                      getData["gym_details"]['address']
                                          .toString(),
                                      getData["gym_details"]
                                          ['display_picture']),
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
                                      left: 8.0, right: 8, top: 5, bottom: 0),
                                  child: SizedBox(
                                      height: 127,
                                      child: Column(children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 0),
                                                  child: Text(
                                                    "Workout",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        color: Colors.green),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0),
                                                  child: Text(
                                                    getData['packageType'],
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Poppins",
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 0,
                                                      top: 0,
                                                      left: 0),
                                                  child: Center(
                                                    child: Text(
                                                      months
                                                                  .trim()
                                                                  .toLowerCase() ==
                                                              "pay per session"
                                                          ? months
                                                          : "Package",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, top: 0),
                                                  child: Text(
                                                    months
                                                                .trim()
                                                                .toLowerCase() ==
                                                            "pay per session"
                                                        ? "${getData["totalDays"].toString()} ${getData["totalDays"] > 1 ? "Days" : "Day"}"
                                                        : type ?? "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        // color: ,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0, top: 0),
                                                  child: Text(
                                                    "Start Date",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      // fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, top: 0),
                                                  child: Text(
                                                    getData["startDate"]
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0, top: 0),
                                                  child: Text(
                                                    "Valid Upto",
                                                    style: GoogleFonts.poppins(
                                                      // fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, top: 0),
                                                  child: Text(
                                                    widget.endDate.toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ])),
                                )
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: 2,
                          // ),
                          GestureDetector(
                            onTap: () => Get.to(
                                () => CouponDetails(
                                      cartValue: getData["totalPrice"],
                                      type: getData["totalMonths"],
                                    ),
                                arguments: getData),
                            child: Obx(
                              () => Card(
                                elevation: .2,
                                child: SizedBox(
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 9.0, right: 9, top: 0, bottom: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .77,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Apply promo code",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Image.asset(
                                                    "assets/icons/discount.png",
                                                    color: Colors.amber,
                                                  ),
                                                  Spacer(),
                                                  if (myCouponController
                                                          .GlobalCouponApplied
                                                          .value ==
                                                      true)
                                                    Text(
                                                      "- ₹ ${myCouponController.CouponDetailsMap.value}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.green),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .77,
                                              child: Row(
                                                children: [
                                                  RichText(
                                                      text: TextSpan(
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  // fontFamily: "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                          children: <TextSpan>[
                                                        TextSpan(
                                                            text: myCouponController
                                                                    .GlobalCouponApplied
                                                                    .value
                                                                ? "Promo "
                                                                : "No Promo "),
                                                        TextSpan(
                                                          text: myCouponController
                                                                  .GlobalCouponApplied
                                                                  .value
                                                              ? "${myCouponController.GlobalCoupon.value} "
                                                              : "code ",
                                                          style: myCouponController
                                                                  .GlobalCouponApplied
                                                                  .value
                                                              ? GoogleFonts
                                                                  .poppins(
                                                                      // fontFamily: "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .amber)
                                                              : GoogleFonts
                                                                  .poppins(
                                                                      // fontFamily: "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                        ),
                                                        TextSpan(
                                                            text: GlobalCouponApplied
                                                                ? "Applied"
                                                                : "Selected"),
                                                      ])),
                                                  Spacer(),
                                                  if (myCouponController
                                                          .GlobalCouponApplied
                                                          .value ==
                                                      true)
                                                    InkWell(
                                                      onTap: () async {
                                                        myCouponController
                                                            .GlobalCouponApplied
                                                            .value = await false;
                                                        myCouponController
                                                            .GlobalCoupon
                                                            .value = await "";
                                                        // myCouponController.CouponDetailsMap.value= coupon_list[coupon];
                                                      },
                                                      child: Text(
                                                        "REMOVE",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .amber),
                                                      ),
                                                    ),
                                                  // if(myCouponController.GlobalCouponApplied.value==true)
                                                ],
                                              ),
                                            ),
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
                          ),
                          // const SizedBox(
                          //   height: 2,
                          // ),
                          Obx(
                            () => Card(
                              elevation: .2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, top: 3, bottom: 5),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(
                                          left: 0, top: 3),
                                      child: InkWell(
                                        onTap: () {
                                          print(months);
                                        },
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
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, top: 3),
                                          child: Text(
                                            "Total Amount",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, top: 3),
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
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, top: 3),
                                          child: Text(
                                            "Discount",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, top: 3),
                                          child: Text(
                                            "₹  ${myCouponController.GlobalCouponApplied.value ? myCouponController.CouponDetailsMap.value.toString() : totalDiscount.toString()}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(left: 0, top: 3),
                                    //       child: Text(
                                    //         "GST",
                                    //         style: GoogleFonts.poppins(
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.w500),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           right: 0, top: 3),
                                    //       child: Text(
                                    //         "₹" + taxPay.toString(),
                                    //         style: const TextStyle(
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, top: 3),
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
                                            "₹ ${myCouponController.GlobalCouponApplied.value ? (grandTotal - int.parse(myCouponController.CouponDetailsMap.value)) : grandTotal.toString()}",
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
                                    Image.asset(
                                        "assets/icons/best discounts.png",
                                        height: 25,
                                        width: 25),
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
                                    Image.asset(
                                        "assets/icons/secured payments.png",
                                        height: 25,
                                        width: 25),
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
                                    Image.asset(
                                        "assets/icons/customer support.png",
                                        height: 25,
                                        width: 25),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "₹ ${myCouponController.GlobalCouponApplied.value ? (grandTotal - int.parse(myCouponController.CouponDetailsMap.value.toString())) : grandTotal.toString()} /-",
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Inc all taxes",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          )
                        ],
                      ),
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

  Pay() async {
    await FirebaseFirestore.instance
        .collection("bookings")
        .doc(widget.booking_id)
        .update({
      "discount": myCouponController.GlobalCouponApplied.value
          ? (int.parse(myCouponController.CouponDetailsMap.value))
          : totalDiscount,
      "grand_total": myCouponController.GlobalCouponApplied.value
          ? (grandTotal - int.parse(myCouponController.CouponDetailsMap.value))
              .toString()
          : grandTotal.toString(),
      "tax_pay": taxPay,
    });
    _payment();
    setState(() {
      GlobalCouponApplied = false;
      onlinePay = true;
    });
    // _PaymentScreenState();

    // print(onlinePay);
  }



  OffPay() async {
    makeSure();
  }


  String PAY="on";

  _bottomsheet(BuildContext context) async {
    // var _width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    // bool onlinePay = true;
    // _controller = await _scaffoldKey.currentState.showBottomSheet
    return showModalBottomSheet(
        // isDismissible: false,
        isScrollControlled: true,
        // enableDrag: false,
        context: context,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
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
                            if (gymData["cash_pay"] == true)
                              setState(() {
                                PAY = "off";
                              });

                            // _PaymentScreenState();
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
                              if (gymData["cash_pay"] == true)
                                const Text(
                                  "Pay at gym",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              if (gymData["cash_pay"] == true) const Spacer(),
                              if (PAY == "off" ||
                                  (gymData["online_pay"] == false &&
                                      gymData["cash_pay"] == true))
                                const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              if (gymData["cash_pay"] == false)
                                const Text(
                                  "Cash isn't available in this gym",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
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
if(simpl)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            // if (gymData["cash_pay"] == true)
                              setState(() {
                                PAY = "simpl";
                              });

                            // _PaymentScreenState();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/Simpl_Logo.png",
                                width: 60,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              if (simpl== true)
                                const Text(
                                  "Pay with Simpl",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              if (simpl == true) const Spacer(),
                              if (PAY == "simpl" ||
                                  (gymData["online_pay"] == false &&
                                      gymData["cash_pay"] == true))
                                const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              if (simpl == false)
                                const Text(
                                  "Cash isn't available in this gym",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
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
                    // if(gymData["online_pay"])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              PAY = "on";
                            });
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
                              if (gymData["online_pay"])
                                const Text(
                                  "Online",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              if (gymData["online_pay"] == false)
                                const Text(
                                  "Online isn't available in this gym",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              const Spacer(),
                              if (PAY == "on" && gymData["online_pay"])
                                const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 15,
                                ),
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
                                      Obx(
                                        () => Text(
                                          "₹  ${myCouponController.GlobalCouponApplied.value ? myCouponController.CouponDetailsMap.value.toString() : totalDiscount.toString()}",
                                          style: GoogleFonts.poppins(
                                              // fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
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
                                        "₹${myCouponController.GlobalCouponApplied.value ? (grandTotal - int.parse(myCouponController.CouponDetailsMap.value)) : grandTotal.toString()}",
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
                              'Pay  ₹${myCouponController.GlobalCouponApplied.value ? (grandTotal - int.parse(myCouponController.CouponDetailsMap.value)) : grandTotal.toString()} securely',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            onPressed: () async {
                              print('hhhhhhhhhhhhhh${widget.booking_id}');
                              await FirebaseFirestore.instance
                                  .collection("bookings")
                                  .doc(widget.booking_id)
                                  .update({
                                "discount":
                                myCouponController.GlobalCouponApplied.value
                                    ? (int.parse(myCouponController
                                    .CouponDetailsMap.value))
                                    : totalDiscount,
                                "grand_total":
                                myCouponController.GlobalCouponApplied.value
                                    ? (grandTotal -
                                    int.parse(myCouponController
                                        .CouponDetailsMap.value))
                                    .toString()
                                    : grandTotal.toString(),
                                "tax_pay": taxPay,
                                "booking_status": "incomplete",
                              }).then((value){
                                if(PAY=="simpl"){
                                  _simplpay();
                                }
                                if(PAY=="on"){
                                  Pay();
                                }
                                if(PAY=="off"){
                                  OffPay();
                                }
                              });


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
              height: 110,
              width: size.width * .45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(
            width: 10,
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
                maxLines: 2,
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
                      color: Colors.grey,
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
class simpl_pay extends StatelessWidget {
  final Function check_simpl;
  final gymData;
  final myCouponController;
  final booking_id;
  final grandTotal;
  final getData;
  final totalDiscount;
  final simpl;
  const simpl_pay({Key? key,required this.check_simpl,required this.gymData,required this.myCouponController,required this.booking_id,
    required this.grandTotal,required this.getData,required this.totalDiscount,required this.simpl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(simpl);
    print("+++++++++++++++++qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
    return WillPopScope(
      onWillPop: ()async {
        await check_simpl();
        Future.delayed(Duration(milliseconds: 200));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: true,
          title:  Text(
            "Payment method Simpl",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          // leading: IconButton(icon: Icon(CupertinoIcons.back),
          //   onPressed: () {
          //     check_simpl();
          //   Navigator.pop(context);
          //
          // },
          // ),
        ),
        body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                // height: 5,
                // height: 600,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Spacer(),
                    // SizedBox(
                    //   height:MediaQuery.of(context).size.height*.4,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: const Padding(
                    //     padding: EdgeInsets.only(right: 8.0, top: 8),
                    //     child: Align(
                    //       alignment: Alignment.topRight,
                    //       child: CircleAvatar(
                    //         radius: 10.0,
                    //         backgroundColor: Colors.grey,
                    //         child: Icon(
                    //           Icons.close,
                    //           size: 16,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    // const

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            if (gymData["cash_pay"] == true)
                              setState(() {
                                onlinePay = false;
                              });

                            // _PaymentScreenState();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/images/Simpl_Logo.png",
                                width: 60,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              if (gymData["cash_pay"] == true)
                                const Text(
                                  "Pay at gym",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              if (gymData["cash_pay"] == true) const Spacer(),
                              if (onlinePay == false ||
                                  (gymData["online_pay"] == false &&
                                      gymData["cash_pay"] == true))
                                const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              if (gymData["cash_pay"] == false)
                                const Text(
                                  "Cash isn't available in this gym",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
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
                                      Obx(
                                            () => Text(
                                          "₹  ${myCouponController.GlobalCouponApplied.value ? myCouponController.CouponDetailsMap.value.toString() : totalDiscount.toString()}",
                                          style: GoogleFonts.poppins(
                                            // fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
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
                                        "₹${myCouponController.GlobalCouponApplied.value ? (grandTotal - int.parse(myCouponController.CouponDetailsMap.value)) : grandTotal.toString()}",
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width *.44,
                          child: FloatingActionButton.extended(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Text(
                                  "Confirm Payment",
                                  style: GoogleFonts.poppins(

                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                print('hhhhhhhhhhhhhh${booking_id}');
                                check_simpl();

                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
