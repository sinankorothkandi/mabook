import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/appointmentcon.dart';
import 'package:mabook/src/controller/chat_controller.dart';
import 'package:mabook/src/view/appointments/appointment_details.dart/w_appointment_details.dart';
import 'package:mabook/src/view/const/colors.dart';

class AppointmentDetails extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  final Map<String, dynamic>? appointmentData;
  final Map<String, dynamic> userdata;

  const AppointmentDetails(
      {super.key,
      required this.doctorData,
      required this.appointmentData,
      required this.userdata});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AppoinmentController());
    final chatCtrl = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Appointment Details',
          style: GoogleFonts.poppins(color: black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.navigate_before, color: black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: appointmentdetails(context, ctrl, chatCtrl, doctorData, appointmentData, userdata)
        ),
      ),
    );
  }

  
}
