import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/user_informatin_contrller.dart';
import 'package:mabook/src/user_data.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/const/shimmer_effect.dart';
import 'package:mabook/src/view/profile/profile%20screen/profile_widgets.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetailsController ctrl = Get.put(UserDetailsController());

    return Scaffold(
      backgroundColor: green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 60,
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: ctrl.fetchUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 122, 122, 122),
                      child: ShimmerEffect(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                      width: 90,
                      child: ShimmerEffect(),
                    )
                  ],
                ));
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No user data found.'));
              }
              if (snapshot.hasError) {
                return const Center(child: Icon(Icons.person));
              }
              final userData = snapshot.data!;
              final String profileImageUrl = userData['imageUrls'];
              final String userName = userData['name'];

              return Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: bodygrey,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    userName,
                    style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 70,
          ),
          ProfileItemList(context, ctrl)
        ],
      ),
    );
  }
}
