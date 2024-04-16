// ignore_for_file: avoid_print


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthenticationRepository {
  Future<UserCredential> signInWithGoogle() async {
   
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

     
      return await FirebaseAuth.instance.signInWithCredential(credential);
    
    
  }
}
