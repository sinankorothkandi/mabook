import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

Row profileSection(Map<String, dynamic> doctorData) {
  String profilePath = doctorData['profile'];
  return Row(
    children: [
      profilePath.isNotEmpty
          ? CircleAvatar(
              backgroundColor: grey,
              backgroundImage: NetworkImage(profilePath),
              radius: 50,
            )
          : const CircleAvatar(
              backgroundColor: bodygrey,
              radius: 50,
              child: Icon(
                Icons.person,
                color: grey,
              ),
            ),
      const SizedBox(width: 26),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DR. ${doctorData['name'] ?? 'No Name'}',
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
          Text(
            '${doctorData['department'] ?? 'No department'}',
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: grey,
            ),
          ),
        ],
      ),
    ],
  );
}
