import 'dart:async';
// import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyam_2_final/Helpers/request_helpers.dart';
import 'package:vyam_2_final/Home/home_page.dart';
import 'package:vyam_2_final/Home/icons/profileicon_icons.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
import 'package:vyam_2_final/golbal_variables.dart';

import '../../api/api.dart';

const String api = "AIzaSyBdpLJQN_y-VtLZ2oLwp8OEE5SlR8cHHcQ";
// core.GoogleMapsPlaces _places = core.GoogleMapsPlaces(apiKey: api);
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: api);

class LocInfo extends StatefulWidget {
  @override
  State<LocInfo> createState() => _LocInfoState();
}

class _LocInfoState extends State<LocInfo> {
  FocusNode myFocousNode = FocusNode();
  var data;
  bool isLoading = false;
  final Completer<GoogleMapController> _controller = Completer();
  // ln.Location location = ln.Location();
  late GoogleMapController mapcontroller;
  Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  myLocation() async {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(number)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        setState(() {
          data = documentSnapshot.data();
          // isLoading = false;
          locController.text = data != null ? data["address"] : "your Location";
        });
      }
    });
  }

  // bool isLoading = true;

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

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best
    );
  }

  String pin = "";
  String locality = "";
  String subLocality = "";
  String myaddress = "your location";
  var address = "";
  Future<void> GetAddressFromLatLong(Position position) async {

    try{
      List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      print(placemark);
      print(placemark[1]);
      address =
          "${place.name??""},"+"${place.subLocality??""}, ${place.locality??""}, ${place.subAdministrativeArea??""}, ${place.postalCode??""}";
      pin = "${place.postalCode}";
      locality = "${place.locality}";
      subLocality = "${place.subLocality}";
    }catch(e){

    }
  }

  Future<void> GetAddressFromGeoPoint(GeoPoint position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    print(placemark);
    print(placemark[1]);
    // var add = await Geocoder.local.findAddressesFromCoordinates(
    //     coordinates);
    address =
        "${place.name??""}, "+"${place.street??""}, ${place.locality??""}, ${place.subAdministrativeArea??""}, ${place.postalCode??""}";
    pin = "${place.postalCode}";
    locality = "${place.locality}";
    subLocality = "${place.subLocality}";
    print(pin);
  }

  bool showPlacessuggesstions = false;
  late List<PlacesApiHelperModel>? _list = [];

  TextEditingController locController = TextEditingController();
  // getUser()async{
  //   setState(() {
  //     locController.text =  data != null ?  data["address"] : "your Location";
  //   });
  // }

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
  void dispose() {
    // TODO: implement dispose
    locController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            child: const Center(
              child: LinearProgressIndicator(
                // color: Colors.amber,
                backgroundColor: Colors.white,
              ),
            ),
          )
        : Scaffold(
            // appBar: AppBar(
            //   centerTitle: true,
            //   leading: const Icon(Icons.location_on_outlined,color: Colors.black,),
            //   title: Transform(
            //     transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
            //     child: TextField(
            //       controller:locController,
            //       onChanged: (value) async {
            //         _list = await RequestHelper().getPlaces(query: value);
            //         setState(() {});
            //         if (value.isEmpty) {
            //           _list!.clear();
            //           setState(() {});
            //         }
            //       },
            //       decoration: const InputDecoration(
            //           hintText: 'Barakar, West Bengal',
            //           hintStyle: TextStyle(fontWeight: FontWeight.bold),
            //           // prefixIcon: Icon(Icons.search)
            //       ),
            //       onTap: () {
            //         setState(() {
            //
            //           FocusScope.of(context).unfocus();
            //           showPlacessuggesstions? showPlacessuggesstions =true:showPlacessuggesstions=false ;
            //           locController.clear();
            //         });
            //       },
            //     ),
            //   ),
            //   actions: [
            //     IconButton(
            //       icon: const Icon(
            //         Icons.edit,
            //         // HomeIcon.notification,
            //         color: Colors.black,
            //       ),
            //       onPressed: () {
            //         // print(number);
            //         FocusScope.of(context).unfocus();
            //         // Get.to(const NotificationDetails());
            //       },
            //     ),
            //   ],
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            // ),
            body: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: locController,
                          autofocus: false,
                          focusNode: myFocousNode,
                          onChanged: (value) async {
                            _list =
                                await RequestHelper().getPlaces(query: value);
                            setState(() {});
                            if (value.isEmpty) {
                              _list!.clear();
                              setState(() {
                                locController.text = value;
                              });
                            }
                          },
                          onTap: () {
                            setState(() {
                              showPlacessuggesstions
                                  ? showPlacessuggesstions = false
                                  : showPlacessuggesstions = true;
                              // test_controller.clear();
                              // locController.clear();
                              // print(locController.text);
                            });
                          },
                          onFieldSubmitted: (value) async {
                            FocusScope.of(context).unfocus();
                            print(value);
                            isLoading = true;
                            if (value.isEmpty) return;
                            final res = await RequestHelper()
                                .getCoordinatesFromAddresss(value);
                            // print("fhjkgfhjkgfhjkgfhjkgfhjkgfhjkgfhjkgfhjkg"+value);
                            setState(() {
                              GlobalUserLocation = value;
                              locController.text = value;
                            });
                            await GetAddressFromGeoPoint(
                                GeoPoint(res.latitude, res.longitude));

                            await FirebaseFirestore.instance
                                .collection('user_details')
                                .doc(number)
                                .update({
                              "location": GeoPoint(res.latitude, res.longitude),
                              // "lat": res.latitude,
                              // "long": res.longitude,
                              "address": value.trim(),
                              "pincode": pin,
                              "locality": locality,
                              "subLocality": subLocality,
                            });
                            Get.off(() => HomePage());
                          },
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Profileicon.location),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  locController.clear();
                                  FocusScope.of(context)
                                      .requestFocus(myFocousNode);
                                },
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              // border: InputBorde,
                              hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green),
                              hintMaxLines: 2,
                              hintText: 'Search your location here'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 60,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await myLocation();
                              // print(data);
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
                                "location": GeoPoint(
                                    position.latitude, position.longitude),
                                "address": address,
                                // "lat": position.latitude,
                                // "long": position.longitude,
                                "pincode": pin,
                                "locality": locality,
                                "subLocality": locality,
                                // "number": number
                              });
                              await Get.offAll(() => HomePage());
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
                                    const Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .6,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          'Use current location',
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
                        height: 15,
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //     FocusScope.of(context).unfocus();
                      //     String value = 'kolkata,salt-lake, sector2,700091';
                      //     print(value);
                      //     isLoading = true;
                      //     if (value.isEmpty) return;
                      //     final res = await RequestHelper()
                      //         .getCoordinatesFromAddresss(value);
                      //     setState(() {
                      //       GlobalUserLocation = value;
                      //       locController.text = value;
                      //     });
                      //     await GetAddressFromGeoPoint(
                      //         GeoPoint(res.latitude, res.longitude));
                      //
                      //     await FirebaseFirestore.instance
                      //         .collection('user_details')
                      //         .doc(number)
                      //         .update({
                      //       "location": GeoPoint(res.latitude, res.longitude),
                      //       // "lat": res.latitude,
                      //       // "long": res.longitude,
                      //       "address": value.trim(),
                      //       "pincode": pin,
                      //       "locality": locality,
                      //       "subLocality": subLocality,
                      //     });
                      //     Get.off(() => HomePage());
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8.0, right: 0),
                      //     child: Row(
                      //       children: [
                      //         const Text(
                      //           'kolkata,salt-lake, sector 2',
                      //           style: TextStyle(
                      //               fontFamily: 'Poppins',
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: 14,
                      //               color: Colors.black),
                      //         ),
                      //         const Spacer(),
                      //         Transform(
                      //           transform: Matrix4.rotationY(pi),
                      //           child: const Icon(
                      //             Icons.call_made_sharp,
                      //             size: 20,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Cities')
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          var document = snapshot.data.docs;
                          print(document);
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: document.length,
                            itemBuilder: ((context, index) {
                              return document.isNotEmpty
                                  ? Container(
                                      child: InkWell(
                                        onTap: () async {
                                          FocusScope.of(context).unfocus();
                                          String value =
                                              document[index]['Address'];
                                          print(value);
                                          isLoading = true;
                                          if (value.isEmpty) return;
                                          final res = await RequestHelper()
                                              .getCoordinatesFromAddresss(
                                                  value);
                                          setState(() {
                                            GlobalUserLocation = value;
                                            locController.text = value;
                                          });
                                          await GetAddressFromGeoPoint(GeoPoint(
                                              res.latitude, res.longitude));

                                          await FirebaseFirestore.instance
                                              .collection('user_details')
                                              .doc(number)
                                              .update({
                                            "location": GeoPoint(
                                                res.latitude, res.longitude),
                                            // "lat": res.latitude,
                                            // "long": res.longitude,
                                            "address": value.trim(),
                                            "pincode": pin,
                                            "locality": locality,
                                            "subLocality": subLocality,
                                          });
                                          Get.off(() => HomePage());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${document[index]['Address']}",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              const Spacer(),
                                              Transform(
                                                transform:
                                                    Matrix4.rotationY(pi),
                                                child: const Icon(
                                                  Icons.call_made_sharp,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            }),
                          );
                        },
                      )
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // InkWell(
                      //   onTap: () async {
                      //     FocusScope.of(context).unfocus();
                      //     String value = 'Asansol, West Bengal';
                      //     print(value);
                      //     isLoading = true;
                      //     if (value.isEmpty) return;
                      //     final res = await RequestHelper()
                      //         .getCoordinatesFromAddresss(value);
                      //     setState(() {
                      //       GlobalUserLocation = value;
                      //       locController.text = value;
                      //     });
                      //     await GetAddressFromGeoPoint(
                      //         GeoPoint(res.latitude, res.longitude));
                      //
                      //     await FirebaseFirestore.instance
                      //         .collection('user_details')
                      //         .doc(number)
                      //         .update({
                      //       "location": GeoPoint(res.latitude, res.longitude),
                      //       // "lat": res.latitude,
                      //       // "long": res.longitude,
                      //       "address": value.trim(),
                      //       "pincode": pin,
                      //       "locality": locality,
                      //       "subLocality": subLocality,
                      //     });
                      //     Get.off(() => HomePage());
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8.0, right: 0),
                      //     child: Row(
                      //       children: [
                      //         const Text(
                      //           'Asansol, West Bengal',
                      //           style: TextStyle(
                      //               fontFamily: 'Poppins',
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: 14,
                      //               color: Colors.black),
                      //         ),
                      //         const Spacer(),
                      //         Transform(
                      //           transform: Matrix4.rotationY(pi),
                      //           child: const Icon(
                      //             Icons.call_made_sharp,
                      //             size: 20,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // InkWell(
                      //   onTap: () async {
                      //     FocusScope.of(context).unfocus();
                      //     String value = 'Durgapur, West Bengal';
                      //     print(value);
                      //     isLoading = true;
                      //     if (value.isEmpty) return;
                      //     final res = await RequestHelper()
                      //         .getCoordinatesFromAddresss(value);
                      //     setState(() {
                      //       GlobalUserLocation = value;
                      //       locController.text = value;
                      //     });
                      //     await GetAddressFromGeoPoint(
                      //         GeoPoint(res.latitude, res.longitude));
                      //
                      //     await FirebaseFirestore.instance
                      //         .collection('user_details')
                      //         .doc(number)
                      //         .update({
                      //       "location": GeoPoint(res.latitude, res.longitude),
                      //       // "lat": res.latitude,
                      //       // "long": res.longitude,
                      //       "address": value.trim(),
                      //       "pincode": pin,
                      //       "locality": locality,
                      //       "subLocality": subLocality,
                      //     });
                      //     Get.off(() => HomePage());
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8.0, right: 0),
                      //     child: Row(
                      //       children: [
                      //         const Text(
                      //           'Durgapur, West Bengal',
                      //           style: TextStyle(
                      //               fontFamily: 'Poppins',
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: 14,
                      //               color: Colors.black),
                      //         ),
                      //         const Spacer(),
                      //         Transform(
                      //           transform: Matrix4.rotationY(pi),
                      //           child: const Icon(
                      //             Icons.call_made_sharp,
                      //             size: 20,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  _list != null && _list!.isNotEmpty
                      ? Positioned(
                          top: 60,
                          child: Container(
                            height: 500,
                            width: MediaQuery.of(context).size.width * .95,
                            color: Colors.white.withOpacity(.95),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: _list == null
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _list?.length,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        title: Text(_list![index].mainText!),
                                        subtitle:
                                            Text(_list![index].secondaryText!),
                                        onTap: () async {
                                          isLoading = true;
                                          final res = await RequestHelper()
                                              .getCoordinatesFromAddresss(
                                                  _list![index].mainText!);
                                          print(res.latitude);
                                          print(res.longitude);
                                          await GetAddressFromGeoPoint(GeoPoint(
                                              res.latitude, res.longitude));
                                          // _gotoLocation(res.latitude, res.longitude);
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            locController.text =
                                                _list![index].mainText!;
                                            GlobalUserLocation =
                                                _list![index].mainText!;
                                            showPlacessuggesstions = false;
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('user_details')
                                              .doc(number)
                                              .update({
                                            "location": GeoPoint(
                                                res.latitude, res.longitude),
                                            // "lat": res.latitude,
                                            // "long": res.longitude,
                                            "address": _list![index].mainText!,
                                            "pincode": pin,
                                            "locality": locality,
                                            "subLocality": subLocality,
                                          });
                                          Get.off(() => HomePage());
                                        },
                                      );
                                    }),
                                  ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
    )));
  }
}
