import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/appointments/make%20appointment/w_make_appointment.dart';
import 'package:mabook/src/view/const/colors.dart';

class AppointmentScreen extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  const AppointmentScreen({super.key, required this.doctorData});

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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              profileSection(profilePath, doctorData),
              const SizedBox(height: 46),
              detailsDisplay(doctorData),
              Padding(
                padding: const EdgeInsets.only(top: 160),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: black,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee,
                              size: 15,
                              color: black,
                            ),
                            Text(
                              '${doctorData.containsKey("consultancyfees") ? doctorData["consultancyfees"] : "N/A"}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    bookappointment(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
