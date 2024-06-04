import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/doctor_controller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information.dart';
import 'package:mabook/src/view/profile/sub%20profile/help/help.dart';
import 'package:mabook/src/view/profile/sub%20profile/profile%20items/personal_details/personal_details.dart';
import 'package:mabook/src/view/search%20screen/filterd_doctor.dart';

class SearchScreen extends StatefulWidget {
  final bool autoFocus;

  const SearchScreen({super.key, required this.autoFocus});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSerch = false;
  final DoctorController _controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Find Doctors",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              searchfield(),
              const SizedBox(
                height: 20,
              ),
              isSerch ? isSearch() : isNotSearch()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox searchfield() {
    return SizedBox(
      height: 55,
      child: TextFormField(
        onTap: () => isSerch = true,
        controller: searchController,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: green, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: green, width: 2),
          ),
          prefixIcon: const Icon(Icons.search),
          labelText: 'Search doctor',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _controller.searchdata.value = value;
          });
        },
      ),
    );
  }

  Widget isNotSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Departments',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            departmentRetrieving(),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Experienced doctor',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        experienceddoctor(),
        const SizedBox(height: 10),
        const Text(
          'Your Recent Doctors',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Recentdoctor()
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> experienceddoctor() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("doctoreCollection")
          .orderBy('experience', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: black));
        }
        if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: GoogleFonts.poppins(color: white),
          ));
        }

        final doctorDoc = snapshot.data?.docs ?? [];

        if (doctorDoc.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image.asset('assets/not found1.jpg'),
          );
        }

        final doc = doctorDoc[0];
        final doctorData = doc.data() as Map<String, dynamic>;

        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Get.to(
                    () => DoctorInformation(
                          doctorData: doctorData,
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
          ),
        );
      },
    );
  }

  Widget isSearch() {
    return StreamBuilder<QuerySnapshot>(
        // stream: _controller.doctorStream.value,
        stream: FirebaseFirestore.instance
            .collection("doctoreCollection")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: black));
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.poppins(color: white),
            ));
          }

          final doctorDoc = snapshot.data?.docs ?? [];

          final searchData = _controller.searchdata.toLowerCase();
          final filteredDocter = doctorDoc.where((doc) {
            final doctorData = doc.data() as Map<String, dynamic>;
            final title = doctorData['name'].toString().toLowerCase();

            return title.contains(searchData);
          }).toList();
          return filteredDocter.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Image.asset(
                    'assets/not found1.jpg',
                  ),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: filteredDocter.length,
                      itemBuilder: (context, index) {
                        final doc = filteredDocter[index];
                        final doctorDoc = doc.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                () => DoctorInformation(
                                      doctorData: doctorDoc,
                                    ),
                                transition: Transition.rightToLeftWithFade);
                          },
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      doctorDoc['profile'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 13),
                                Title(
                                    color: black,
                                    child: Text(
                                      "Dr.${doctorDoc['name']}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: black),
                                    )),
                                Text(
                                  ' ${doctorDoc.containsKey("department") ? doctorDoc["department"].toString() : "N/A"}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        });
  }

  StreamBuilder<QuerySnapshot<Object?>> departmentRetrieving() {
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
              height: 85,
              width: MediaQuery.of(context).size.width * 0.29,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => FilterdDoctor(department: departmentName),
                      transition: Transition.zoom,
                      duration: const Duration(milliseconds: 350));
                },
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
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
