import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/firebase_options.dart';
import 'package:mabook/src/view/splashscreen.dart';

// ...

Future<void>
 main()  async {
  runApp(const MyApp());

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
// .then((FirebaseApp value) => Get.put(AuthenticationRepository()))
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home:SplashScreen(),
    );
  }
}