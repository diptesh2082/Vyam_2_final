import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_2_final/colors/color.dart';
import 'package:vyam_2_final/controllers/onbording_controller.dart';


class Onboarding1 extends StatelessWidget {
  final _controller = OnboardingController();

  Onboarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                onPageChanged: _controller.selectedPageIndex,
                  controller: _controller.pageController,
                  itemCount: _controller.onboardingPages.length,
                  itemBuilder: (itemBuilder,index){
                return Container(
                    color: backgroundColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height*.028,
                        ),
                        Image.asset(
                          _controller.onboardingPages[index].imageAssets,
                          height: size.height/2.4,
                          width: size.width/1.2,
                          fit: BoxFit.fitWidth,
                        ),
                        // SizedBox(
                        //   height: size.height/65,
                        // ),
                        SizedBox(height: size.height*.045),
                        Container(
                          height: size.height/2.5,
                          width: size.width/1.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0,right:5,top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _controller.onboardingPages[index].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                 Padding(
                                   padding: EdgeInsets.only(
                                       top: size.height*.015,
                                     left: size.width*.02,
                                     right: size.width*.02
                                   ),
                                   child: Text(
                                     _controller.onboardingPages[index].description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black45,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                ),
                                 ),
                                SizedBox(
                                  height: size.height/35,
                                ),
                                SizedBox(
                                  height: size.height/20,
                                  width: size.width/3,
                                  child: ElevatedButton(
                                      onPressed: _controller.forwardAction,
                                      child: const Text("Next",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: buttonColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                );
              }),
              Positioned(
                bottom: size.height/60,
                left: size.width/2-11*_controller.onboardingPages.length,
                child: Row(
                  children:
                    List.generate(
                        _controller.onboardingPages.length,
                            (index) => Obx((){
                              return Container(
                                margin: const EdgeInsets.all(4),
                                height: 11,
                                width: _controller.selectedPageIndex.value == index
                                  ? 15
                                    : 11
                                ,
                                decoration: BoxDecoration(
                                    color: _controller.selectedPageIndex.value == index
                                        ? Colors.black
                                        : Colors.black12,
                                    borderRadius: _controller.selectedPageIndex.value == index
                                      ? BorderRadius.circular(5)
                                      : BorderRadius.circular(10)
                                ),
                              );
                            })

                    )
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: 30,
                  width: 60,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: const TextStyle(
                              fontSize: 10
                          )
                      ),
                      onPressed: (){
                        Get.offAllNamed("/login");
                      },
                      child: const Text(
                        "SKIP",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      )
                  ),
                ),
                top: 7,
                right: 5,
              ),
            ],
          )

        )
    );
  }
}
