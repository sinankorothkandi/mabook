import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/doctor_controller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/const/shimmer_effect.dart';
import 'package:mabook/src/view/home/doctors/doctor.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information.dart';
import 'package:mabook/src/view/home/hospital%20details/hospital_details.dart';
import 'package:mabook/src/view/search%20screen/search_screen.dart';

//========================CarouselSlider=======================||
StreamBuilder<DocumentSnapshot<Object?>> streamBuilder() {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('hospitalDetails')
        .doc('unique_document_id')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: grey,
              height: 150,
              width: double.infinity,
              child: const ShimmerEffect(),
            ),
          ),
        );
      }

      if (snapshot.hasError) {
        print("Error retrieving data from Firestore: ${snapshot.error}");
        return const Center(
          child: Text("An error occurred. Please try again later."),
        );
      }

      if (!snapshot.hasData || !snapshot.data!.exists) {
        return const Center(
          child: Text("No data found. Please add data to the collection."),
        );
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;

      final List<String> imageUrls =
          data.containsKey("images") && data["images"] is List
              ? (data["images"] as List)
                  .map((url) => url.toString())
                  .where((url) => url.startsWith("http"))
                  .toList()
              : [];
      print(imageUrls);

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrls.isNotEmpty)
              SizedBox(
                height: 150,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                  ),
                  items: imageUrls.map((url) {
                    return url.startsWith("http")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : const Icon(Icons.broken_image, size: 100);
                  }).toList(),
                ),
              ),
          ],
        ),
      );
    },
  );
}
//=============================================================||

//=====================search Button ===========================||

Padding searchButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Get.to(() => const SearchScreen(autoFocus: true));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(17, 0, 0, 0),
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 13),
            Text('Search for doctors or department'),
          ],
        ),
      ),
    ),
  );
}
//==============================================================||

//======================== app bar================================||

AppBar appBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset('assets/logo.png'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'MA',
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        const Text(
          'B',
          style: TextStyle(
              color: green, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        const Text(
          'O',
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        const Text(
          'OK',
          style: TextStyle(
              color: green, fontSize: 23, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {
            Get.to(() => const HospitalDetails(),
                transition: Transition.upToDown);
          },
          icon: const Icon(
            EneftyIcons.document_outline,
            color: Colors.black,
            size: 26,
          )),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            EneftyIcons.notification_bing_outline,
            color: Colors.black,
            size: 26,
          ))
    ],
  );
}

//================================================================||

//======================== Top Doctors ===========================||

Column topdoctor(DoctorController doctorController) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Top Doctors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Get.to(() => const DoctorList());
                  // helthController.loadArticles();
                },
                child: const Text(
                  'See all',
                  style: TextStyle(color: green),
                ))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: doctorController.doctorStream.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 200,
                      width: 150,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.black,
                              child: ShimmerEffect(
                                radius: 45,
                              ),
                            ),
                            const SizedBox(height: 13),
                            Title(
                              color: black,
                              child: const ShimmerEffect(width: 90, height: 25),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final doctorDocs = snapshot.data?.docs ?? [];

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final doc = doctorDocs[index];
                  final doctorData = doc.data() as Map<String, dynamic>;

                  final profilePath = doctorData.containsKey('profile') &&
                          doctorData['profile'] != null
                      ? doctorData['profile']
                      : '';

                  return GestureDetector(
                    onTap: () =>
                        Get.to(() => DoctorInformation(doctorData: doctorData)),
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
                                    backgroundImage: NetworkImage(profilePath),
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
                              style: const TextStyle(color: Colors.grey),
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
  );
}
