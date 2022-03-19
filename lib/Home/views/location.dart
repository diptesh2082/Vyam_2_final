import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';

class LocInfo extends StatefulWidget {
  @override
  State<LocInfo> createState() => _LocInfoState();
}

class _LocInfoState extends State<LocInfo> {
var data;
  myLocation() async {
   await FirebaseFirestore.instance
        .collection('user_details')
        .doc(number)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        setState(() {
         data=documentSnapshot.data();
         isLoading=false;
        });

      }
    });
  }
 bool  isLoading= true;

  getAddressPin(var pin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getAddress();
    sharedPreferences.setString("pin", pin.toString());
    getAddress();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
  String pin = "";
  String locality = "";
  String subLocality = "";
  String myaddress = "your location";
  var address = "";
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    address = "${place.subLocality},${place.locality},${place.name},${place.street},${place.postalCode}";
    pin = "${place.postalCode}";
    locality = "${place.locality}";
    subLocality = "${place.subLocality}";
  }
TextEditingController locController=TextEditingController();

  @override
  void initState() {
    myLocation();
    setState(() {
      myaddress = myaddress;
      address = address;
      pin = pin;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      locController.text=data!=null ? data["address"]:"your Location";
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      SizedBox(height: 9,),
       Padding(
          padding: EdgeInsets.only(left: 0,right: 0),
          child: TextField(

            controller: locController,
              autofocus: false,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        suffixIcon: const Icon(Icons.edit_outlined),
                        // border: InputBorde,
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                        hintMaxLines: 2,
                        hintText: 'Use current location'),
                  ),
        ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 60,
                child: GestureDetector(
                  onTap: () async {
                    myLocation();
                    print(data);
                    Position position = await _determinePosition();
                    await GetAddressFromLatLong(position);
                    // await UserApi.updateUserAddress(
                    //     address, [position.latitude, position.longitude], pin
                    // );
                    await getAddressPin(pin);
                    setState(() {
                      myaddress = myaddress;
                      address = address;
                      pin = pin;
                    });
                    await FirebaseFirestore.instance
                        .collection("user_details")
                        .doc(number)
                        .update({
                      "address": address,
                      "lat": position.latitude,
                      "long": position.longitude,
                      "pincode": pin,
                      "locality": locality,
                      "subLocality": locality,
                      "number": number
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                          Container(
                            height: 39,
                            width: 60,

                            child: const Icon(
                                    Icons.my_location_outlined,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey[200],
                            ),
                          ),
                            const Spacer(
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*.6,
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text('Use current location',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green),
                                      ),
                                    ),
                                // child: const TextField(
                                //   autofocus: false,
                                //     style: TextStyle(
                                //       fontSize: 12,
                                //       fontFamily: 'Poppins',
                                //       fontWeight: FontWeight.w500,
                                //     ),
                                //     decoration: InputDecoration(
                                //
                                //             // border: InputBorde,
                                //             hintStyle: TextStyle(
                                //                 fontSize: 12,
                                //                 fontFamily: 'Poppins',
                                //                 fontWeight: FontWeight.w500,
                                //                 color: Colors.green),
                                //             hintMaxLines: 2,
                                //             hintText: 'Use current location'),
                                //       )
                                ),
                            const SizedBox(
                              width: 15,
                            ),

                          ],
                        ),
                      // TextField(
                        //   // autofocus: true,
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     fontFamily: 'Poppins',
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        //   // controller: search,
                        //   maxLines: 3,
                        //   decoration: InputDecoration(
                        //       prefixIcon: Icon(
                        //         Icons.my_location_outlined,
                        //         color: Colors.green,
                        //         size: 20,
                        //       ),
                        //       border: InputBorder.none,
                        //       hintStyle: TextStyle(
                        //           fontSize: 12,
                        //           fontFamily: 'Poppins',
                        //           fontWeight: FontWeight.w500,
                        //           color: Colors.green),
                        //       hintMaxLines: 2,
                        //       hintText: 'Use current location'),
                        // )
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Cities',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 0),
              child: Row(
                children: [
                  const Text(
                    'Kolkata, West Bengal',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Transform(
                    transform: Matrix4.rotationY(pi),
                    child: const Icon(
                      Icons.call_made_sharp,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 0),
              child: Row(
                children: [
                  const Text(
                    'Asansol, West Bengal',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Transform(
                    transform: Matrix4.rotationY(pi),
                    child: const Icon(
                      Icons.call_made_sharp,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 0),
              child: Row(
                children: [
                  const Text(
                    'Durgapur, West Bengal',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Transform(
                    transform: Matrix4.rotationY(pi),
                    child: const Icon(
                      Icons.call_made_sharp,
                      size: 20,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}