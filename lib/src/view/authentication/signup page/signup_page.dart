import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/login&signin/signup_auth.dart';
import 'package:mabook/src/view/authentication/login%20page/loginpage.dart';

import 'package:mabook/src/view/const/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();
  final ctrl = Get.put(AuthController());
  bool? isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const SizedBox(
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
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: ctrl.users,
                    key: const ValueKey('userName'),
                    decoration: const InputDecoration(
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const SizedBox(
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
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: ctrl.email,
                    key: const ValueKey('email'),
                    decoration: const InputDecoration(
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const SizedBox(
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
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    obscureText: true,
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Password';
                      }
                      return null;
                    },
                    controller: ctrl.passwordc,
                  ),
                ),
              ],
            ),
          ),

          //||===============this is check box of the privacy policy ============================||
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Checkbox(
                  checkColor: green,
                  fillColor: WidgetStateProperty.all<Color>(white),
                  value: isAgree,
                  onChanged: (value) {
                    setState(() {
                      isAgree = value;
                    });
                  },
                ),
                Text(
                  "I agree with Terms of Conditions\nand Privacy Policy",
                  style: GoogleFonts.poppins(fontSize: 16),
                )
              ],
            ),
          ),
          //||====================================================================================||
          const SizedBox(
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
                      userName: ctrl.users.text,
                      userEmail: ctrl.email.text,
                      password: ctrl.passwordc.text,
                      context: context);
                } else {
                  return;
                }

                if (ctrl.auth.currentUser != null) {
                  // Get.to(() => UserDetailsAdd());
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('register'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Aldready have an account?"),
            TextButton(
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: const Text('Login'))
          ]),
        ],
      ),
    );
  }
}
