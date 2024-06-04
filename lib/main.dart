import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/firebase_options.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/splashscreen.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: white,
        ),
        cardTheme: CardTheme(
          color: const Color.fromARGB(255, 252, 252, 252),
          shadowColor:
              const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
