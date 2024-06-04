import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/hospital%20details/w_hospital_details.dart';

class HospitalDetails extends StatelessWidget {
  const HospitalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hospital Details",
            style: GoogleFonts.poppins(
                fontSize: 18, color: black, fontWeight: FontWeight.w500)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: black,
              size: 29,
            )),
      ),
      body: streamBuilder(),
    );
  }
}
