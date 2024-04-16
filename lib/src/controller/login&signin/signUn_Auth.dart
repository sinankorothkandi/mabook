// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/authentication/login%20page/loginpage.dart';

signUpFuction(String email, String password)async{
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email:email,
    password: password,
   
  );
   print("//////////Success////////");
     Get.to(() =>const LoginPage());
     
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}
