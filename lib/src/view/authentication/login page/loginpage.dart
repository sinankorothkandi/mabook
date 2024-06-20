import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/login&signin/signup_auth.dart';
import 'package:mabook/src/view/authentication/login%20page/w_login.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKeyy = GlobalKey<FormState>();
  final ctrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: loginForm(context,ctrl,formKeyy,),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  
}
