import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/colors/color.dart';
import 'package:vyam_2_final/controllers/location_controller.dart';
import 'package:vyam_2_final/models/user_model.dart';


class RegistrationPage extends StatefulWidget {
  static String id = "/registration_page";
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var groupValue = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
          },
          ),
          title: const Text(""
              "Register",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      body: Form(
        child: ListView(
            children:  [
              Padding(
                padding: EdgeInsets.only(top: size.height/15),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.black,
                        ),
                        height: 115,
                        width: 115,

                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                            radius: size.width/7,
                          backgroundColor: Colors.yellowAccent,
                          child: IconButton(
                            iconSize: 100,
                            onPressed: (){
                              // pickImage(ImageSource.gallery);
                            },
                            icon: const Icon(
                                Icons.add_a_photo_outlined,
                              size: 70,
                              color: Colors.black87,
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black87,
                          width: 2
                        )
                    ),
                    labelText: "First name",
                    fillColor: Colors.orangeAccent,
                    hoverColor: Colors.orangeAccent,
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    )
                  ),
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.orangeAccent,
                  // autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
                child: TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2
                          )
                      ),
                      labelText: "Number",
                      fillColor: Colors.orangeAccent,
                      hoverColor: Colors.orangeAccent,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                  ),
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.orangeAccent,
                  // autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2
                          )
                      ),
                      labelText: "Email",
                      fillColor: Colors.orangeAccent,
                      hoverColor: Colors.orangeAccent,
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                  ),
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.yellowAccent,
                  // autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: backgroundColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                              "Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CupertinoSlidingSegmentedControl<int>(
                            groupValue: groupValue,
                            thumbColor: Colors.yellowAccent,
                            padding: const EdgeInsets.all(8),
                            children:  {
                              0: buildSegment("Male"),
                              1: buildSegment("Female"),
                              2: buildSegment("Other")
                            },
                            onValueChanged: (groupValue){
                              setState(() {
                                this.groupValue = groupValue!;
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: size.height*.04,
                        ),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 120,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black87,
                                ),
                                onPressed: () async {
                                  // print(address);
                                  final user = UserModel(userId: "7407926060",email: emailController.text,number: numberController.text,name: nameController.text);
                                    await UserApi.createUser(user);
                                      // Get.toNamed(HomePage.id
                                      // );
                                },
                                child: const Text("Continue",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600
                                  ),
                                )),
                          ),
                        ),

                      ],
                    )
                ),
              ),

            ],
        ),
      ),
    );
  }
  Widget buildSegment(String text)=>Text(
      text,
      style: const TextStyle(
          color: Colors.black
      )
  );
}
// String address = "";
// String location = "Search";
// final LocationController locationController = Get.put(LocationController());
// File? image;
// Future pickImage(ImageSource imageType) async {
//   try{
//     var image = await ImagePicker().pickImage(source:ImageSource.gallery);
//     if (image==null) return;
//     final imageTemporary = File(image.path);
//     setState(() {
//       image = imageTemporary as XFile?;
//     });
//     Get.back();
//   }catch(error){
//     debugPrint(error.toString());
//   }
//
// }
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     await Geolocator.openLocationSettings();
//     return Future.error('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   return await Geolocator.getCurrentPosition();
// }
// Future<void> GetAddressFromLatLong(Position position) async {
//   List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
//   Placemark place = placemark[0];
//   address = "${place.name},${place.street},${place.postalCode}";
// }
// final LocationController yourLocation = Get.put(LocationController());
