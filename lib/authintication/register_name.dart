import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyam_2_final/api/api.dart';

import 'register_email.dart';

import 'custom_register_route.dart';

class Register1 extends StatefulWidget {
  static String id = "/register1_screen";


  @override
  State<Register1> createState() => _Register1State();
}


class _Register1State extends State<Register1> {
  TextEditingController nameController = TextEditingController();
  // final GlobalKey<FromState> _fromKey= GlobalKey<FromState>();
  // final _fromKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    UserApi.createNewUser();
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text('1', //_current1.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            Text("/",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            Text('4', //rimages.length.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w400))
          ])),
          leading: GestureDetector(
            onTap: null,
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
            onPressed: () async {
              final isValid = _formKey.currentState?.validate();
              if (isValid!){
                _formKey.currentState?.save();
                Navigator.push(
                    context,
                    CustomPageRoute(
                      child: Register2(),
                    ));
                UserApi.createUserName(nameController.text);

              }
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);


              // Get.to(()=> isVlid Register2);
            },
            backgroundColor: Colors.amber.shade300,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            )
        ),
      ),
      body: Stack(
        children: [
          Hero(
              tag: "register",
              child: 
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8.5),
                  child: Image.asset('assets/Illustrations/gym_pana_1.png'))),
          Form(
              key: _formKey,
              child: Rname(context)),
        ],
      ),
    );
  }

  Widget Rname(BuildContext context) => ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                //margin: EdgeInsets.only(left: 10.0),
                child: Padding(
                  padding:  EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Whats your name ?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          ' Help us tailor the experience',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 20
                        // MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          color: Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width*.9,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: SizedBox(
                            // height: 50,
                            child: TextFormField(
                            // textInputAction: TextInputAction.done,

                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),

                            controller: nameController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                hintText: "Full Name"),
                            validator: (value){
                              if(value!.isEmpty || value.length < 4){
                                return "Enter your full name";
                              }else{
                                return null;
                              }
                            },
                            ),
                            ),
                          )),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Container(
                      //       width: double.infinity,
                      //       child: Image.asset(
                      //           'assets/Illustrations/gym_pana_1.png')),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      );
}
