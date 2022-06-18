import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../golbal_variables.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          title: Text("Terms And Condition"),
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
        body: Scrollbar(
          thickness: 7,
          interactive: true,
          radius: Radius.circular(22),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      '''Welcome to VYAM.
These terms and conditions outline the rules and regulations for the use of VYAM's Website, located at https://vyam.co.in/.
By accessing this website we assume you accept these terms and conditions. Do not continue to use vyam.co.in if you do not agree to take all of the terms and conditions stated on this page.
The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.
Cookies
We employ the use of cookies. By accessing vyam.co.in, you agreed to use cookies in agreement with the VYAM's Privacy Policy.
Most interactive websites use cookies to let us retrieve the user’s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.
License
Unless otherwise stated, VYAM and/or its licensors own the intellectual property rights for all material on vyam.co.in. All intellectual property rights are reserved. You may access this from vyam.co.in for your own personal use subjected to restrictions set in these terms and conditions.
You must not:
  - Republish material from VYAM or vyam.co.in
  - Sell, rent or sub-license material from VYAM or vyam.co.in
  - Reproduce, duplicate or copy material from VYAM or vyam.co.in
  - Redistribute content from VYAM or vyam.co.in
Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. VYAM does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of VYAM, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, VYAM shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.
VYAM reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.
You warrant and represent that:
  - You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;
  - The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;
  - The Comments do not contain any defamatory, offensive, indecent or otherwise unlawful material which is an invasion of privacy
  - The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.
You hereby grant VYAM a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.
Hyperlinking to our Content
The following organizations may link to our Website without prior written approval:
  - Government agencies;
  - Search engines;
  - News organizations;
  - Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and
These organizations may link to our home page, to publications or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.
We may consider and approve other link requests from the following types of organizations:
  - commonly-known consumer and/or business information sources;
  - dot.com community sites;
  - associations or other groups representing charities;
  - online directory distributors;
  - internet portals;
  - accounting, law, and consulting firms; and
  - educational institutions and trade associations.
We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of VYAM, and (d) the link is in the context of general resource information.
These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.
If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to VYAM. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.
Approved organizations may hyperlink to our Website as follows:
  - By use of our corporate name; or
  - By use of the uniform resource locator being linked to; or
  - By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party’s site.
No use of VYAM's logo or other artwork will be allowed for linking absent a trademark license agreement.
iFrames
Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.
Content Liability
We shall not be hold responsible for any content that appears on your Website. You agree to protect and defend us against all claims that is rising on your Website. No link(s) should appear on any Website that may be interpreted as obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.
Your Privacy
Please read Privacy Policy
Reservation of Rights
We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.
Removal of links from our website
If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.
We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.
Disclaimer
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website and app. Nothing in this disclaimer will:
  - limit or exclude our or your liability for death or personal injury;
  - limit or exclude our or your liability for fraud or fraudulent misrepresentation;
  - limit any of our or your liabilities in any way that is not permitted under applicable law; or
exclude any of our or your liabilities that may not be excluded under applicable law.
The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.
As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.
Refund and cancellation
VYAM makes sure that every member is a happy member. We ensure to clear all your doubts and help you through every step providing you a seamless journey at VYAM.
Booked a GYM? Mind changed? Want to cancel? Do not worry. Your money is your money, none of our money.
Pay-per-day :
1: Minimum or no charges might apply if you cancel your booking before you share OTP with GYM i.e. before booking gets activated.
2:  In case of a transaction made to purchase a Workout Session, you will not be entitled to a refund/reschedule if you fail to attend the session.
3: In case of unfulfillment from VYAM or affiliate service provider, 100% refund will be given.
4: In case of service provider cancels the paid Session , 100% refund will be given .
Package :
1: Minimum or no charges might apply if you cancel your booking before you share OTP with GYM i.e. before booking gets activated.
2: In case of unfulfillment from VYAM or affiliate service provider, 100% refund will be given.
3:  In case of service provider cancels the paid Session , 100% refund will be given .
4: Once you share OTP with GYM and your booking gets activated no refund is guaranteed (except certain circumstances)
5: If you bought a package and due to some reasons GYMs are closed (lockdown or any other issue)  do not worry, your booking will be extended with no extra cost.
Need more help?
Write us at support@vyam.co.in or call us at 9102691777, we will be happy to serve you.
You can also visit www.vyam.co.in for more.
Follow us on Instagram for fitness content : @vyam.app''',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          textStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '1)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.amber)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '2)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.black)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '3)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.amber)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '4)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.black)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '5)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.amber)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '6)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.black)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: Text(
                  //     '7)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.w400,
                  //         textStyle: TextStyle(color: Colors.amber)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  consectetur. Praesent sodales libero quis dui euismod facilisis. Nulla in eleifend ipsum. Curabitur quis mi sed quam accumsan cursus. Nulla maximus non ligula in ullamcorper. In euismod cursus purus at porttitor. In molestie ornare eros, scelerisque dignissim ex suscipit Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus. Praesent sed tellus arcu. Donec ante nunc, semper sed eros a, condimentum hendrerit sapien. Vestibulum volutpat orci eu placerat malesuada. Phasellus non faucibus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. In suscipit neque in enim laoreet tincidunt. Sed auctor neque eget est accumsan consectetur. Praesent sodales libero quis dui euismod facilisis. Nulla in eleifend ipsum. Curabitur quis mi sed quam accumsan cursus. Nulla maximus non ligula in ullamcorper. In euismod cursus purus at porttitor. In molestie ornare eros, scelerisque dignissim ex suscipit eu sakjgdak kdajf kjdsg kljs dlkjsdlkgj isej lksdj klsgjd klsgjd lksjd gklsjd gisdj kjdsglk jgds;kj oisdgj skdgj skdgj ks;j lskdjg klsdjg lkjsdk;g jlskgj lsjksdj lsdjljlk sdgjklsdjg ksdj gkjsdkg jlskd gjk;sdj glksdjg lksjdg k;jdsg k;jdsg k;jsdg kjsd glkjsd;l gj;ksd gjksdjg ;ksdjg k;sdj jksfh djkh sdjk shdkjdsh fkjhds kjfhd sjkhjkds hjkd sfhjkhds jkhds jkhdsjk fhjskdhf ksdlkjlk sdfjlksdj flkdsj flkjdslkf  ;jsdfkljdsklfj klsdj fklsdj fkljsdifj klsdjf klsdjf lkdsfj ksd fmksdfm klsdm fklsdmf klsdm fimkl dmsfkmsdf klsdklfm klsdfm lkdsm fkdsm fklsdm fkmsdklf mkldsmf mds fkmdsklfm kdsm fkldsmf kldsmkl dsfmkldsm fkldms fklmds lfkmdskl mf kjldsf kljsd klfjlksd flkjds fkljsd fkljsdklj dlkfsjlkds jfdsj iisdfj klsdjf idsf jdskljf ilds f sdkjf klsjd flkjs dlksj dlkjsd lkfj slkjdsf  jksh dfjhds kkjh sdflhsd fjhs djkds hfkjd s jjhdsfjkh kjhsdjf khjksd hfjkshd fjkhsdjkhdskjfh jkhsdjk f

