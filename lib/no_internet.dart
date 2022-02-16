import 'package:flutter/material.dart';
import 'package:vyam2/success_book.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(child: Image.asset("assets/No_connection.png")),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text(
          'No Internet Connection',
          style: TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 20),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          'Check your connection \n then, refresh the page',
          style: TextStyle(
              color: Colors.grey,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.008,
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
          child: const Text(
            'Refresh',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SuccessBook()));
          },
        ),
      ],
    ));
  }
}
