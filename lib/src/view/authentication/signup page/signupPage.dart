// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/login&signin/signUn_Auth.dart';
import 'package:mabook/src/view/authentication/login%20page/loginpage.dart';
import 'package:mabook/src/view/authentication/signup%20page/email_verification.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/profile/personal%20details/details_adding.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<signUpPage> {
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();
  final ctrl = Get.put(AuthController());
  bool? isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: signUpFrom(),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Form signUpFrom() {
    return Form(
      key: _formKeyy,
      child: Column(
        children: [
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
                      color: green,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: ctrl.userName,
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
                      color: green,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: ctrl.email,
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
                      color: green,
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
                    controller: ctrl.password,
                  ),
                ),
              ],
            ),
          ),

          //||===============this is check box of the privacy policy ============================||
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Checkbox(
                  checkColor: green,
                  fillColor: MaterialStateProperty.all<Color>(white),
                  value: isAgree,
                  onChanged: (value) {
                    setState(() {
                      isAgree = value;
                    });
                  },
                ),
                Text(
                  "I agree with Terms of Conditions and\nPrivacy Policy",
                  style: GoogleFonts.poppins(fontSize: 16),
                )
              ],
            ),
          ),
          //||====================================================================================||
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 50,
            width: 360,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKeyy.currentState!.validate()) {
                  _formKeyy.currentState!.save();
                  if (!isAgree!) {
                    Get.snackbar(
                        "Error", 'PLease agree the terms and conditions',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  ctrl.signUp(
                      userName: ctrl.userName.text,
                      userEmail: ctrl.email.text,
                      password: ctrl.password.text,
                      context: context);
                } else {
                  return;
                }

                if (ctrl.auth.currentUser != null) {
                  Get.to(() => UserDetailsAdd());
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('register'),
            ),
          ),
          SizedBox(
            height: 15,
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
    );
  }
}
