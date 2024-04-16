// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:mabook/src/view/authentication/AuthenticationRepository/google_signin.dart';
import 'package:mabook/src/controller/login&signin/login_Auth.dart';
import 'package:mabook/src/view/authentication/forgot%20pssword/forgotPassword.dart';
import 'package:mabook/src/view/authentication/signup%20page/signupPage.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: LoginForm(context),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Form LoginForm(BuildContext context) {
    return Form(
              key: _formKeyy,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
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
                              color:green,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey(email),
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
                              color:green,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey(password),
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
                  Padding(
                    padding: EdgeInsets.only(left: 250),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => forgotPassword()));
                        },
                        child: Text('forgot password')),
                  ),
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
                          signIn(email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Login'),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => signUpPage()));
                        },
                        child: Text('Sign Up'))
                  ]),
                  SizedBox(width: 350, child: Divider()),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: GestureDetector(
                     onTap: () {
                    AuthenticationRepository()
                        .signInWithGoogle()
                        .then((userCredential) {
                      final email = userCredential.user!.email;
                      Get.snackbar(
                        'Successfully signed in',
                        'Signed in with $email',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Get.offAll(
                          const homePage()); 
                    }).catchError((error) {
                      print('Sign-in with Google failed: $error');
                      Get.snackbar(
                        'Error',
                        'Sign-in with Google failed. Please try again later.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
    },
                      child: SizedBox(
                        height: 50,
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.g_mobiledata,
                              size: 45,
                            ),
                            Text(
                              'Sign In With Google',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: SizedBox(
                      height: 50,
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.facebook_sharp,
                            size: 28,
                            color: const Color.fromARGB(255, 28, 97, 153),
                          ),
                          Text(
                            '   Sign In With Facebook',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}
