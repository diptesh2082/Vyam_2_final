import 'package:flutter/material.dart';
import 'package:vyam_2_final/api/api.dart';


import 'register_gender.dart';
import 'register_name.dart';

import 'custom_register_route.dart';

class Register2 extends StatefulWidget {
  static String id = "/register2_screen";

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text('2',
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
            Text('4',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w400))
          ])),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                    child: Register1(),
                  ));
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
            onPressed: () {
              final isValid = _formKey.currentState?.validate();
              if (isValid!){
                _formKey.currentState?.save();
                Navigator.push(
                    context,
                    CustomPageRoute(
                      child: Register3(),
                    ));
                UserApi.CreateUserEmail(emailController.text);
              }

            },
            backgroundColor: Colors.amber.shade300,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: Stack(
        children: [
          Hero(
              tag: "register",
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8.5),
                child: Image.asset('assets/Illustrations/gym_pana_2.png'),
              )),
          Form(
              key: _formKey,
              child: remail(context)),
        ],
      ),
    );
  }

  Widget remail(BuildContext context) => ListView(
        children: [
          Padding(
            padding:  EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  // margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          'Whats your email ?',
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
                          'Help us tailor the experience',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          color: Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width*.9,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(

                            style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            ),
                            validator: (value){
                              return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                                  ? null
                                  : "Please Provide valid correct Email";
                            },
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              hintText: "Email"),
                            ),
                          )),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Container(
                      //       width: double.infinity,
                      //       child: Image.asset('assets/Illustrations/gym_pana_2.png')),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
}
