import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:vyam_2_final/Helpers/request_helpers.dart';
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
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
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
    FirebaseFirestore.instance
        .collection('product_details')
        .get()
        .catchError((e) {
      print("Error: " + e.toString());
    }).then((myMockData) {
      if (myMockData.docs.isNotEmpty) {
        for (int i = 0; i < myMockData.docs.length; i++) {
          initMarker(myMockData.docs[i].data(), myMockData.docs[i].id);
        }
      }
    });
  }

  var doc = Get.arguments;

  @override
  void initState() {
    print(address2.toString());
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


  late List<PlacesApiHelperModel>? _list = [];

  bool showPlacessuggesstions = true;
  TextEditingController test_controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
          child: TextField(
            controller:test_controller,
            onChanged: (value) async {
              _list = await RequestHelper().getPlaces(query: value);
              setState(() {});
              if (value.isEmpty) {
                _list!.clear();
                setState(() {});
              }
            },
            decoration: const InputDecoration(
                hintText: 'Barakar, West Bengal',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.search)),
            onTap: () {
              setState(() {

                FocusScope.of(context).unfocus();
                showPlacessuggesstions? showPlacessuggesstions =true:showPlacessuggesstions=false ;
                test_controller.clear();
              });
            },
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _initialCameraPosition,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            //   markers: Set<Marker>.of(markers.values),
          ),
          showPlacessuggesstions
              ? Container(
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
                    print(res.latitude);
                    print(res.longitude);
                    _gotoLocation(res.latitude, res.longitude);
                    FocusScope.of(context).unfocus();
                    setState(() {
                      showPlacessuggesstions = false;
                    });
                  },
                );
              }),
            ),
          )
              : Container(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 150.0,
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
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          elevation: 8,
                          child: Row(
                            children: [
                              _boxes(
                                  document[index]["display_picture"],
                                  document[index]["name"],
                                  document[index]["location"],
                                  document[index]["address"],
                                  document[index]["rating"].toString()
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const Divider();
                      },
                    )
                        : const Text(
                      "No results found",
                      style: TextStyle(fontSize: 24),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxes(
      String _image,
      String name,
      GeoPoint location,
      String address,
      String review,
      ) {
    return GestureDetector(
      onTap: () {
        // _gotoLocation(lat, long);
      },
      child: FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
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
                        '${location.latitude}, ${location.longitude}',
                        address,
                        review),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget myDetailsContainer1(
      String name, String location, String address, String review) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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