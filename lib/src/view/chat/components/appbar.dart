import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';
AppBar appbar() {
  return AppBar(
    toolbarHeight: 45,
    centerTitle: true,
    title: Text(
      "messages",
      style: GoogleFonts.poppins(color: green, fontSize: 30),
    ),
  );
}
