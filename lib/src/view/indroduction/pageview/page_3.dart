import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/indroduction/intro/intro.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              SizedBox(
                height: 500,
                width: 400,
                child: Image.asset("assets/img2.jpg"),
              ),
              const Text(
                'Stay Connected to Your Health with\nOur Mobile App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const Intro());
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 0, 212, 198),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
