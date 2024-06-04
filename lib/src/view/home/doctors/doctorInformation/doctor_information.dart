import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/appointments/make%20appointment/make_appointment.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/doctors/doctorInformation/doctor_information_widget.dart';

class DoctorInformation extends StatefulWidget {
  final Map<String, dynamic> doctorData;
  

  const DoctorInformation({super.key, required this.doctorData});

  @override
  _DoctorInformationState createState() => _DoctorInformationState();
}

class _DoctorInformationState extends State<DoctorInformation> {
  DateTime? selectedDate;
  String? selectedDay;
  String? selectedtoken;
  Map<String, int> selectedTokenMap =   {}; 

  @override
  void initState() {
    super.initState();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDay = DateFormat('EEEE').format(picked);
        print('Selected Date: $selectedDate');
        print('Selected Day: $selectedDay');
      });
    }
  }

  List<int> getAvailableTokens(int count) {
    return List.generate(count, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    final profilePath = widget.doctorData['profile'] ?? '';
    final Map consultingTimes = widget.doctorData['consulting_times'] ?? {};

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(color: black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.navigate_before, color: black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              profileSection(profilePath, widget.doctorData),
              const SizedBox(height: 46),
              detailsDisplay(widget.doctorData),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  selectedDate == null
                      ? 'Select a Date'
                      : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                  style: GoogleFonts.poppins(color: white),
                ),
              ),
              if (selectedDate != null && selectedDay != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Consulting Times for $selectedDay',
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w500, color: black),
                ),
                const SizedBox(height: 10),
                if (consultingTimes.containsKey(selectedDay)) ...[
                  Text(
                    'Start Time: ${consultingTimes[selectedDay]['start_time']}',
                    style: GoogleFonts.poppins(fontSize: 15, color: grey),
                  ),
                  Text(
                    'End Time: ${consultingTimes[selectedDay]['end_time']}',
                    style: GoogleFonts.poppins(fontSize: 15, color: grey),
                  ),
                  Text(
                    'Patient Count: ${consultingTimes[selectedDay]['patient_count']}',
                    style: GoogleFonts.poppins(fontSize: 15, color: grey),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select Token Number',
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: getAvailableTokens(
                            consultingTimes[selectedDay]['patient_count'])
                        .map((token) {
                      bool isSelected =
                          selectedTokenMap[selectedtoken.toString()] == token;
                      return ChoiceChip(
                        label: Text(token.toString()),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedTokenMap[selectedtoken.toString()] =
                                  token;
                            } else {
                              selectedTokenMap.remove(selectedtoken.toString());
                            }
                          });
                        },
                        selectedColor: Colors.green,
                        backgroundColor:
                            isSelected ? Colors.green : Colors.grey[200],
                        labelStyle: isSelected
                            ? const TextStyle(color: Colors.white)
                            : const TextStyle(color: Colors.black),
                      );
                    }).toList(),
                  ),
                ] else ...[
                  Text(
                    'No consulting times available for $selectedDay',
                    style: GoogleFonts.poppins(fontSize: 15, color: grey),
                  ),
                ],
              ],
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 365,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: selectedDate != null &&
                            selectedDay != null &&
                            selectedTokenMap[selectedtoken.toString()] != null
                        ? () {
                            String date =
                                DateFormat('dd-MMM-yyyy').format(selectedDate!);

                            Get.to(
                              () => AppointmentScreen(
                                doctorData: widget.doctorData,
                                selectedDate: date,
                                selectedTokens:
                                    selectedTokenMap[selectedtoken.toString()]!,
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      backgroundColor: green,
                    ),
                    child: const Text(
                      "Book Appointment",
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
