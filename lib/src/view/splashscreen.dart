import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';
import 'package:mabook/src/view/home/home/home.dart';
import 'package:mabook/src/view/indroduction/intro/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigationToHome();
  }

  void _navigationToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(milliseconds: 500));
    if (isLoggedIn) {
      // Get.to(() => const HomePage());
      Get.to(() => CustomBottomNavigationBar());
    } else {
      Get.to(() => const intro());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //||====================BODY==================||
      body: Center(
        child: SizedBox(
          height: 200,
          width: 420,
          child: Image.asset('assets/splash screen.png'),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
