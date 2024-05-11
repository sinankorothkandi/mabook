// // ignore_for_file: avoid_print, unused_local_variable

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:mabook/src/view/home/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// signIn(String email, String password) async {
//   try {
//     final credential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//     // credential.user!.sendEmailVerification();

//     setLoggedIn();
//     print("//////////Success////////");
//     Get.to(() => const homePage());
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//   }
// }

// void setLoggedIn() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setBool("isLoggedIn", true);
// }
