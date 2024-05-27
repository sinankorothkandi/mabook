import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/user_informatin_contrller.dart';
import 'package:mabook/src/view/authentication/personal%20details/w_personal_information.dart';
import 'package:mabook/src/view/const/colors.dart';

class UserDetailsAdd extends StatelessWidget {
  const UserDetailsAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserDetailsController ctrl = Get.put(UserDetailsController());

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
          child: detailsAddingForm(ctrl, context,),
        );
      })),
    );
  }
}
