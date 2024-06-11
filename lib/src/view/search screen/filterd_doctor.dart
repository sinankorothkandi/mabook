import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information.dart';

class FilterdDoctor extends StatelessWidget {
  final String department;
  const FilterdDoctor({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctoreCollection')
          .where('department', isEqualTo: department)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final doctorDocs = snapshot.data?.docs ?? [];

        if (doctorDocs.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/not found1.jpg',
              height: MediaQuery.of(context).size.height * 0.7,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView.builder(
            itemCount: doctorDocs.length,
            itemBuilder: (context, index) {
              final doc = doctorDocs[index];
              final doctorData = doc.data() as Map<String, dynamic>;

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                        () => DoctorInformation(
                              doctorData: doctorData, doctorid: doc.id,
                            ),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: Card(
                    elevation: 3,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(doctorData['profile']),
                        ),
                        const SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 25),
                            Title(
                              color: black,
                              child: Text(
                                "Dr.${doctorData['name']}",
                                style: GoogleFonts.poppins(
                                    fontSize: 23,
                                    color: const Color.fromARGB(255, 58, 58, 58),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              doctorData.containsKey("department")
                                  ? doctorData["department"].toString()
                                  : "N/A",
                              style: GoogleFonts.poppins(
                                  fontSize: 17, color: Colors.grey),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'experience:  ${doctorData["experience"].toString()} years',
                              style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 83, 83, 83)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
