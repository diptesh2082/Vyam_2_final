import 'dart:async';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vyam_2_final/Helpers/request_helpers.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/Home/icons/profileicon_icons.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/golbal_variables.dart';
import '../../controllers/gym_controller.dart';
import 'package:location/location.dart' as ln;

const String api = "AIzaSyC1HHe1ulw07w6Cz-UirhV5d2Pm_GUJW38";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: api);

class Exploreia extends StatefulWidget {
  const Exploreia({Key? key}) : super(key: key);

  @override
  State<Exploreia> createState() => _ExploreiaState();
}

var lat;
// =GlobalUserData["location"].latitude;
var long;

// = GlobalUserData["location"].longitude;
class _ExploreiaState extends State<Exploreia> {
  static final _initialCameraPosition = CameraPosition(
    target: LatLng(lat, long),
    zoom: 12,
  );

  final Completer<GoogleMapController> _controller = Completer();
  final GymController controller = Get.put(GymController());
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<DocumentSnapshot> document = [];
  bool isLoading = false;

  String searchGymName = '';
  GymDetailApi gymDetailApi = GymDetailApi();

  ln.Location location = ln.Location();

  late GoogleMapController mapcontroller;
  Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _animateToUser() async {
    var pos = await location.getLocation();
    // print(pos.l);

    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude!, pos.longitude!),
      zoom: 17.0,
    )));
  }

  Stream nearbyComp() async* {
    var pos = await location.getLocation();

    GeoFirePoint point =
        geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
    final CollectionReference users = firestore.collection("product_details");

    double radius = 10;
    String field = 'location';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: users)
        .within(center: point, radius: radius, field: field, strictMode: true);

    yield stream;
  }

  void initMarker(specify, specifyId) async {
    var markerIdVal = await specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: 'Gym', snippet: specify['name']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  // if (!serviceEnabled) {
  // await Geolocator.openLocationSettings();
  // return Future.error('Location services are disabled.');
  // }

  getMarkerData() async {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('product_details')
        .get()
        .catchError((e) {
      print("Error: " + e.toString());
    }).then((myMockData) {
      if (myMockData.docs.isNotEmpty) {
        for (int i = 0; i < myMockData.docs.length; i++) {
          // print(myMockData.docs[i].id);
          initMarker(myMockData.docs[i].data(), myMockData.docs[i].id);
        }
      }
    });
    FocusScope.of(context).unfocus();
  }

  var _currentItem = 0;

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

  var doc = Get.arguments;
  getEverything() async {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    // Position position = await _determinePosition();
    // await GetAddressFromLatLong(position);
    // if(mounted) {
    //   setState(() {
    //     myaddress = myaddress;
    //     address = address;
    //     pin = pin;
    //   });
    // }
    // await FirebaseFirestore.instance
    //     .collection("user_details")
    //     .doc(number)
    //     .update({
    //   "location": GeoPoint(position.latitude, position.longitude),
    //   "address": address,
    //   // "lat": position.latitude,
    //   // "long": position.longitude,
    //   "pincode": pin,
    //   "locality": locality,
    //   "subLocality": locality,
    //   // "number": number
    // });
    // setState(() {
    //   location_service =  true;
    // });

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("service status $serviceEnabled");
    if (!serviceEnabled || GlobalUserData["address"] == "") {
      setState(() {
        isLoading = true;
        location_service = false;
      });
      showDialog(
        // barrierDismissible: false,
        useSafeArea: true,
        useRootNavigator: true,
        // barrierLabel: "",
        context: context,
        // barrierDismissible: location_service,
        builder: (context) => Container(
          height: 600,
          child: WillPopScope(
            onWillPop: () async {
              print("hola hola behen ka lola");
                // await FirebaseFirestore.instance
                //     .collection("user_details")
                //     .doc(number)
                //     .update({
                //   "location": GeoPoint(position.latitude, position.longitude),
                //   "address": address,
                //   // "lat": position.latitude,
                //   // "long": position.longitude,
                //   "pincode": pin,
                //   "locality": locality,
                //   "subLocality": locality,
                //   // "number": number
                // });

              var Enabled = await Geolocator.isLocationServiceEnabled();
              if (Enabled){
                Position position = await Geolocator.getCurrentPosition();
                await GetAddressFromLatLong(position);
                await FirebaseFirestore.instance
                    .collection("user_details")
                    .doc(number)
                    .update({
                  "location": GeoPoint(position.latitude, position.longitude),
                  "address": address,
                  // "lat": position.latitude,
                  // "long": position.longitude,
                  "pincode": pin,
                  "locality": locality,
                  "subLocality": locality,
                  // "number": number
                });

              }
              setState(() {
                isLoading=false;
              });

              // try {
              //   Position position = await _determinePosition();
              //   await GetAddressFromLatLong(position);
              //   if (mounted) {
              //     setState(() {
              //       myaddress = myaddress;
              //       address = address;
              //       pin = pin;
              //     });
              //   }

              //   setState(() {
              //     location_service = true;
              //     // isLoading=false;
              //   });
              // } catch (e) {
              //   getEverything();
              // }
              //
              // if(location) {
              //   setState(() {
              //   location_service =  true;
              // });
              // }
              return true;
            },
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              content: SizedBox(
                height: 220,
                width: 180,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/Group188.png",
                      height: 50,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Enable device location",
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        "Please enable location for accurate location and nearest gyms",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 11, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset("assets/icons/icons8-approval.gif",
                          //   height: 70,
                          //   width: 70,
                          // ),

                          // const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () async {

                              Position position = await Geolocator.getCurrentPosition();
                              await GetAddressFromLatLong(position);
                              await FirebaseFirestore.instance
                                  .collection("user_details")
                                  .doc(number)
                                  .update({
                                "location": GeoPoint(position.latitude, position.longitude),
                                "address": address,
                                // "lat": position.latitude,
                                // "long": position.longitude,
                                "pincode": pin,
                                "locality": locality,
                                "subLocality": locality,
                                // "number": number
                              });
                             // await runRun();
                              if (mounted) {
                                setState(() {
                                  myaddress = myaddress;
                                  address = address;
                                  pin = pin;
                                  isLoading=false;
                                });
                              }
                              Get.back();
                              setState(() {
                                location_service = true;
                              });

                              // await Get.offAll(()=>HomePage());
                            },
                            child: Container(
                                height: 51,
                                width: 145,
                                decoration: BoxDecoration(
                                    color: HexColor("292F3D"),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3, right: 3, top: 2, bottom: 2),
                                  child: Center(
                                    child: Text(
                                      "Enable Location",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("FFFFFF")),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // }
  }

  @override
  void initState() {
    // print(location.latitude);
    getEverything();

    setState(() {
      // });
      lat = GlobalUserData["location"].latitude;
      long = GlobalUserData["location"].longitude;
    });

    getMarkerData();
    if (doc != null) {
      _gotoLocation(doc["location"].latitude, doc["location"].longitude);
    }
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    // _controller.dispose();
    // _initialCameraPosition.dispose();
    super.dispose();
  }

  splashLocation(latitude, longitude) async {
    await _gotoLocation(latitude, longitude);
  }

  // void _currentLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   LocationData currentLocation;
  //   var location =  Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //   } on Exception {
  //     currentLocation = null;
  //   }
  //
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       bearing: 0,
  //       target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //       zoom: 17.0,
  //     ),
  //   ));
  // }

  late List<PlacesApiHelperModel>? _list = [];

  bool showPlacessuggesstions = false;
  TextEditingController test_controller = TextEditingController();
  int focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  GlobalKey<ScrollSnapListState> listKey = GlobalKey();
  void _onItemFocus(int index) {
    focusedIndex = index;
  }

  Widget buildListItem(BuildContext context, int index) {
    // return ListView.separated(
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemCount: document.length,
    //   itemBuilder: (context, index) {

        return isLoading?
            Center(child: CircularProgressIndicator(),)
        :VisibilityDetector(
          key: Key(index.toString()),
          onVisibilityChanged: (VisibilityInfo info) async {
            print(info.visibleFraction);
            if (info.visibleFraction ==1) _currentItem = index.toInt();
            // listKey=index.toInt();
            print(_currentItem);
            splashLocation(document[_currentItem]["location"].latitude,
                document[_currentItem]["location"].longitude);
          },
          child: FittedBox(
            child: GestureDetector(
              onTap: () {
                Get.to(() => GymDetails(), arguments: {
                  "id": document[index].id,
                  "location": document[index]["location"],
                  "name": document[index]["name"],
                  "docs": document[index],
                });
                sslKey.currentState!.focusToItem(index);
                // _gotoLocation(location.latitude, location.longitude);
              },
              child: Card(
                // key: sslKey,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(width: 15,),
                    _boxes(
                      document[index]["display_picture"],
                      document[index]["name"],
                      document[index]["location"],
                      document[index]["address"],
                      document[index]["rating"].toString(),
                      document[index]["branch"],
                    ),
                    SizedBox(width: 15,)
                  ],
                ),
              ),
            ),
          ),
        );
      // },
    //   separatorBuilder: (BuildContext context, int index) {
    //     return Container(
    //       width: 8,
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    // getEverything();
    // if(location_service)
    return Scaffold(
      // appBar: AppBar(
      //   title: Transform(
      //     transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
      //     child: SizedBox(
      //       child: TextField(
      //         controller:test_controller,
      //         autofocus: false,
      //         onChanged: (value) async {
      //           _list = await RequestHelper().getPlaces(query: value);
      //           setState(() {});
      //           if (value.isEmpty) {
      //             _list!.clear();
      //             setState(() {});
      //           }
      //         },
      //         onSubmitted: (value){
      //           FocusScope.of(context).unfocus();
      //           setState(() {
      //             showPlacessuggesstions? showPlacessuggesstions =true:showPlacessuggesstions=false ;
      //           });
      //
      //         },
      //         decoration: const InputDecoration(
      //             hintText: 'Search places',
      //             hintStyle: TextStyle(fontWeight: FontWeight.bold),
      //             prefixIcon: Icon(Icons.search)),
      //         onTap: () {
      //           setState(() {
      //
      //             FocusScope.of(context).unfocus();
      //             showPlacessuggesstions? showPlacessuggesstions =false:showPlacessuggesstions=true ;
      //             test_controller.clear();
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Stack(
          children: [
            // if(location_service==true)
            GoogleMap(
              // markers: ,
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: LatLng(GlobalUserData["location"].latitude!,
                    GlobalUserData["location"].longitude!),
                zoom: 10,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: true,

              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(markers.values),
            ),
            GlobalUserData["address"] != ""
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // padding: const EdgeInsets.only(left: 10),
                      // margin: const EdgeInsets.symmetric(vertical: 18.0),
                      // color: Colors.white.withOpacity(0),
                      height: 136.0,
                      width: 500,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("product_details")
                              .where("locality".toLowerCase(),
                                  isEqualTo:
                                      GlobalUserData["locality"].toLowerCase())
                              .orderBy("location")
                              .snapshots(),
                          builder: (context, AsyncSnapshot streamSnapshot) {
                            if (streamSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            document = streamSnapshot.data.docs;
                            // document = document.where((element) {
                            //   return element
                            //       .get('pincode')
                            //       .toString()
                            //   // .toLowerCase()
                            //       .contains(address2.toString());
                            // }).toList();
                            // if (searchGymName.isNotEmpty) {
                            //   document = document.where((element) {
                            //     return element
                            //         .get('name')
                            //         .toString()
                            //         .toLowerCase()
                            //         .contains(searchGymName.toLowerCase());
                            //   }).toList();
                            // }
                            var d=document.length;
                            return document.isNotEmpty
                                ? Container(
                              width:MediaQuery.of(context).size.width ,
                                  child: ScrollSnapList(
                                      margin: EdgeInsets.symmetric(horizontal: 00),
                                      onItemFocus: _onItemFocus,
                                      itemCount: d,
                                      key: sslKey,
                                      // dynamicItemSize: true,
                                    listViewKey: listKey,
                                      itemBuilder: buildListItem,
                              // reverse: true,
                                      itemSize: 310,
                                    ),
                                )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 30),
                                    child: Text(
                                      "No Fitness Option Available Here",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  );
                          }),
                    ),
                  )
                : SizedBox(),
            Positioned(
              // top: 9,
              // left: 1,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          // width: MediaQuery.of(context).size.width * .90,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: test_controller,
                            autofocus: false,
                            onChanged: (value) async {
                              if (value.length == 0) {
                                // setState(() {
                                FocusScope.of(context).unfocus();
                              }
                              // });
                              _list =
                                  await RequestHelper().getPlaces(query: value);
                              setState(() {});
                              if (value.isEmpty) {
                                _list!.clear();
                                setState(() {});
                              }
                            },
                            onSubmitted: (value) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                showPlacessuggesstions = false;
                                _list!.clear();
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: 'Search places',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Profileicon.search)),
                            onTap: () {
                              setState(() {
                                _list!.clear();
                                FocusScope.of(context).unfocus();
                                showPlacessuggesstions
                                    ? showPlacessuggesstions = false
                                    : showPlacessuggesstions = true;
                                test_controller.clear();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _list != null && _list!.isNotEmpty
                ? Positioned(
                    top: 76,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white.withOpacity(0.9),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: _list == null
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _list!.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  title: Text(_list![index].mainText!),
                                  subtitle: Text(_list![index].secondaryText!),
                                  onTap: () async {
                                    final res = await RequestHelper()
                                        .getCoordinatesFromAddresss(
                                            _list![index].mainText!);
                                    // print(res.latitude);
                                    // print(res.longitude);
                                    _gotoLocation(res.latitude, res.longitude);
                                    FocusScope.of(context).unfocus();
                                    _list!.clear();
                                    setState(() {
                                      // _list==null;

                                      showPlacessuggesstions = false;
                                    });
                                  },
                                );
                              }),
                            ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
                right: 6,
                bottom: 166,
                child: FittedBox(
                  child: SizedBox(
                    // width: 40,
                    child: IconButton(
                      icon: const Icon(Icons.my_location_outlined),
                      // child: Colors.grey[100]!.withOpacity(.5),
                      autofocus: false,
                      // key: ElevatedButton.styleFrom(
                      //   primary: Colors.white.withOpacity(.0)
                      // ),
                      onPressed: () async {
                        final pos = await location.getLocation();
                        _gotoLocation(pos.latitude!, pos.longitude!);
                      },
                      // child: Center(
                      //   child: const Icon(Icons.my_location_outlined
                      //   ),
                      // )
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, String name, GeoPoint location, String address,
      String review, String gym_address) {
    // splashLocation(location.latitude, location.longitude);
    return FittedBox(
      child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.black87,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 260,
                  height: 230,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: _image,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, right: 0),
                    child: myDetailsContainer1(
                        name, '${gym_address}', address, review),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget myDetailsContainer1(
      String name, String location, String address, String review) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Icon(
              CupertinoIcons.location_solid,
              color: Colors.black,
            ),
            Text(
              location,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          width: 210,
          child: Text(
            address,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              CupertinoIcons.star_fill,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              review,
              style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
    )));
  }
  runRun()async{
    setState(() {
      isLoading=true;
    });
    Position position = await _determinePosition();
    // await GetAddressFromLatLong(position);
    // await FirebaseFirestore.instance
    //     .collection("user_details")
    //     .doc(number)
    //     .update({
    //   "location": GeoPoint(
    //       position.latitude, position.longitude),
    //   "address": address,
    //   // "lat": position.latitude,
    //   // "long": position.longitude,
    //   "pincode": pin,
    //   "locality": locality,
    //   "subLocality": locality,
    //   // "number": number
    // });
  }
}
