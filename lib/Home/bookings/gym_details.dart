import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:vyam_2_final/Home/bookings/amenites.dart';
import 'package:vyam_2_final/Home/bookings/review_screen.dart';
import 'package:vyam_2_final/Home/bookings/timings.dart';
import 'package:vyam_2_final/Home/bookings/workout.dart';
import 'package:vyam_2_final/api/api.dart';
import 'package:vyam_2_final/api/maps_launcher_api.dart';
import 'package:vyam_2_final/controllers/packages/packages.dart';
import 'package:vyam_2_final/Home/bookings/know_trainer.dart';
import 'package:vyam_2_final/Providers/firebase_dynamic_link.dart';
// import 'package:dotted_border/dotted_border.dart';

import 'ImageGalary.dart';

var imageSliders;

class GymDetails extends StatefulWidget {
  static String id = "/gym_details";
  // final gymName;
  // final gymID;

  const GymDetails({
    Key? key,
  }) : super(key: key);

  @override
  _GymDetailsState createState() => _GymDetailsState();
}

class _GymDetailsState extends State<GymDetails> {
  static final customCacheManager = CacheManager(Config("customCacheKey",
      maxNrOfCacheObjects: 100, stalePeriod: Duration(days: 15)));

  final gymID = Get.arguments["gymId"];
  bool touch = false;
  var couponDoc;

