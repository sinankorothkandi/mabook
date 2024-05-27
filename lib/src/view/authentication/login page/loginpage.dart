// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/login&signin/signUn_Auth.dart';
import 'package:mabook/src/view/authentication/AuthenticationRepository/google_signin.dart';
import 'package:mabook/src/view/authentication/forgot%20pssword/forgotPassword.dart';
import 'package:mabook/src/view/authentication/signup%20page/signupPage.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();
  final ctrl = Get.put(AuthController());
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
                      color: green,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: ctrl.loginEmail,
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
                    controller: ctrl.loginPassword,
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
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 250),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => forgotPassword()));
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
                  ctrl.signIn();
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
                      context, MaterialPageRoute(builder: (_) => signUpPage()));
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
                ctrl.signInWithGoogle();
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
            child: GestureDetector(
              // onTap: () => ctrl.,
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
          ),
        ],
      ),
    );
  }
}
