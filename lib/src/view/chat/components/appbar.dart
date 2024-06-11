import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appbar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      "Messages",
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
    ),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
  );
}
