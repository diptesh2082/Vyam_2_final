import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vyam_2_final/Home/profile/profile_page.dart';
import 'package:vyam_2_final/api/api.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  static String id = "/Profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  DocumentReference sightingRef =
  FirebaseFirestore.instance.collection("sightings").doc();

  final db = FirebaseFirestore.instance;
  String id = "7407926060";
  // UserId userId = UserId();
  final picker = ImagePicker();
  // ignore: unused_field
  late File _image;

  // for selecting images from device
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = (await picker.getImage(
        source: ImageSource.gallery,
      ))!;
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = (await picker.getImage(
        source: ImageSource.camera,
      ))!;
    }

    setState(() {
      // ignore: unnecessary_null_comparison
      if (pickedFile != null) {
        _image = pickedFile as File;
        //_image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  saveData()async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      await db.collection("user_details").doc(id).update({
        'email': emailTextEditingController.text,
        'name': nameTextEditingController.text,
        'number': phoneTextEditingController.text
      });
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
      body: Padding(
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
                  child: CircleAvatar(
                    backgroundColor: Colors.yellowAccent,
                    child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        getImage(true);
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 70,
                        color: Colors.black87,
                      ),
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
                    hintText: 'Jessica James',
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
                    hintText: 'alma.lawson@example.com',
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
                  validator: (val) {
                    if (val!.isEmpty || val.length < 10) {
                      return "Please Provide valid Phone number";
                    } else {
                      return null;
                    }
                  },
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
                    await saveData();
                    Get.to(()=>ProfilePart());
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontWeight: FontWeight.bold),
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