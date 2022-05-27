import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vyam_2_final/OrderDetails/active_details.dart';

class BooKingCancelation extends StatelessWidget {
  final doc;
  const BooKingCancelation({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => ActiveOrderDetails(), arguments: {"doc": doc});
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
// <<<<<<< thed
              children: [
                Lottie.asset('assets/icons/asf.json', height: 100, width: 400),
// =======
//               children:  [
//                 Image.asset("assets/icons/x.gif",
//                 height: 110,
//                   width: 110,

//                   // colorBlendMode: true,
//                 ),
// >>>>>>> master
                SizedBox(height: 16.0),
                Text(
                  "Booking Canceled!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Your Refund for pre-paid orders will  reflect within a maximum of 3-4 business days.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
