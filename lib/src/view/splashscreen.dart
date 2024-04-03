import 'package:flutter/material.dart';
import 'package:mabook/src/view/indroduction/pageview/pageview.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  pageView(),
        ),
      );
    });

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
