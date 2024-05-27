import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
        'Selected Date',
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          const Icon(
            EneftyIcons.calendar_2_outline,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'date',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: grey,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Text(
        'Disease',
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
      const SizedBox(height: 8),
      ConstrainedBox(
          // height: 45,
          constraints: const BoxConstraints(minHeight: 45, maxHeight: 250),
          child: TextFormField(
            minLines: 1,
            maxLines: null,
            // controller: ctrl.bloodGroupController.value,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                EneftyIcons.edit_outline,
              ),
              contentPadding: const EdgeInsets.only(left: 30),
              hintText: 'disease ',
              hintStyle: GoogleFonts.poppins(color: grey, fontSize: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: green, width: 3),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your disease';
              }
              return null;
            },
          )),
      const SizedBox(height: 16),
      Text(
        'Payment Detail',
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
      const SizedBox(height: 18),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(
              'Consultation',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: grey,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.currency_rupee,
              size: 15,
            ),
            Text(
              '${doctorData.containsKey("consultancyfees") ? doctorData["consultancyfees"] : "N/A"}.00',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: black,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(
              'Admin Fee',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: grey,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.currency_rupee,
              size: 15,
            ),
            Text(
              '-',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: black,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(
              'Total',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: black,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.currency_rupee,
              size: 15,
              color: green,
            ),
            Text(
              '${doctorData.containsKey("consultancyfees") ? doctorData["consultancyfees"] : "N/A"}.00',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: green,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Payment Method',
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        '..........',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: grey,
        ),
      ),
    ],
  );
}

//===================================================================================

Column bookappointment() {
  return Column(
    children: [
      SizedBox(
        width: 175,
        height: 45,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
            backgroundColor: green,
          ),
          child: const Text(
            "Book ",
            style: TextStyle(color: white, fontSize: 18),
          ),
        ),
      ),
    ],
  );
}
