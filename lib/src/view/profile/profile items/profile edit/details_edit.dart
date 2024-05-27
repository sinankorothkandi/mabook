import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mabook/src/controller/user_informatin_contrller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/profile/profile%20items/profile%20edit/w_personal_information_edit.dart';

class UserDetailsEdit extends StatelessWidget {
  final Map<String, dynamic> userData;
  const UserDetailsEdit({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final UserDetailsController ctrl = Get.put(UserDetailsController());

    ctrl.nameController.value.text = userData['name'];
    ctrl.numberController.value.text = userData['number'];
    ctrl.addressController.value.text = userData['address'];
    ctrl.bloodGroupController.value.text = userData['bloodGroup'];
    // ctrl.dropdownValue.value = ctrl.isImageSelected.value = userData['gender'];
    userData.containsKey('imageUrls') && userData['imageUrls'] != null;
    ctrl.imageUrls = userData['imageUrls'];
    try {
      ctrl.dob.value = userData['dob'] != null && userData['dob'].isNotEmpty
          ? DateFormat('dd-MMM-yyyy').parse(userData['dob'])
          : null;
    } catch (e) {
      print('Error parsing DOB: $e');
      ctrl.dob.value = null;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: black,
            )),
        centerTitle: true,
        title: Text(
          'Add details',
          style: GoogleFonts.poppins(color: black),
        ),
      ),
      body: SingleChildScrollView(child: Obx(() {
        return Center(
          child: detailsAddingForm(ctrl, context, userData['imageUrls']),
        );
      })),
    );
  }
}
