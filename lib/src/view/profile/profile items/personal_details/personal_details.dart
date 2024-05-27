import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/profile/profile%20items/profile%20edit/details_edit.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<Map<String, dynamic>> fetchUserData() async {
      final uid = auth.currentUser!.uid;
      final DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      return userDoc.data() as Map<String, dynamic>;
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data found.'));
        }

        final userData = snapshot.data!;
        final String profileImageUrl = userData['imageUrls'] ?? '';
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Personal Information',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => UserDetailsEdit(
                            userData: userData,
                          ));
                    },
                    icon: const Icon(Icons.edit_outlined)),
              ],
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.navigate_before)),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profileImageUrl.isNotEmpty)
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(profileImageUrl),
                            ),
                          ),
                          Text(
                            '${userData['name'] ?? 'N/A'}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: black,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'E-mail Id',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                              fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' ${userData['email'] ?? 'N/A'}',
                          style:
                              GoogleFonts.poppins(color: black, fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Phone Number',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                              fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' +91  ${userData['number'] ?? 'N/A'}',
                          style:
                              GoogleFonts.poppins(color: black, fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Date of Birth',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                              fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' ${userData['dob'] ?? 'N/A'}',
                          style:
                              GoogleFonts.poppins(color: black, fontSize: 15),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Blood Group',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey,
                                      fontSize: 17),
                                ),
                                Text(
                                  '${userData['bloodGroup'] ?? 'N/A'}',
                                  style: GoogleFonts.poppins(
                                      color: black, fontSize: 15),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  'Gender',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey,
                                      fontSize: 17),
                                ),
                                Text(
                                  '${userData['gender'] ?? 'N/A'}',
                                  style: GoogleFonts.poppins(
                                      color: black, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Address',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                              fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' ${userData['address'] ?? 'N/A'}',
                          style:
                              GoogleFonts.poppins(color: black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
