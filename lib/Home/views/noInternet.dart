import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/api/api.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                "assets/Illustrations/No_connection.png"
            ),
            SizedBox(
              height: 25,
            ),
            Text("No internet connection",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),

            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 140,
              height: 40,
              child: Text("Check your connection then, refresh the page.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 37,
                width: 110,
                child: ElevatedButton(onPressed: (){
                    // getInternet();
                   AppSettings.openWirelessSettings();

                }, child: Text("Enable",
                style: GoogleFonts.poppins(
                  color: Color(0xffffffff)
                ),
                )
                ,style: ElevatedButton.styleFrom(
                    primary: Color(0xff292F3D),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
