import 'package:flutter/material.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Text(
                '1)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
              // Spacer(),
              Text(
                '2)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
              Text(
                '3)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
              Text(
                '4)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
              Text(
                '5)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
              Text(
                '6)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
              Text(
                '7)  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus."',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Praesent sed tellus arcu. Donec ante nunc, semper sed eros a, condimentum hendrerit sapien. Vestibulum volutpat orci eu placerat malesuada. Phasellus non faucibus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. In suscipit neque in enim laoreet tincidunt. Sed auctor neque eget est accumsan consectetur. Praesent sodales libero quis dui euismod facilisis. Nulla in eleifend ipsum. Curabitur quis mi sed quam accumsan cursus. Nulla maximus non ligula in ullamcorper. In euismod cursus purus at porttitor. In molestie ornare eros, scelerisque dignissim ex suscipit Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed justo volutpat, hendrerit ante sagittis, rhoncus leo. Nunc eu libero porta, tincidunt elit non, ornare sapien. Etiam at nulla quis nulla viverra cursus. Praesent sed tellus arcu. Donec ante nunc, semper sed eros a, condimentum hendrerit sapien. Vestibulum volutpat orci eu placerat malesuada. Phasellus non faucibus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. In suscipit neque in enim laoreet tincidunt. Sed auctor neque eget est accumsan consectetur. Praesent sodales libero quis dui euismod facilisis. Nulla in eleifend ipsum. Curabitur quis mi sed quam accumsan cursus. Nulla maximus non ligula in ullamcorper. In euismod cursus purus at porttitor. In molestie ornare eros, scelerisque dignissim ex suscipit eu sakjgdak kdajf kjdsg kljs dlkjsdlkgj isej lksdj klsgjd klsgjd lksjd gklsjd gisdj kjdsglk jgds;kj oisdgj skdgj skdgj ks;j lskdjg klsdjg lkjsdk;g jlskgj lsjksdj lsdjljlk sdgjklsdjg ksdj gkjsdkg jlskd gjk;sdj glksdjg lksjdg k;jdsg k;jdsg k;jsdg kjsd glkjsd;l gj;ksd gjksdjg ;ksdjg k;sdj jksfh djkh sdjk shdkjdsh fkjhds kjfhd sjkhjkds hjkd sfhjkhds jkhds jkhdsjk fhjskdhf ksdlkjlk sdfjlksdj flkdsj flkjdslkf  ;jsdfkljdsklfj klsdj fklsdj fkljsdifj klsdjf klsdjf lkdsfj ksd fmksdfm klsdm fklsdmf klsdm fimkl dmsfkmsdf klsdklfm klsdfm lkdsm fkdsm fklsdm fkmsdklf mkldsmf mds fkmdsklfm kdsm fkldsmf kldsmkl dsfmkldsm fkldms fklmds lfkmdskl mf kjldsf kljsd klfjlksd flkjds fkljsd fkljsdklj dlkfsjlkds jfdsj iisdfj klsdjf idsf jdskljf ilds f sdkjf klsjd flkjs dlksj dlkjsd lkfj slkjdsf  jksh dfjhds kkjh sdflhsd fjhs djkds hfkjd s jjhdsfjkh kjhsdjf khjksd hfjkshd fjkhsdjkhdskjfh jkhsdjk f
