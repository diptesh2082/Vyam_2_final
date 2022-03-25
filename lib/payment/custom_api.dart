import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  CustomAppBar({
    required this.title,
    required this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.grey[100],
      title: const Text(
        // "Add Your Location Here",
        "Booking Summary",
        style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      leading: IconButton(
        color: Colors.black,
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      // actions: <Widget>[
      //   Padding(
      //     padding: const EdgeInsets.only(right: 20.0),
      //     child: CircleAvatar(
      //         backgroundColor: Colors.white70,
      //         child: IconButton(
      //             icon: const Icon(Icons.menu),
      //             onPressed: () {
      //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreenDrawer()));
      //             })),
      //   ),
      // ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sliver_appbar_ii_example/widget/image_widget.dart';

class BasicSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.red,
              expandedHeight: 200,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://source.unsplash.com/random?monochromatic+dark',
                  fit: BoxFit.cover,
                ),
                title: Text('Flexible Title'),
                centerTitle: true,
              ),
              //title: Text('My App Bar'),
              leading: Icon(Icons.arrow_back),
              actions: [
                Icon(Icons.settings),
                SizedBox(width: 12),
              ],
            ),
            // buildImages(),
          ],
        ),
      );
}
//   Widget buildImages() => SliverToBoxAdapter(
//     child: GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       primary: false,
//       shrinkWrap: true,
//       itemCount: 20,
//       itemBuilder: (context, index) => ImageWidget(index: index),
//     ),
//   );
// }
// AppBar(
// elevation: .0,
// centerTitle: false,
// backgroundColor: const Color(0xffF4F4F4),
// title: Column(
// children: [
// const SizedBox(
// height: 6,
// ),
// Transform(
// transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
// child: Row(
// children: [
// IconButton(
// iconSize: 25,
// icon: const Icon(
// CupertinoIcons.location,
// color: Colors.black,
// ),
// onPressed: () async {
// FocusScope.of(context).unfocus();
// // Get.back();
// // print(_auth.currentUser?.uid);
// // Position position = await _determinePosition();
// // await GetAddressFromLatLong(position);
// // await UserApi.updateUserAddress(
// //     address, [position.latitude, position.longitude], pin
// // );
// await getAddressPin(pin);
//
// setState((){
// // myaddress = myaddress;
// address = address;
// pin = pin;
// GlobalUserLocation=user_data["address"];
// });
// Get.to(()=>LocInfo());
// },
// ),
// SizedBox(
// width: size.width * .55,
// child: Text(
// user_data["address"] ?? "your Location",
// textAlign: TextAlign.left,
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// style: const TextStyle(
// color: Colors.black,
// fontFamily: "Poppins",
// fontSize: 13,
// fontWeight: FontWeight.w500),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// actions: [
// Column(
// children: [
// const SizedBox(
// height: 6,
// ),
// IconButton(
// icon: const Icon(
// HomeIcon.notification,
// color: Colors.black,
// ),
// onPressed: () {
// // print(number);
// FocusScope.of(context).unfocus();
// Get.to(const NotificationDetails());
// },
// ),
// ],
// ),
//
// ],
// ),