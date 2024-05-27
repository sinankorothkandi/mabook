import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mabook/src/model/user_information_model.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';
import 'package:mabook/src/view/home/home/home.dart';
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
            userName: users.text, email: email.text, password: password));
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

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
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

        await auth.signInWithCredential(credential);
        Get.to(() => const HomePage());
      }
    } catch (e) {
      Get.snackbar("Error", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  sentOtp() async {
    try {
      QuerySnapshot snapshot = await db
          .collection('users')
          .where('phoneNumber', isEqualTo: '+91${phoneNumber.text}')
          .get();

      if (snapshot.docs.isNotEmpty) {
        userWithNumExists = true;
        DocumentSnapshot userDoc = snapshot.docs.first;
        String userName = userDoc['name'];

        Get.snackbar('Success', 'OTP sent to + 91 ${phoneNumber.text}',
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              'Welcome back, $userName!',
              style: GoogleFonts.poppins(),
            ));

        await auth.verifyPhoneNumber(
            phoneNumber: "+91${phoneNumber.text}",
            verificationCompleted: (PhoneAuthCredential credential) async {},
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                Get.snackbar('Error', 'The provided phone number is not valid.',
                    snackPosition: SnackPosition.BOTTOM);
              } else {
                Get.snackbar('Error', 'An error occurred. ${e.toString()}',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            codeSent: (String verificationId, [int? resendToken]) {
              verifyId = verificationId;
              Get.snackbar('Success', 'OTP sent to + 91 ${phoneNumber.text}',
                  snackPosition: SnackPosition.BOTTOM);
              // Get.to(() => OtpVerificationPage());
            },
            codeAutoRetrievalTimeout: (String verificationId) {});
      } else {
        userWithNumExists = false;
        await auth.verifyPhoneNumber(
            phoneNumber: "+91${phoneNumber.text}",
            verificationCompleted: (PhoneAuthCredential credential) async {
              User? user = auth.currentUser;
              if (user == null) {
                UserCredential userCredential =
                    await auth.signInWithCredential(credential);
                User? newUser = userCredential.user;
                if (newUser != null) {
                  await db.collection('users').doc(newUser.uid).set({
                    'phoneNumber': newUser.phoneNumber,
                    'name': users.text,
                    'createdAt': Timestamp.now(),
                  });
                }
              }
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                Get.snackbar('Error', 'The provided phone number is not valid.',
                    snackPosition: SnackPosition.BOTTOM);
              } else {
                Get.snackbar('Error', 'An error occurred. ${e.toString()}',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            codeSent: (String verificationId, [int? resendToken]) {
              verifyId = verificationId;
              Get.snackbar('Success', 'OTP sent to + 91 ${phoneNumber.text}',
                  snackPosition: SnackPosition.BOTTOM);
              // Get.to(() => OtpVerificationPage());
            },
            codeAutoRetrievalTimeout: (String verificationId) {});
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  verifyOtp() async {
    final cred = PhoneAuthProvider.credential(
        verificationId: verifyId, smsCode: otp.text);
    try {
      final user = await auth.signInWithCredential(cred);
      if (user.user != null) {
        Get.snackbar("Success", "OTP verified",
            snackPosition: SnackPosition.BOTTOM);

        if (auth.currentUser!.displayName != null) {
          // Get.to(() => BottomNavBar());
        } else {
          // Get.to(() => UserNameNumSignUp());
          saveUserNameNum();
        }
      } else {
        Get.snackbar("Error", "OTP not verified",
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  saveUserNameNum() async {
    if (users.text.isEmpty) {
      Get.snackbar("Error", "Please enter a username",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (auth.currentUser!.displayName == null) {
      print("====================================");
      await auth.currentUser!.updateDisplayName(users.text);
      Get.snackbar("Success", "username has been saved",
          snackPosition: SnackPosition.BOTTOM);

      print(auth.currentUser);
      // Get.to(() => BottomNavBar());
    }
    //else {
    //   Get.snackbar("Error", "-----", snackPosition: SnackPosition.BOTTOM);
// }
  }
}
