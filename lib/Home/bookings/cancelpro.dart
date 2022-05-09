import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/OrderDetails/active_details.dart';

class BooKingCancelation extends StatelessWidget {
  final doc;
  const BooKingCancelation( {Key? key,required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: ()async {
        Get.off(()=>ActiveOrderDetails(),
        arguments: {
          "doc":doc
        }
        );
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("assets/icons/x.gif",
                  height: 110,
                    width: 110,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Booking Canceled!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Your",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}