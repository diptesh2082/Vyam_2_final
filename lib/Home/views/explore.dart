import 'dart:async';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vyam_2_final/Helpers/request_helpers.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';
import 'package:vyam_2_final/Home/views/first_home.dart';
// import 'package:vyam_2_final/Home/views/scratch_map.dart';
import 'package:vyam_2_final/api/api.dart';
import '../../controllers/gym_controller.dart';
import 'package:location/location.dart' as ln;

const String api = "AIzaSyBdpLJQN_y-VtLZ2oLwp8OEE5SlR8cHHcQ";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: api);

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(23.7217038, 86.7921423),
    zoom: 11.5,
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
    final MarkerId markerId =   MarkerId(markerIdVal);
    final Marker marker =  Marker(
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
  var _currentItem =0;

  var doc = Get.arguments;

  @override
  void initState() {
    // print(location.latitude);
    getMarkerData();
    if (doc != null) {
      _gotoLocation(doc["location"].latitude, doc["location"].longitude);
    }
    super.initState();
  }

  @override
  dispose() {
    // controller.dispose();
    // _controller.dispose();
    // _initialCameraPosition.dispose();
    super.dispose();
  }

splashLocation(latitude,longitude)async{
    await   _gotoLocation(latitude,longitude);
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
  TextEditingController test_controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              // markers: ,
              mapType: MapType.terrain,
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: true,

              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
                markers: Set<Marker>.of(markers.values),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 18.0),
                // color: Colors.white.withOpacity(0),
                height: 136.0,
                // width: ,
                child: StreamBuilder(
                    stream:  FirebaseFirestore.instance
                        .collection("product_details")
                    .where("pincode",isEqualTo: GlobalUserLocation.toString())
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
                      return document.isNotEmpty
                          ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: document.length,
                        itemBuilder: (context, index)  {
                          // print(index);
                          return VisibilityDetector(
                            key: Key(index.toString()),
                            onVisibilityChanged: (VisibilityInfo info)async {
                              // print(index.toInt());

                              // _currentItem= await index.toInt();
                              print(info.visibleFraction);
                              if (info.visibleFraction >0.81)
                                // setState(() {
                                _currentItem = index.toInt();
                              print(_currentItem);
                              splashLocation(document[_currentItem]["location"].latitude, document[_currentItem]["location"].longitude);

                                // });
                              // setState(()asy {
                              //   _gotoLocation(document[info.visibleFraction.toInt()]["location"].latitude, document[info.visibleFraction.toInt()]["location"].longitude);
                              //
                              // });
                            },
                            child: SizedBox(
                              width: 300,
                              child: FittedBox(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(()=>GymDetails(),
                                        arguments: {
                                          "id": document[index].id,
                                          "location": document[index]
                                          ["location"],
                                          "name": document[index]
                                          ["name"],
                                          "docs": document[index],
                                        }
                                    );
                                    // _gotoLocation(location.latitude, location.longitude);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    elevation: 8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        _boxes(
                                            document[index]["display_picture"],
                                            document[index]["name"],
                                            document[index]["location"],
                                            document[index]["address"],
                                            document[index]["rating"].toString(),
                                            document[index]["branch"],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return const Divider(
                          );
                        },
                      ) : Text(
                        "No results found",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),
                      );
                    }),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Positioned(
                // top: 9,
                // left: 1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*.93,
                      height: 51,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        controller:test_controller,
                        autofocus: false,
                        onChanged: (value) async {
                          _list = await RequestHelper().getPlaces(query: value);
                          setState(() {});
                          if (value.isEmpty) {
                            _list!.clear();
                            setState(() {});
                          }
                        },
                        onSubmitted: (value){
                          FocusScope.of(context).unfocus();
                          setState(() {
                            showPlacessuggesstions? showPlacessuggesstions =true:showPlacessuggesstions=false ;
                          });

                        },
                        decoration: const InputDecoration(
                            hintText: 'Search places',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.search)),
                        onTap: () {
                          setState(() {

                            FocusScope.of(context).unfocus();
                            showPlacessuggesstions? showPlacessuggesstions =false:showPlacessuggesstions=true ;
                            test_controller.clear();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _list!=null && _list!.isNotEmpty
                ? Positioned(
              top: 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.9),
              padding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: _list==null?Container()
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
                    child:IconButton(
                      icon: const Icon(
                        Icons.my_location_outlined
                      ),
                        // child: Colors.grey[100]!.withOpacity(.5),
                      autofocus: false,
                        // key: ElevatedButton.styleFrom(
                        //   primary: Colors.white.withOpacity(.0)
                        // ),
                        onPressed: ()async{
                          final pos=await location.getLocation();
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // floatingActionButton: SizedBox(
      //   height: 33,
      //   width: 27,
      //   child: FloatingActionButton.extended(
      //     // backgroundColor: Colors.white,
      //     elevation: 15,
      //     splashColor: Colors.amber,
      //     backgroundColor: const Color(0xff292F3D),
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)
      //     ),
      //     onPressed: () {
      //       FocusScope.of(context).unfocus();
      //     },
      //     label: Text(
      //       "",
      //       // "Explore Packages",
      //       style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
      //           color: Colors.white
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _boxes(
      String _image,
      String name,
      GeoPoint location,
      String address,
      String review,
      String gym_address
      ) {
    // splashLocation(location.latitude, location.longitude);
    return FittedBox(
      child: GestureDetector(
        // onHorizontalDragStart: (){
        //   _gotoLocation(location.latitude, location.longitude);
        // },

        child: SizedBox(
          width: 550,
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
                      width: 200,
                      height: 200,
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 30),
                        child: myDetailsContainer1(
                            name,
                            '${gym_address}',
                            address,
                            review),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(
      String name, String location, String address, String review) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              CupertinoIcons.location_solid,
              color: Colors.black,
            ),
            Text(
              location,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          width: 200,
          child: Text(
            address,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              CupertinoIcons.star_fill,
              color: Colors.amber,
            ),
            Text(
              review,
              style: const TextStyle(
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
}