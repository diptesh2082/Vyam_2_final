import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vyam_2_final/Home/bookings/gym_details.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key, this.images}) : super(key: key);
  final images;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  PageController page_controller =PageController();
  int _current = 1;
  final List _isSelected = [true, false, false, false, false, false,false,false];
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                itemBuilder: (context, index, realIndex) {
                  final image = widget.images[index];
                  page_controller=PageController(initialPage: index);
                  return gymImages(image);
                },
                options: CarouselOptions(
                    height: 255,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index + 1;
                        // tkind.current.value=index+1;
                        for (int i = 0; i < widget.images.length; i++) {
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

                try{
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
                                initialScale:
                                PhotoViewComputedScale.contained,
                                minScale:
                                PhotoViewComputedScale.contained *
                                    0.95,
                                maxScale:
                                PhotoViewComputedScale.contained *
                                    2.5,
                                basePosition: Alignment.center,
                                imageProvider: CachedNetworkImageProvider( widget.images[index]),
                                // heroAttributes: PhotoViewHeroAttributes(tag: "o"),
                              );
                            },
                            itemCount: widget.images.length,
                            loadingBuilder: (context, event) => Center(
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  value: event == null
                                      ? 0
                                      : event.cumulativeBytesLoaded / 1,
                                ),
                              ),
                            ),
                            // backgroundDecoration: widget.backgroundDecoration,
                            // pageController: widget.pageController,
                            // onPageChanged: onPageChanged,
                          ),
                          onTap: () {
                            Navigator.of(context,rootNavigator: true).pop();
                          },
                        );
                      },
                    ),
                  );
                }catch(e){
                  Navigator.of(context,rootNavigator: true).pop();
                }


              },
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 3,
              // right: 40,
              bottom: 0,
              child: SizedBox(
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.black26,
                  child: Row(

                    children: [
                      for (int i = 0; i < widget.images.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Visibility(
                              child: Container(
                                height: 2,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
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
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            _current.toString(),
                            style: const TextStyle(
                                color: Colors.white),
                          ),
                        ),
                        const Text("/",
                            style:
                            TextStyle(color: Colors.white)),
                        Text(widget.images.length.toString(),
                            style: const TextStyle(
                                color: Colors.white))
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
