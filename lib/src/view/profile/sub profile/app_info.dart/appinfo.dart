// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          'App Info',
          style: GoogleFonts.poppins(color: black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.navigate_before, color: black)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: SizedBox(
              height: 180,
              width: 420,
              child: Image.asset('assets/mabookimg.png'),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '@2024 MABOOK',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 44,
                  width: 177,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Licenses',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
