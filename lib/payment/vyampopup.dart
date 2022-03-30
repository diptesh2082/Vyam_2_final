import 'dart:js';

import 'package:flutter/material.dart';

_couponpopup(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            content: Container(
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

  _bottomsheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: GestureDetector(
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
                    )),
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
                      onTap: null,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/bi_cash.png",
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
                          const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 14,
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
                    height: 60,
                    child: GestureDetector(
                      onTap: null,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/UPI-logo.png",
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
                    height: 155,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Payment",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.green),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "Total amount",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    "100",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    "-50",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "Grand Total",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    "50",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: const Text(
                          'Pay 50 securely',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        backgroundColor: Colors.black,
                        onPressed: () {
                          print('hhhhhhhhhhhhhh');
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
