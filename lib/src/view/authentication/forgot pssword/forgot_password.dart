import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/login&signin/signup_auth.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: 210,
                child: Image.asset('assets/splash screen.png'),
              ),
              const SizedBox(
                height: 60,
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 110),
                      child: Text(
                        'Forgot your password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 58),
                      child: Text(
                        'Enter your phone number,we will send you\nconfirmation code',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 225),
                      child: Text(
                        'Phone.No',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48),
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
                                Icons.email_outlined,
                                color: Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: ctrl.resetPassword,
                              decoration: const InputDecoration(
                                labelText: 'Enter mail',
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
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 50,
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    ctrl.passwordReset();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 0, 212, 198),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                  ),
                  child: const Text('Send OTP', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
