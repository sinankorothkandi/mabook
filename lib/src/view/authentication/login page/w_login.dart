import 'package:flutter/material.dart';
import 'package:mabook/src/controller/login&signin/signup_auth.dart';
import 'package:mabook/src/view/authentication/forgot%20pssword/forgot_password.dart';
import 'package:mabook/src/view/authentication/signup%20page/signup_page.dart';
import 'package:mabook/src/view/const/colors.dart';

Form loginForm(BuildContext context,AuthController ctrl,_formKeyy) {
    return Form(
      key: _formKeyy,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
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
                    controller: ctrl.loginEmail,
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
                    controller: ctrl.loginPassword,
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
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgotPassword()));
                },
                child: const Text('forgot password')),
          ),
          const SizedBox(
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
              child: const Text('Login'),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Don't have an account?"),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()));
                },
                child: const Text('Sign Up'))
          ]),
          const SizedBox(width: 350, child: Divider()),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: GestureDetector(
              onTap: () {
                ctrl.signInWithGoogle();
              },
              child: const SizedBox(
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: GestureDetector(
              // onTap: () => ctrl.,
              child: const SizedBox(
                height: 50,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook_sharp,
                      size: 28,
                      color: Color.fromARGB(255, 28, 97, 153),
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