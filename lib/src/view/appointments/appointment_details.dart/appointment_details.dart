import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/appointmentcon.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              profileSection(doctorData),
              const SizedBox(height: 46),
              Text(
                'Disease',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                appointmentData?['disease'],
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
                        'Date',
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
                            appointmentData?['date'],
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        'Token No',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        appointmentData?['token'],
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Payment Details',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Paid ',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: green,
                    ),
                  ),
                  const Icon(
                    Icons.task_alt_rounded,
                    size: 20,
                    color: green,
                  )
                ],
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
              const Divider(),
              const SizedBox(height: 30),
              appointmentData?['isCompleated']
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'prescription',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          appointmentData?['prescription '],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Advance',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          appointmentData?['Advance '],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Examinations',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          appointmentData?['Examinations'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: grey,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'You can see other details after finishing the consult',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: green,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              showAlertDialog(context, ctrl);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(19)),
                              backgroundColor: green,
                            ),
                            child: const Text(
                              "Cancel the Appointment ",
                              style: TextStyle(color: white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAlertDialog(
      BuildContext context, AppoinmentController ctrl) {
    Widget continueButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        ctrl.updateappoinmentToFirebase(
            userdata, appointmentData!, doctorData, context);
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Alert Dialog'),
      content: const Text('Are you sure you need to Cancel the Appointment '),
      actions: [continueButton],
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
