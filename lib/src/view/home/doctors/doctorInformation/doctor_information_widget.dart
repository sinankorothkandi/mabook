import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/appointments/make%20appointment/make_appointment.dart';
import 'package:mabook/src/view/const/colors.dart';

Row profileSection(profilePath, Map<String, dynamic> doctorData) {
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

//=====================================================================================

Column detailsDisplay(Map<String, dynamic> doctorData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Education',
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '${doctorData.containsKey("education") ? doctorData["education"] : "N/A"}',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: grey,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'experience',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${doctorData.containsKey("experience") ? doctorData["experience"].toString() : "N/A"} years",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'specialize in',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                doctorData.containsKey("specializein")
                    ? doctorData["specializein"].toString()
                    : "N/A",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 70,
          )
        ],
      ),
      const SizedBox(height: 16),
      Text(
        'Professional Bio',
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '${doctorData.containsKey("bio") ? doctorData["bio"] : "N/A"}',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: grey,
        ),
      ),
    ],
  );
}

//===================================================================================

SizedBox bookappointment(Map<String, dynamic> doctorData) {
  return SizedBox(
    width: 365,
    height: 55,
    child: ElevatedButton(
      onPressed: () {
        Get.to(() => AppointmentScreen(doctorData: doctorData));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        backgroundColor: green,
      ),
      child: const Text(
        "Book Appointment",
        style: TextStyle(color: white, fontSize: 18),
      ),
    ),
  );
}
