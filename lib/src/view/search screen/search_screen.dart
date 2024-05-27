import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/doctor_controller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information.dart';

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
        centerTitle: true,
        title: const Text(
          "Find Doctor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          'Department',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Wrap(
          children: [
            departmentRetrieving(),
          ],
        ),
        const Text(
          'Recommended Doctors',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Container(
        //   width: double.infinity,
        //   height: 200,
        //   color: const Color.fromARGB(255, 219, 219, 219),
        // ),
      ],
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
                    height: MediaQuery.of(context).size.height * 0.7,
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
              width: 115,
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
