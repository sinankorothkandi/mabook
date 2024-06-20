import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/appointmentcon.dart';
import 'package:mabook/src/controller/chat_controller.dart';
import 'package:mabook/src/view/chat/chatting_screen/chatting_screen.dart';
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

Column appointmentdetails(BuildContext context, AppoinmentController ctrl,
    ChatController chatCtrl, doctorData, appointmentData,userdata) {
  return Column(
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
      dateandtoken(appointmentData),
      const SizedBox(height: 30),
      paymentdetails(doctorData),
      const Divider(),
      const SizedBox(height: 30),
      appointmentData?['isCompleated']
          ? cunselteDetails(appointmentData)
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      // width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context, ctrl, doctorData,
                              appointmentData, userdata);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19)),
                          backgroundColor: green,
                        ),
                        child: const Text(
                          "Cancel ",
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      // width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          await chatCtrl.getOrCreateChat(auth.currentUser!.uid,
                              appointmentData?['doctorid']);

                          Get.to(
                            () => ChattingScreen(
                              friendId: appointmentData?["doctorid"],
                            ),
                            transition: Transition.rightToLeft,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19)),
                          backgroundColor: green,
                        ),
                        child: const Text(
                          "chat With doctor",
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
    ],
  );
}

Column cunselteDetails(appointmentData) {
  return Column(
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
            ],
          );
}

Column paymentdetails(doctorData) {
  return Column(
      children: [
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
      ],
    );
}

Row dateandtoken(appointmentData) {
  return Row(
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
    );
}

Future<void> showAlertDialog(BuildContext context, AppoinmentController ctrl,
    doctorData, appointmentData, userdata) {
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
