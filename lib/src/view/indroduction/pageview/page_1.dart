import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/indroduction/intro/intro.dart';

class page_1 extends StatelessWidget {
  const page_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Get.to(() => const intro());
              },
              child: const Text('Skip'))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              width: 400,
              child: Image.asset("assets/img1.jpg"),
            ),
            const Text(
              'The Importance of Healthcare\nAccess',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
