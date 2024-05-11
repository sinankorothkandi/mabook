import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/view/const/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Find Doctore",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
       
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'search doctore',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Department',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [
                  departmentRetriving(),
                ],
              ),
              const Text(
                'Recommended Doctors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                color: const Color.fromARGB(255, 232, 232, 232),
                height: 200,
                width: double.infinity,
              ),
              const Text(
                'Your Recent Doctors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                color: const Color.fromARGB(255, 232, 232, 232),
                height: 120,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),

    );
  }

  StreamBuilder<QuerySnapshot<Object?>> departmentRetriving() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('departments').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final departmentDocs = snapshot.data!.docs;
        return Wrap(
          children: departmentDocs.map((doc) {
            final departmentData = doc.data() as Map<String, dynamic>;
            final departmentName = departmentData['Departmentname'];

            return SizedBox(
              height: 90,
              width: 120,
              child: Card(
                elevation: 0,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.heartPulse,
                      color: green,
                      size: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      departmentName,
                      style: GoogleFonts.poppins(color: grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
