import 'package:flutter/material.dart';
import 'package:mabook/src/view/const/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      appBar: AppBar(
        backgroundColor: green,
        centerTitle: true,
        title: const Text('Help Center',
            style: TextStyle(
                fontSize: 22, color: white, fontWeight: FontWeight.w500)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: white,
            )),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(30), topStart: Radius.circular(30))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(top: 66, right: 180, bottom: 10),
              child: Text(
                'Tell us how we can help ',
                style: TextStyle(
                    fontSize: 18, color: green, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: green)),
                    hintText: 'Type some message...',
                  ),
                  maxLines: 12,
                )),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 54,
              width: 377,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(color: white, fontSize: 24),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