  getRatingCount(x) async {
    DocumentReference db = await FirebaseFirestore.instance
        .collection("product_details")
        .doc(gymID);
    try {
      db.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          try {
            db.update({"rating": x});
          } catch (e) {
            db.update({"rating": 1});
          }
        }
      });
    } catch (e) {}

    //     .update(
    // {
    // "view_count": +1;
    // }
    // );
  }

  var snaptu;
  getRating() async {
    try {
      await FirebaseFirestore.instance
          .collection("Reviews")
          .where("gym_id", isEqualTo: gymID)
          .snapshots()
          .listen((snap) async {
        if (snap.docs.isNotEmpty) {
          print("documentexist");

          var d = snap.docs;
          snaptu = snap.docs;
          Get.find<Need>().review_number.value = snap.docs.length;
          var b = 0.0;
          var star1 = 0.0;
          var star2 = 0.0;
          var star3 = 0.0;
          var star4 = 0.0;
          var star5 = 0.0;
          // var c=0.0;
          d.forEach((element) {
            b = b + double.parse(element["rating"]);
            if (double.parse(element["rating"]) > 4) {
              star1 = star1 + 1.0;
            } else if (double.parse(element["rating"]) > 3 &&
                double.parse(element["rating"]) <= 4) {
              star2 = star2 + 1.0;
            } else if (double.parse(element["rating"]) > 2 &&
                double.parse(element["rating"]) <= 3) {
              star3 = star3 + 1.0;
            } else if (double.parse(element["rating"]) > 1 &&
                double.parse(element["rating"]) <= 2) {
              star4 = star4 + 1.0;
            } else {
              star5 = star5 + 1.0;
            }
          });
          Get.find<Need>().star1.value =
              double.parse((star1 / d.length).toStringAsFixed(1));
          Get.find<Need>().star2.value =
              double.parse((star2 / d.length).toStringAsFixed(1));
          Get.find<Need>().star3.value =
              double.parse((star3 / d.length).toStringAsFixed(1));
          Get.find<Need>().star4.value =
              double.parse((star4 / d.length).toStringAsFixed(1));
          Get.find<Need>().star5.value =
              double.parse((star5 / d.length).toStringAsFixed(1));
          Get.find<Need>().review.value =
              double.parse((b / d.length).toStringAsFixed(1));
          // print(Get.find<Need>().star5.value);
          // print("Get.find<Need>().star5.value)");
          getRatingCount(await Get.find<Need>().review.value);
        }

        if (snap.docs.isEmpty) {
          Get.find<Need>().review_number.value = 0;
          Get.find<Need>().star1.value = 0.0;
          Get.find<Need>().star2.value = 0.0;
          Get.find<Need>().star3.value = 0.0;
          Get.find<Need>().star4.value = 0.0;
          Get.find<Need>().star5.value = 0.0;
          Get.find<Need>().review.value = 0.0;
          // print(Get.find<Need>().star5.value);
          // print("Get.find<Need>().star5.value)");
          getRatingCount(await Get.find<Need>().review.value);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // = Get.arguments["docs"]
  // final amenityDoc = Get.arguments["docs"]["name"];
  var documents;
  List<dynamic> amenites2 = [""];
  bool isLoad = true;

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  final List _isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int _current = 1;
  var listIndex = 0;
  var times;
  var offer;
  bool isLoading = true;
  var closedday = [];

  getTimings() async {
    try {
      await FirebaseFirestore.instance
          .collection("product_details")
          .doc(gymID)
          .collection("timings")
          .orderBy("position", descending: false)
          .snapshots()
          .listen((snap) {
        setState(() {
          if (snap.docs.isNotEmpty) {
            times = snap.docs;
            isLoading = false;
          }
        });
        print("++++++++FFF+++++${times[0]["closed"].toString()}");
        print(
            "_++++ASDA${DateFormat("EEEE").format(DateTime.now()).toString()}");
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  getOffers() async {
    try {
      await FirebaseFirestore.instance
          .collection("product_details")
          .doc(gymID)
          .collection("offers")
          .where('validity', isEqualTo: true)
          .snapshots()
          .listen((snap) {
        setState(() {
          if (snap.docs.isNotEmpty) {
            offer = snap.docs;
            isLoading = false;
          } else {
            offer = [];
          }
          print('mmmm<<><><><><><NJUGIG$offer');
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  getclosed() async {
    await FirebaseFirestore.instance
        .collection("product_details")
        .doc(gymID)
        .collection("timings")
        .snapshots()
        .listen((snap) {
      setState(() {
        if (snap.docs.isNotEmpty) {
          closedday = snap.docs;
        }
        print(closedday);
      });
    });
  }

  getViewCount() async {
    DocumentReference db = await FirebaseFirestore.instance
        .collection("product_details")
        .doc(gymID);
    try {
      db.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          try {
            db.update({"view_count": documentSnapshot.get("view_count") + 1});
          } catch (e) {
            db.update({"view_count": 1});
          }
        }
      });
    } catch (e) {}
  }

  List<dynamic> workout = [""];
  List<String> rules = [
    '· Bring your towel and use it',
    '· Bring seperate shoes.',
    '· Re-rack equipments',
    '· No heavy lifting without spotter'
  ];

  @override
  void initState() {
    getViewCount();
    getRating();
    getTimings();
    getclosed();
    getOffers();

    super.initState();
  }

  PageController page_controller = PageController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()))
        : StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("product_details")
                .doc(gymID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.exists == false) {
                return Container();
              }
              var docs = snapshot.data;
              amenites2 = docs!["amenities"];
              if (amenites2.isEmpty) {
                amenites2 = [""];
              }
              workout = docs["workouts"];
              if (workout.isEmpty) {
                workout = [""];
              }
              var images = docs["images"];
              // docs["images"].forEach((e){
              //   images.add()
              // });
              // imageSliders=["images"];
              return Scaffold(
                // backgroundColor: const Color(0xffffffff),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      //height: 800,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.symmetric(horizontal: 5.59),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .95,
                          height: MediaQuery.of(context).size.height,
                          child: ListView(children: [
                            const SizedBox(
                              height: 6,
                            ),
                            ImageGallery(
                              images: images,
                              loading: isLoading,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Text(
                                    '${docs["name"] ?? ""}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                    (docs['gym_status'] == false) ||
                                            (times[0]["closed"].contains(
                                                DateFormat("EEEE")
                                                    .format(DateTime.now())
                                                    .toString()))
                                        ? 'CLOSED'
                                        : 'OPEN NOW',
                                    style: TextStyle(
                                      fontFamily: "poppins",
                                      color: (docs['gym_status'] == false) ||
                                              (times[0]["closed"].contains(
                                                  DateFormat("EEEE")
                                                      .format(DateTime.now())
                                                      .toString()))
                                          ? Colors.red
                                          : Colors.lightGreen,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                              ),
                              Text(
                                '${docs["branch"] ?? ""}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    // Get.to(() => const Explore(),
                                    //     arguments: {"location": doc?["location"]});
                                    print(docs['location'].latitude);
                                    MapsLaucherApi().launchMaps(
                                        docs['location'].latitude,
                                        docs['location'].longitude);
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(Icons.assistant_direction,
                                          color: Colors.green),
                                      Text('Navigate',
                                          style: GoogleFonts.poppins(
                                              color: Colors.green,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )),

                              // GestureDetector(
                              //   onTap: () async {
                              //     final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
                              //     final Uri? deepLink = initialLink?.link;
                              //
                              //     Uri url = await FireBaseDynamicLinkService.dynamicLink();
                              //
                              //     print(url);
                              //    // print(deepLink);
                              //
                              //   },
                              //   child: Column(
                              //     children: [
                              //       const Icon(Icons.share,color: Colors.black,),
                              //       Text('Share',
                              //           style: GoogleFonts.poppins(
                              //               color: Colors.black,
                              //               fontSize: 8,
                              //               fontWeight: FontWeight.w600))
                              //     ],
                              //   ),
                              // )

                              //const Text('   ')
                            ]),
                            const SizedBox(height: 12),
                            Text(
                              '${docs["address"] ?? ""}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  // fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.to(
                                  () => Timing_Screen(
                                    id: gymID,
                                  ),
                                );
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: 65,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            height: 50,
                                            width: 55,
                                            //color: Colors.amber,

                                            child: const Center(
                                                child: Icon(
                                                    CupertinoIcons.clock_fill)),
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(10)
                                                // image: DecorationImage(
                                                //     image: AssetImage(
                                                //         "assets/images/time_circle.png")
                                                // )
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        IntrinsicHeight(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    // times[0]["morning_days"]
                                                    times[0]["morning_days"] ??
                                                        "Morning",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    times[0]["Morning"] ??
                                                        " no information",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 10)),
                                              ],
                                            ),
                                            const VerticalDivider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              //crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    times[0]["evening_days"] ??
                                                        "Evening",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey,
                                                        fontSize: 10)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    times[0]["Evening"] ??
                                                        "no information",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 10)),
                                              ],
                                            ),
                                            const VerticalDivider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                            Column(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              //crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    times[0]["closed"][0] ??
                                                        "closed",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey,
                                                        fontSize: 10)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    // "",
                                                    times[0]["closed"][0] !=
                                                            null
                                                        ? 'Closed'
                                                        : "no information",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10)),
                                              ],
                                            ),
                                          ],
                                        )),
                                      ]),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // const Text(' '),
                                const Spacer(),
                                GestureDetector(
                                  child: const Text("View more",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          decoration: TextDecoration.underline,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    Get.to(
                                      () => Timing_Screen(
                                        id: gymID,
                                      ),
                                    );
                                  },
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.green,
                                  size: 20,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (offer.isNotEmpty)
                              buildButton(
                                text: offer[0]['title'].toString(),
                                subText: offer[0]['offer'],
                                onClicked: () => showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  constraints: BoxConstraints.loose(Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.47)),
                                  //useRootNavigator: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  context: context,
                                  builder: (context) => buildSheet(),
                                ),
                              ),
                            // StreamBuilder<QuerySnapshot>(
                            //     stream: FirebaseFirestore.instance
                            //         .collection('product_details')
                            //         .doc(gymID)
                            //         .collection('offers')
                            //         .where('validity', isEqualTo: true)
                            //         .snapshots(),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.connectionState ==
                            //           ConnectionState.waiting) {
                            //         return Center(
                            //             child: CircularProgressIndicator());
                            //       }
                            //       if (snapshot.hasError) {
                            //         return Text(snapshot.error.toString());
                            //       }
                            //       var documents = snapshot.data!.docs;
                            //       var snap;
                            //       print("mmmmmmmmm,,,,,<<<<");
                            //       print(documents);
                            //       return ListView.builder(
                            //           itemCount: documents.length,
                            //           itemBuilder: (context, index) {
                            //             return buildButton(
                            //               text: documents[index]['title'],
                            //               subText: documents[index]
                            //                   ['offer_type'],
                            //               onClicked: () => showModalBottomSheet(
                            //                 shape: RoundedRectangleBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(15.0),
                            //                 ),
                            //                 context: context,
                            //                 builder: (context) => buildSheet(),
                            //               ),
                            //             );
                            //           });
                            //     }),

                            SizedBox(height: 5),

                            Text(
                              'Description',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 16),
                            ReadMoreText(
                              docs["description"] ??
                                  'Lorem ipsum dolor sit amet, consectetur adipscing elit. Sited turpis curabitur sed sed ut lacus vulputate sit. Sit lacus metus quis erat nec mattis erat ac  Lorem ipsum dolor sit amet, consectetur adipscing elit. Sited turpis curabitur sed sed ut lacus vulputate sit. Sit lacus metus quis erat nec mattis erat ac ',
                              trimLines: 3,
                              textAlign: TextAlign.justify,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read More',
                              trimExpandedText: 'Read Less',
                              moreStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              lessStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                              style: GoogleFonts.poppins(
                                  // fontFamily: 'poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Amenities',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            Amenites(
                              amenites: amenites2,
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.1,
                            //   child: StreamBuilder(
                            //     stream: FirebaseFirestore.instance
                            //         .collection('amenities')
                            //         .where('gym_id', arrayContains: amienities)
                            //         .snapshots(),
                            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                            //       if (!snapshot.hasData) {
                            //         return Center(child: CircularProgressIndicator());
                            //       }
                            //       if (snapshot.connectionState ==
                            //           ConnectionState.waiting) {
                            //         return Center(child: CircularProgressIndicator());
                            //       }
                            //       documents = snapshot.data.docs;
                            //       return documents.isNotEmpty
                            //           ? ListView.separated(
                            //               scrollDirection: Axis.horizontal,
                            //               itemBuilder: ((context, index) {
                            //                 return amenities(index);
                            //               }),
                            //               separatorBuilder: (context, _) => SizedBox(
                            //                     width: 8,
                            //                   ),
                            //               itemCount: documents.length)
                            //           : SizedBox();
                            //     },
                            //   ),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Workouts',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            Workouts(
                              workouts: workout,
                            ),
                            const SizedBox(height: 4),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("product_details")
                                    .doc("${gymID}")
                                    .collection("trainer")
                                    .where("eligible", isEqualTo: true)
                                    .orderBy("position")
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.amberAccent,
                                      ),
                                    );
                                  }
                                  // if (snapshot.hasError) {
                                  //   return const Center(
                                  //     child: Text("Theres no trainers"),
                                  //   );
                                  // }
                                  if (snapshot.hasData == false) {
                                    return Container();
                                  }
                                  var trainerdoc = snapshot.data!.docs;
                                  print(trainerdoc);
                                  print(
                                      "+++++++++++++++++++++++++++++++++++++++++++++++");
                                  return trainerdoc.length == 0
                                      ? SizedBox()
                                      : SizedBox(
                                          height:
                                              145, //MediaQuery.of(context).size.height / 4.7,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  () => Trainer(
                                                        gym_name: docs["name"],
                                                        gym_brunch:
                                                            docs["branch"],
                                                      ),
                                                  arguments: {
                                                    "gym_id": gymID,
                                                    "image":
                                                        docs["display_picture"]
                                                  });
                                            },
                                            child: Card(
                                                elevation: .3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0)),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text('Trainers',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                )),
                                                            Spacer(),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios_outlined,
                                                              size: 18,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: SizedBox(
                                                            height: 100,
                                                            //MediaQuery.of(context).size.height /
                                                            //  9,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        trainerdoc
                                                                            .length,
                                                                    physics:
                                                                        const PageScrollPhysics(),
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  if (trainerdoc[index]['image'] != null || trainerdoc[index]['image'] != "")
                                                                                    Container(
                                                                                      height: 65,
                                                                                      width: 65,
                                                                                      decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          //border: Border.all(width: 1),
                                                                                          image: DecorationImage(image: CachedNetworkImageProvider(trainerdoc[index]['image'], maxHeight: 350, maxWidth: 450), fit: BoxFit.cover)),
                                                                                    ),
                                                                                  SizedBox(
                                                                                    height: 2,
                                                                                  ),
                                                                                  Text(trainerdoc[index]['name'],
                                                                                      style: GoogleFonts.poppins(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: 12,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(width: 15),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      );
                                                                    })),
                                                      ),
                                                    ])),
                                          ));
                                }),
                            const SizedBox(height: 14),
                            FittedBox(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => Review(
                                            gymid: docs["gym_id"],
                                          ),
                                      arguments: {
                                        "gym_id": docs["gym_id"],
                                        "docs": docs,
                                        "name": docs["name"]
                                      });
                                },
                                child: Card(
                                    elevation: .3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text('Reviews',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                        // SizedBox(
                                        //   height: MediaQuery.of(context).size.height * 0.01,
                                        // ),
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.94,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18,
                                              ),
                                              Text(
                                                '${docs["rating"]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              ),
                                              const Text(
                                                ' | ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              Obx(
                                                () => Text(
                                                  '(${Get.find<Need>().review_number.value} reviews)',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              const Spacer(),
                                              // SizedBox(
                                              //   width:
                                              //       MediaQuery.of(context).size.width *
                                              //           0.2,
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.28,
                                                  // // height: MediaQuery.of(context)
                                                  //         .size
                                                  //         .height *
                                                  //     0.055,
                                                  child: ListView.builder(
                                                      itemCount: Get.find<
                                                                      Need>()
                                                                  .review_number
                                                                  .value <
                                                              4
                                                          ? Get.find<Need>()
                                                              .review_number
                                                              .value
                                                          : 4,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, int index) {
                                                        return Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
//border: Border.all(width: 1),
                                                                  image: DecorationImage(
                                                                      image: CachedNetworkImageProvider(
                                                                          snaptu[index]["user"]
                                                                              [
                                                                              "user_pic"],
                                                                          maxWidth:
                                                                              100,
                                                                          maxHeight:
                                                                              100),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                        );
                                                      }),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.009,
                                              ),

                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Card(
                                elevation: .3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Rules',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: docs['rules'].length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Text(
                                                docs['rules'][index],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 18,
                            ),
                            Text('Safety protocols',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(
                              height: 18,
                            ),
                            FittedBox(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          height: 139,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // SizedBox(
                                              //   height:
                                              //   MediaQuery.of(context).size.height *
                                              //       0.005,
                                              // ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.10,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 5,
                                                      color: Colors.white),
                                                  // image: const DecorationImage(
                                                  //   image: AssetImage(
                                                  //       'assets/images/safe2.png',
                                                  //   ),
                                                  //   // fit: BoxFit.cover
                                                  // )
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                  'assets/images/safe1.png',
                                                  height: 33,
                                                  width: 33,
                                                )),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              AutoSizeText(
                                                'Best in class safety',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      Colors.grey.shade300))),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Container(
                                          height: 139,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.10,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 5,
                                                      color: Colors.white),
                                                  // image: const DecorationImage(
                                                  //   image: AssetImage(
                                                  //       'assets/images/safe2.png',
                                                  //   ),
                                                  //   // fit: BoxFit.cover
                                                  // )
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                  'assets/images/safe2.png',
                                                  height: 33,
                                                  width: 33,
                                                )),
                                              ),
                                              AutoSizeText(
                                                'Proper sanitised equipments',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                          )),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Container(
                                          height: 139,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.10,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 5,
                                                      color: Colors.white),
                                                  // image: const DecorationImage(
                                                  //   image: AssetImage(
                                                  //       'assets/images/safe2.png',
                                                  //   ),
                                                  //   // fit: BoxFit.cover
                                                  // )
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                  'assets/images/safe3.png',
                                                  height: 33,
                                                  width: 33,
                                                )),
                                              ),
                                              AutoSizeText(
                                                'Social Distancing at all times',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Want to know more ? ',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                                GestureDetector(
                                  child: const Text('Call now ',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.amber,
                                        fontFamily: 'poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  onTap: () async {
                                    var number = (docs['number']);
                                    print(number);
                                    String telephoneUrl =
                                        "tel:${number.toString()}";
                                    if (await canLaunch(telephoneUrl)) {
                                      await launch(telephoneUrl);
                                    } else {
                                      throw "Error occured trying to call that number.";
                                    }
                                  },
                                ),
                                const Icon(
                                  Icons.phone_in_talk,
                                  size: 18,
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.11,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Container(
                  // width: MediaQuery.of(context).size.width,
                  height: 66,
                  width: MediaQuery.of(context).size.width * .95,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 51,
                        width: MediaQuery.of(context).size.width * .85,
                        child: FloatingActionButton.extended(
                          // backgroundColor: Colors.white,
                          elevation: 15,
                          splashColor: Colors.amber,
                          backgroundColor: const Color(0xff292F3D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            // print(docs["images"]);
                            print(docs["address"]);
                            Get.to(
                              () => Packeges(
                                getFinalID: gymID,
                                gymName: docs["name"],
                                gymLocation: docs["address"],
                                doc: docs,
                                branch: docs["branch"],
                              ),
                              duration: const Duration(milliseconds: 300),
                              // arguments: {
                              //   "doc": docs,
                              // }
                            );
                          },
                          label: Text(
                            "Explore Packages",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
  }

// Widget gymImages(String images) => AspectRatio(
//   aspectRatio: 16 / 9,
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(10),
//     child: CachedNetworkImage(
//       imageUrl: images,f
//       fit: BoxFit.cover,
//     ),
//   ),
// );

// Widget amenities(int index) => FittedBox(
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 35,
//             backgroundColor: Colors.amber,
//             child: Image(
//               image: CachedNetworkImageProvider(
//                 documents[index]['image'],
//               ),
//               fit: BoxFit.fill,
//               // width: 26.5,
//               // height: 26.5,
//             ),
//           ),
//
//           SizedBox(
//             width: 90,
//             height: 38,
//             child: Text(
//               documents[index]['name'],
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.clip,
//             ),
//
//           ),
//         ],
//       ),
//     );

  Widget buildButton({
    required String text,
    required VoidCallback onClicked,
    required String subText,
  }) =>
      GestureDetector(
        // style: ElevatedButton.styleFrom(
        //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        // ),
        onTap: onClicked,
        child: Card(
          color: Theme.of(context).colorScheme.surfaceVariant,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              height: 60,
              // width: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/new discount.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          subText,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildSheet() => SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('product_details')
                .doc(gymID)
                .collection('offers')
                .where('validity', isEqualTo: true)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              var couponData = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              var documents = snapshot.data.docs;
              var snap;
              print("mmmmmmmmm,,,,,<<<<");
              print(documents);
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    snap = documents[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6),
                                child: Text(
                                  "Offer Details",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel))
                            ],
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/icons/new discount.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      documents[index]['title'].toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      documents[index]['description'],
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              documents[index]['offer'],
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Divider(color: Colors.grey),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snap['rules'].length,
                                itemBuilder: (context, index) => Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/images/tick2002.png",
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snap['rules'][index].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  });
            }),
      );
}
