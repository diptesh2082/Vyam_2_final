
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/api/api.dart';

import '../icons/profileicon_icons.dart';
import 'gymStream.dart';

class SearchIt extends StatefulWidget {
  const SearchIt({Key? key}) : super(key: key);
  @override
  State<SearchIt> createState() => _SearchItState();
}

class _SearchItState extends State<SearchIt> {


  // TextEditingController searchController = TextEditingController();
  // String searchGymName = '';
  // bool showSearch=false;
  FocusNode _node = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _node.unfocus();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 1000,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Obx(
            () => Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .92,
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: TextField(
                      focusNode: _node,
                      autofocus: false,
                      textAlignVertical: TextAlignVertical.bottom,
                      onSubmitted: (value) async {
                        FocusScope.of(context).unfocus();
                        // setState(() {
                        Get.find<Need>().showSearch.value=false;
                        // });
                      },
                      // controller: searchController,
                      onTap: (){
                        // setState(() {
                        Get.find<Need>().showSearch.value=true;
                        // });

                      },
                      onChanged: (value) {
                        if (value.length == 0) {
                          Future.delayed(Duration(milliseconds: 200),(){
                            _node.unfocus();
                            // setState(() {
                              Get.find<Need>().showSearch.value=false;
                            // });

                          });

                          // FocusScope.of(context).unfocus();
                        }
                        // if(value.length!=0){
                          Get.find<Need>().search.value = value.toString().trim();
                        Get.find<Need>().showSearch.value=true;
                        // }

                        // if (mounted) {
                        //   setState(() {
                        //     searchGymName = value.toString();
                        //   });
                        // }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Profileicon.search),
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (Get.find<Need>().search.value.isNotEmpty || Get.find<Need>().showSearch.value)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        buildGymBox(),
                        const SizedBox(
                          height: 500,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildGymBox() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .93,
      // height: 700,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildBox(search: true,),

          ],
        ),
      ),
    );
  }
}
