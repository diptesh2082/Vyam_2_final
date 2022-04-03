import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vyam_2_final/Home/profile/profile_page.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  static String id = "/Profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController = TextEditingController(text: Get.arguments["name"]);

  TextEditingController emailTextEditingController = TextEditingController(text: Get.arguments["email"]);

  TextEditingController phoneTextEditingController = TextEditingController(text: Get.arguments["number"]);

  DocumentReference sightingRef =
  FirebaseFirestore.instance.collection("sightings").doc();
  var imageUrl=Get.arguments["imageUrl"];
  var gender=Get.arguments["gender"];
  bool selected=false;
  bool isLoading=false;
  final db = FirebaseFirestore.instance;
  String id = number;
  // UserId userId = UserId();
  // final picker = ImagePicker();
  // ignore: unused_field
  File? _image;

  File? image;
  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 60
      );
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Faild to pick image: $e");
    }

  }

  // for selecting images from device
  // Future getImage(bool gallery) async {
  //   ImagePicker picker = ImagePicker();
  //   PickedFile pickedFile;
  //   // Let user select photo from gallery
  //   if (gallery) {
  //     pickedFile = (await picker.getImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 50
  //     ))!;
  //   }
  //   // Otherwise open camera to get new photo
  //   else {
  //     pickedFile = (await picker.getImage(
  //       source: ImageSource.camera,
  //     ))!;
  //   }
  //
  //   setState(() {
  //     // ignore: unnecessary_null_comparison
  //     if (pickedFile != null) {
  //       _image = pickedFile as File;
  //       //_image = File(pickedFile.path); // Use if you only need a single picture
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  saveData()async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      final ref =  FirebaseStorage.instance.ref().child("user_images").child(number+".jpg");
      await ref.putFile(image!);
      final url = await ref.getDownloadURL();
      await db.collection("user_details").doc(id).update({
        'email': emailTextEditingController.text,
        'name': nameTextEditingController.text,
        // 'number': phoneTextEditingController.text,
        "image": url
      });
      setState(() {
        imageUrl=url;
        // isLoading=false;
      });
      // print(imageUrl);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading?const Center(
        child: CircularProgressIndicator(),
      )
          :Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child:GestureDetector(
                    onTap: (){
                      setState(() {
                        selected=true;
                      });
                      pickImage();
                    },
                    child: Stack(children: [
                      imageUrl==""?
                      CircleAvatar(
                        radius: 51,
                        backgroundColor: Colors.white,
                        // MediaQuery.of(context).size.width * 0.3,
                        child: image != null ? ClipOval(
                          child: Image.file(image !,
                            height: 150,
                            width: 150,
                          ),
                        ): const Icon(Icons.camera_alt_outlined,
                          size: 40,
                        ),
                        // decoration: const BoxDecoration(
                        //     shape: BoxShape/.circle, color: Colors.white)
                      ):
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(imageUrl),
                        radius: 51,
                      )
                      ,
                      // if (imageUrl == "")
                      // CircleAvatar(
                      //   // backgroundImage: ,
                      //   radius: 51,
                      //
                      //   backgroundColor: Colors.white,
                      //   // MediaQuery.of(context).size.width * 0.3,
                      //   backgroundImage:  gender.toLowerCase()=="male"?const AssetImage("assets/Illustrations/Avatarmale.png"):const AssetImage("assets/Illustrations/Avatar.png"),
                      // ),
                      // selected? CircleAvatar(
                      //   // backgroundImage: ,
                      //   radius: 60,
                      //   backgroundImage: FileImage(image !,
                      //   )
                      //
                      //   // child:
                      // ) :CachedNetworkImage( imageUrl: imageUrl,),
                      // Positioned(
                        // top: 0,                                  //MediaQuery.of(context).size.height * 0.052,
                      //   bottom: 14.5,
                      //   // right: 20,
                      //   left: 32.5,
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 0.3,
                      //     child: const Icon(
                      //       Icons.add,
                      //       size: 21,
                      //     ),
                      //     //color: Colors.amber,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: Colors.red.shade400,
                      //     ),
                      //   ),
                      // )
                    ]
                  ),
                  ),

                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty || val.length < 2) {
                      return "Please Provide valid Username";
                    } else {
                      return null;
                    }
                  },
                  controller: nameTextEditingController,
                  decoration: const InputDecoration(
                    hintText: 'name',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                        ? null
                        : "Please Provide valid correct Email";
                  },
                  controller: emailTextEditingController,
                  decoration: const InputDecoration(
                    hintText: 'email@example.com',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Phone',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  // validator: (val) {
                  //   if (val!.isEmpty || val.length < 10) {
                  //     return "Please Provide valid Phone number";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  readOnly: true,
                  controller: phoneTextEditingController,
                  decoration: const InputDecoration(
                    hintText: '1200-112-304',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {

                    setState(() {
                      isLoading=true;

                    });
                    await saveData();
                    Get.back();
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size(150, 45),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}