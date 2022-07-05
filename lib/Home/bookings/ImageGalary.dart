import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGallery extends StatefulWidget {
  ImageGallery({Key? key, this.images, required this.loading})
      : super(key: key);
  final images;
  var loading;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  // bool isLoading=true;
  List Images = [];
  Future cacheImage(BuildContext context, String e) => precacheImage(
        CachedNetworkImageProvider(
          e,
          cacheKey: "customCacheKey2",
          cacheManager: customCacheManager,
        ),
        context,
      );
  bool loading = true;
  loadImage() async {
    // setState(() {
    //  loading=true;
    // });
    Images = widget.images;
    await Future.wait(Images.map((e) => cacheImage(context, e)).toList());

    await Future.wait(
            Images.map((e) => DefaultCacheManager().getFileFromCache(e))
                .toList())
        .then((value) {
      setState(() {
        loading = false;
      });
    });
  }
  // var III = DefaultCacheManager().getFileFromCache(url);

  static final customCacheManager = CacheManager(Config(
    "customCacheKey2",
    maxNrOfCacheObjects: 110,
  ));

  PageController page_controller = PageController();
  int _current = 1;
  final List _isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadImage();
    });
    // loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: CarouselSlider.builder(
                    itemCount: Images.length,
                    itemBuilder: (context, index, realIndex) {
                      // final image = Images[index];
                      if (Images.isNotEmpty) {
                        page_controller = PageController(initialPage: index);
                        return gymImages(Images[index]);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Container();
                    },
                    options: CarouselOptions(
                        height: 255,
                        autoPlay: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index + 1;
                            // tkind.current.value=index+1;
                            for (int i = 0; i < Images.length; i++) {
                              if (i == index) {
                                _isSelected[i] = true;
                              } else {
                                _isSelected[i] = false;
                              }
                            }
                          });
                          // for (int i = 0; i < images.length; i++) {
                          //   if (i == index) {
                          //     tkind.isSelected.value[i] = true;
                          //   } else {
                          //     tkind.isSelected.value[i] = false;
                          //   }
                          // }
                        }),
                  ),
                  onTap: () {
                    try {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          // opaque: false,
                          barrierColor: Colors.white.withOpacity(0),
                          pageBuilder: (BuildContext context, _, __) {
                            return GestureDetector(
                              child: PhotoViewGallery.builder(
                                pageController: page_controller,
                                scrollPhysics: const BouncingScrollPhysics(),
                                builder: (BuildContext context, int index) {
                                  // listIndex=index;
                                  return PhotoViewGalleryPageOptions(
                                    filterQuality: FilterQuality.low,
                                    initialScale:
                                        PhotoViewComputedScale.contained,
                                    minScale:
                                        PhotoViewComputedScale.contained * 0.95,
                                    maxScale:
                                        PhotoViewComputedScale.contained * 2.5,
                                    basePosition: Alignment.center,
                                    imageProvider: CachedNetworkImageProvider(
                                      Images[index],
                                      cacheManager: customCacheManager,
                                    ),
                                    // heroAttributes: PhotoViewHeroAttributes(tag: "o"),
                                  );
                                },
                                itemCount: Images.length,
                                loadingBuilder: (context, event) => Center(
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      value: event == null
                                          ? 0
                                          : event.cumulativeBytesLoaded * 5,
                                    ),
                                  ),
                                ),
                                // backgroundDecoration: widget.backgroundDecoration,
                                // pageController: widget.pageController,
                                // onPageChanged: onPageChanged,
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            );
                          },
                        ),
                      );
                    } catch (e) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  },
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width * .4) -
                      (widget.images.length * 9),
                  // right: 40,
                  bottom: 0,
                  child: SizedBox(
                      height: 25,
                      // width: MediaQuery.of(context).size.width,
                      // color: Colors.black26,
                      child: Row(
                        children: [
                          for (int i = 0; i < Images.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Visibility(
                                  child: Container(
                                height: 2,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: _isSelected[i]
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              )),
                            ),
                        ],
                      )),
                ),
                Positioned(
                  // left: MediaQuery.of(context).size.width * 0.8,
                  right: 290,
                  // bottom: 10,
                  top: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
                Positioned(
                  // left: MediaQuery.of(context).size.width * 0.8,
                  right: 10,
                  bottom: 10,
                  left: 280,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        height: 28,
                        width: 0,
                        color: Colors.black45,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                _current.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Text("/",
                                style: TextStyle(color: Colors.white)),
                            Text(Images.length.toString(),
                                style: const TextStyle(color: Colors.white))
                          ],
                        )),
                  ),
                ),
                // CarouselWithIndicatorDemo()
              ],
            ));
  }

  Widget gymImages(String images) => AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 80),

            maxHeightDiskCache: 600,
            // maxWidthDiskCache: 700,
            // width: 400,
            // height: 400,
            imageUrl: images,
            fit: BoxFit.cover,
          ),
        ),
        // width: MediaQuery.of(context).size.width,
        // height: 500,
        // height: 500,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: CachedNetworkImageProvider(images),
        //         fit: BoxFit.cover
        //   )
        //
        // ),
      );
}
