import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

StreamBuilder<DocumentSnapshot<Object?>> streamBuilder() {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('hospitalDetails')
        .doc('unique_document_id')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
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

      final address =
          data.containsKey("address") ? data["address"] : "No address";
      final number =
          data.containsKey("number") ? data["number"].toString() : "No number";
      final about =
          data.containsKey("about") ? data["about"] : "No information";
      final List<String> times =
          data.containsKey("time") ? List<String>.from(data["time"]) : [];

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                height: 80,
                width: 220,
                child: Image.asset('assets/mabookimg.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (imageUrls.isNotEmpty)
              SizedBox(
                height: 170,
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
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: GoogleFonts.poppins(fontSize: 18, color: black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    address,
                    style: GoogleFonts.poppins(fontSize: 16, color: grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Phone",
                    style: GoogleFonts.poppins(fontSize: 18, color: black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "+91 $number",
                    style: GoogleFonts.poppins(fontSize: 16, color: grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "About",
                    style: GoogleFonts.poppins(fontSize: 18, color: black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    about,
                    style: GoogleFonts.poppins(fontSize: 16, color: grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Times",
                    style: GoogleFonts.poppins(fontSize: 18, color: black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Monday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Tuesday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Wednesday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Thursday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Friday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Saturday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Sunday",
                              style: GoogleFonts.poppins(
                                color: grey,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          ...times.map((time) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                time,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: grey),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
