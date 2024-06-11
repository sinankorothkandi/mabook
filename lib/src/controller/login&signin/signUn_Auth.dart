import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mabook/src/model/user_information_model.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';
import 'package:mabook/src/view/authentication/personal%20details/details_adding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController users = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController resetPassword = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  String verifyId = "";
  bool userWithNumExists = false;
  Rx<bool?> isAgree = Rx<bool?>(null);
  var loading = false.obs;
  var isEmailVerified = false.obs;
  RxString username = "".obs;
  Rx<bool> emailVerified = Rx<bool>(false);

  Future<User?> signUp({
    required String userName,
    required String userEmail,
    required String password,
    required BuildContext context,
  }) async {
    if (userName.isEmpty || userEmail.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your name and email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
    if (password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a password",
        snackPosition: SnackPosition.BOTTOM,
      );
      //  loading.value = true;
      return null;
    }

    if (isAgree.value == false) {
      Get.snackbar("Error", "Please accept terms and conditions.",
          snackPosition: SnackPosition.BOTTOM);
      //loading.value = true;
      return null;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: passwordc.text);
      Get.to(const UserDetailsAdd());
      await userCredential.user!.sendEmailVerification();
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);
        await user.reload();
        username.value = userName;

        await addUser(userModele(
            userName: users.text, email: email.text, password: password,chatWith:[]));
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.',
            snackPosition: SnackPosition.BOTTOM);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  passwordReset() async {
    try {
      await auth.sendPasswordResetEmail(
        email: resetPassword.text.trim(),
      );
      Get.snackbar('Success', 'Password reset link sent to your email.',
          colorText: Colors.green, snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (isEmailVerified.value) {
      Get.snackbar('Success', 'Email Successfully Verified.',
          snackPosition: SnackPosition.BOTTOM);
      // Get.offAll(() => const UserDetailsAdd());
    } else {
      Get.snackbar('Error', 'Please verify your email. Check your mail',
          colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  addUser(userModele user) async {
    await db.collection("users").doc(auth.currentUser!.uid).set(user.toMap());
  }

  signOut() async {
    await auth.signOut();
  }

  signIn() async {
    if (loginEmail.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
    if (loginPassword.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a password",
        snackPosition: SnackPosition.BOTTOM,
      );
      //  loading.value = true;
      return null;
    }
    try {
      loading.value = true;

      await auth.signInWithEmailAndPassword(
          email: loginEmail.text, password: loginPassword.text);

      Get.offAll(() => const CustomBottomNavigationBar());
      setLoggedIn();
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      loading.value = false;
    }
  }

  void setLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
  }

 //sign in with google
  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Sign out from Google to force account selection
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          // Check if the user exists in Firestore
          QuerySnapshot userQuery = await db
              .collection('users')
              .where('id', isEqualTo: user.uid)
              .get();
          if (userQuery.docs.isEmpty) {
            // If user does not exist, create a new user in Firestore
            await addUser(userModele(
              userName: user.displayName,
              email: user.email,
              // notificationToken:
              //     notificationToken, // replace with your actual token variable
              id: user.uid,
              chatWith: [],
            ));
          }

          // Navigate to BottomNavBar
          Get.offAll(() => CustomBottomNavigationBar());
        }
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
}
}


  getUserDetailsByUId(String uid) async {
    if (uid == "") {
      Get.snackbar("Error", "Something went wrong. Please try again");
      Get.back();
      return;
    }
    try {
      QuerySnapshot querySnapshot =
          await db.collection('users').where('id', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return [
          data['name'],
          data['imageUrls'],
          data['id'],
          data['notificationToken']
        ];
      }
    } catch (e) {
       Get.snackbar('Error', e.toString());
}
}
}
