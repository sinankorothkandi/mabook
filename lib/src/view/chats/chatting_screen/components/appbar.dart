import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

AppBar appbar(List friendData) {
  return AppBar(
    shape: Border(
      bottom: BorderSide(color: grey, width: 1),
    ),
    foregroundColor: green,
    backgroundColor:white,
    toolbarHeight: 65,
    title: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: friendData[1] == null
              ? const AssetImage(
                  "assets/profile.jpeg",
                ) as ImageProvider
              : NetworkImage(friendData[1].toString()),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          friendData[0] ?? "",
          style: GoogleFonts.poppins(fontSize: 30),
        ),
      ],
),
);
}