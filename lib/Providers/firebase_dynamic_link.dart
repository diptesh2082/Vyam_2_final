import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';


class FireBaseDynamicLinkService {
  static Future ? dynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://vyam.page.link/"),
      uriPrefix: "https://vyam.page.link/",
      androidParameters: const AndroidParameters(
          packageName: "com.vyamdip.vyam_2_final"),
      iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    return dynamicLink;

  }
}