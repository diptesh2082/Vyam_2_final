import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Us"),
          centerTitle: true,
          foregroundColor: Color(0xff3A3A3A),
          backgroundColor: Color(0xffE5E5E5),
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context, false),
            color: Color(0xff3A3A3A),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(
                FontAwesomeIcons.envelope,
                color: Color(0xff292D32),
                size: 20,
              ),
              title: Text(
                'luffytaro@gmail.com',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              child: Divider(
                color: Color(0xffE9E9E9),
                thickness: 1.5,
                height: 5,
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.instagram,
                color: Color(0xff292D32),
                size: 20,
              ),
              title: Text(
                '@vyam',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            Divider(
              color: Color(0xffE9E9E9),
              thickness: 1.5,
              height: 5,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.phone,
                color: Color(0xff292D32),
                size: 20,
              ),
              title: Text(
                '999893423',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.earthAmericas,
                color: Color(0xff292D32),
                size: 20,
              ),
              title: Text(
                'www.vyam.com',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ));
  }
}
