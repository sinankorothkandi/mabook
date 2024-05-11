import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/doctor_controller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctor.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information.dart';
import 'package:mabook/src/view/home/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());

    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: Stack(children: [
          Obx(() {
            return Column(
              children: [
                SearchButton(),
                carousilSlider(),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Top Doctors',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 200,
                        ),
                        // Text('See all', style: TextStyle(color: green)),
                        TextButton(
                            onPressed: () {
                              Get.to(() => const DoctorList());
                            },
                            child: const Text('See all'))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: doctorController.doctorStream.value,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            final doctorDocs = snapshot.data?.docs ?? [];

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final doc = doctorDocs[index];
                                final doctorData =
                                    doc.data() as Map<String, dynamic>;

                                final profilePath =
                                    doctorData.containsKey('profile') &&
                                            doctorData['profile'] != null
                                        ? doctorData['profile']
                                        : '';

                                return GestureDetector(
                                  onTap: () => Get.to(() => DoctorInformation(
                                      doctorData: doctorData)),
                                  child: SizedBox(
                                    height: 200,
                                    width: 150,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          profilePath.isNotEmpty
                                              ? CircleAvatar(
                                                  radius: 45,
                                                  backgroundColor: Colors.black,
                                                  backgroundImage:
                                                      NetworkImage(profilePath),
                                                )
                                              : const CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 25,
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                          const SizedBox(height: 13),
                                          Title(
                                              color: black,
                                              child: Text(
                                                "Dr.${doctorData['name']}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18, color: black),
                                              )),
                                          Text(
                                            ' ${doctorData.containsKey("department") ? doctorData["department"].toString() : "N/A"}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Helth_articles(),
              ],
            );
          }),
  
        ]),
      );
  }
}
