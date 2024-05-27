import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information_widget.dart';

class DoctorInformation extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  const DoctorInformation({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    final profilePath =
        doctorData.containsKey('profile') && doctorData['profile'] != null
            ? doctorData['profile']
            : '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: black,
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //             doctorController.deleteDoctor(docId);
        //       },
        //       icon: Icon(Icons.delete))
        // ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              profileSection(profilePath, doctorData),
              const SizedBox(height: 46),
              detailsDisplay(doctorData),
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: bookappointment(doctorData),
              )
            ],
          ),
        ),
      ),
    );
  }
}
