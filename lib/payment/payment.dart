import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/payment/custom_api.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: DetailBox()),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.yellow,
                      height: 10,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 15, top: 10),
                              child: Text(
                                "Workout",
                                style: TextStyle(

                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 15, top: 10),
                              child: Text(
                                "Pay Per Day",
                                style: TextStyle(
                                    color: Colors.greenAccent,
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, top: 10),
                              child: Container(
                                height: 30,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.greenAccent,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.green,
                                        Colors.greenAccent
                                      ],
                                    )),
                                child: const Center(
                                  child: Text(
                                    "Pay Par Day",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, top: 10),
                              child: Text(
                                "{value[1]}",
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
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 12, top: 5),
                              child: Text(
                                "Start date",
                                style: TextStyle(

                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 12, top: 5),
                              child: Text(
                                "January 08 2022",
                                style: TextStyle(

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
                            const Padding(
                              padding: EdgeInsets.only(right: 12, top: 5),
                              child: Text(
                                "January 08 2022",
                                style: TextStyle(

                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      color: Colors.yellow,
                      height: 10,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 3.0, left: 2),
                              child: Text(
                                "Select promo code",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Text(
                              "No promo code Selected",
                              style: TextStyle(
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, top: 10),
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.redAccent,
                                    Colors.red,
                                  ],
                                )),
                            child: const Center(
                              child: Text(
                                "ADD",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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

                            fontSize: 17,
                            fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.only(right: 12, top: 5),
                          child: Text(
                            "₹ {value[0]}",
                            style: const TextStyle(

                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5),
                          child: Text(
                            "Discount",
                            style: TextStyle(

                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12, top: 5),
                          child: Text(
                            "₹ 0.0",
                            style: TextStyle(

                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5),
                          child: Text(
                            "Promo Code",
                            style: TextStyle(

                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12, top: 5),
                          child: Text(
                            "0",
                            style: TextStyle(

                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.yellow,
                      height: 10,
                      thickness: .5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 5),
                          child: Text(
                            "Grand Total",
                            style: TextStyle(

                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12, top: 5),
                          child: Text(
                            "₹ {value[0]}",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
                                color: Colors.yellowAccent,
                                size: 50.0,
                              ),
                              Text(
                                "Secured Payment",
                                style: TextStyle(color: Colors.yellowAccent),
                              )
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Icons.airline_seat_flat_sharp,
                                color: Colors.yellowAccent,
                                size: 50.0,
                              ),
                              Text(
                                "Best Discount",
                                style: TextStyle(color: Colors.yellowAccent),
                              )
                            ],
                          ),
                          Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.settings,
                                color: Colors.yellowAccent,
                                size: 50.0,
                              ),
                              const Text(
                                "Customer support",
                                style: TextStyle(color: Colors.yellowAccent),
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
                        width: 120,
                        child: FlatButton(
                          onPressed: () {
                            // Get.to(() => OrderScreen());
                          },
                          height: 35,
                          color: Colors.yellowAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),

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
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}

class DetailBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return SafeArea(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 131,
              width: size.width*.45,
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
                const Text(
                  "Fitness Gym",
                  style: TextStyle(
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
                const Text(
                  "data is in thr are denger  dtfrhgh ui wtw",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle( fontSize: 15),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: const [
                    Text(
                      'Brance :',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(

                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Kolkata",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
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
