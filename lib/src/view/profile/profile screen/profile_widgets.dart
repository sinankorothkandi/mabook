//======================== Profile item list ================================||

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/authentication/login%20page/loginpage.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/profile/sub%20profile/all%20appointments/all_appointment.dart';
import 'package:mabook/src/view/profile/sub%20profile/app_info.dart/appinfo.dart';
import 'package:mabook/src/view/profile/sub%20profile/privacy%20police/privacy_policy.dart';
import 'package:mabook/src/view/profile/sub%20profile/profile%20items/personal_details/personal_details.dart';
import 'package:mabook/src/view/profile/sub%20profile/terms%20and%20conditions/t_and_c.dart';
import 'package:shared_preferences/shared_preferences.dart';

Container profileItemList(BuildContext context, ctrl) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.6,
    width: double.infinity,
    decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const UserDetailsScreen());
            },
            leading: const Icon(Icons.person_outline_outlined, color: green),
            title: const Text(
              'Personal information',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {
              Get.to(
                const AllAppointmentsScreen(),
              );
            },
            leading: const Icon(Icons.list_alt_rounded, color: green),
            title: const Text(
              'appointments',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const AppInfo());
            },
            leading: const Icon(Icons.info_outline, color: green),
            title: const Text(
              'App Info',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const TermsandConditions());
            },
            leading: const Icon(Icons.contact_page, color: green),
            title: const Text(
              'Terms & Conditions',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const PrivacyPolicyScreen());
            },
            leading: const Icon(Icons.privacy_tip_outlined, color: green),
            title: const Text(
              'Privacy policy',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {
              showSignOutDialog(context);
            },
            leading: const Icon(Icons.logout, color: red),
            title: const Text(
              'Logout',
              style: TextStyle(color: red, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text('Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 18))
        ],
      ),
    ),
  );
}

//===============================================================||

//======================== Alert box=============================||
void showSignOutDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: green,
        title: const Text(
          "sign out",
          style: TextStyle(color: white),
        ),
        content: const Text('Are You Sure You Want To Signout?',
            style: TextStyle(color: white)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No', style: TextStyle(color: white))),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                signOut(context);
              },
              child: const Text('Yes', style: TextStyle(color: white)))
        ],
      );
    },
  );
}

void signOut(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginPage()));
}

//==========================================================================||