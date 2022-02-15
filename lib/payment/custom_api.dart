import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        "Booking Summery",
        style: TextStyle(
          fontFamily: "Poppins",
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      leading: IconButton(
        color: Colors.black,
        onPressed: (){}, icon: const Icon(Icons.arrow_back_ios),

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
