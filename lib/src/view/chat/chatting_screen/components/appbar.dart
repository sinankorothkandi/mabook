import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

AppBar appbar(String friendName) {
  return AppBar(
    shape: const Border(
      bottom: BorderSide(color: green, width: 1),
    ),
    foregroundColor: green,
    backgroundColor: white,
    toolbarHeight: 65,
    title: Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(
            "assets/splash screen.png",
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Text(
          friendName,
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ],
    ),
  );
}
