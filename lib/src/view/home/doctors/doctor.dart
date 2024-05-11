import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Doctors',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('doctoreCollection')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final doctorDocs = snapshot.data?.docs ?? [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView.builder(
                itemCount: doctorDocs.length,
                itemBuilder: (context, index) {
                  final doc = doctorDocs[index];
                  final doctorData = doc.data() as Map<String, dynamic>;

                  final profilePath = doctorData.containsKey('profile') &&
                          doctorData['profile'] != null
                      ? doctorData['profile']
                      : '';

                  return ListTile(
                    leading: profilePath.isNotEmpty
                        ? CircleAvatar(
                            radius: 25,
                            backgroundColor: bodygrey,
                            backgroundImage: NetworkImage(profilePath),
                          )
                        : const CircleAvatar(
                            backgroundColor: bodygrey,
                            radius: 25,
                            child: Icon(
                              Icons.person,
                              color: grey,
                            )),
                    title: Text(
                      doctorData['name'],
                      style: GoogleFonts.poppins(color: black),
                    ),
                    subtitle: Text(
                      ' ${doctorData.containsKey("department") ? doctorData["department"].toString() : "N/A"}',
                      style: GoogleFonts.poppins(color: grey),
                    ),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Get.to(() => DoctorInformation(doctorData: doctorData));
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}
