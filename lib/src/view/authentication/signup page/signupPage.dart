// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/authentication/authentication_fuction/signUn_Auth.dart';
import 'package:mabook/src/view/authentication/login%20page/loginpage.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<signUpPage> {
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70),
              child: Form(
                key: _formKeyy,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text('Sign Up to your account',
                        style: TextStyle(
                          fontSize: 17,
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 47,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.person,
                                color: const Color.fromARGB(255, 112, 112, 112),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              key: ValueKey('userName'),
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onSaved: (Value) {
                                setState(() {
                                  username = Value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 47,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.mail,
                                color: const Color.fromARGB(255, 115, 115, 115),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                             key: ValueKey('email'),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a email address';
                                } else if (!RegExp(
                                        r'^[A-Za-z][A-Za-z0-9._%+-]*@(gmail\.com|outlook\.com|company\.com)$')
                                    .hasMatch(value)) {
                                  return 'Invalid email format or domain';
                                }
                                return null;
                              },
                              onSaved: (Value) {
                                setState(() {
                                  email = Value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48,
                            width: 47,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.lock_rounded,
                                color: const Color.fromARGB(255, 112, 112, 112),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              obscureText: true,
                              key: ValueKey('password'),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Password';
                                }
                                return null;
                              },
                              onSaved: (Value) {
                                setState(() {
                                  password = Value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 30),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         height: 48,
                    //         width: 47,
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(10.0),
                    //             bottomLeft: Radius.circular(10.0),
                    //           ),
                    //           child: Container(
                    //             child: Icon(
                    //               Icons.lock_rounded,
                    //               color:
                    //                   const Color.fromARGB(255, 104, 104, 104),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(width: 20),
                    //       Expanded(
                    //         child: TextFormField(
                    //           obscureText: true,
                    //           controller: _ConfirmpasswordController,
                    //           decoration: InputDecoration(
                    //             labelText: 'Confirm Password',
                    //             border: InputBorder.none,
                    //           ),
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return 'Please enter password again';
                    //             }
                    //             if (_ConfirmpasswordController.text !=
                    //                 password) {
                    //               return 'please enter currect password';
                    //             }
                    //             return null;
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //||===============this is check box of the privacy policy ============================||
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Icon(Icons.check_box_outline_blank),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Text(
                    //       'I agree to the medidoc Terms of services\n and Privacy Policy',
                    //       style: TextStyle(
                    //           color: const Color.fromARGB(255, 0, 0, 0)),
                    //     ),
                    //   ],
                    // ),
                    //||====================================================================================||
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 360,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKeyy.currentState!.validate()) {
                           
                            _formKeyy.currentState!.save();
                                 
                            signUpFuction(email, password);
                          
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 0, 212, 194),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('register'),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Aldready have an account?"),
                      TextButton(
                          onPressed: () {
                            Get.to(() => LoginPage());
                          },
                          child: Text('Login'))
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
