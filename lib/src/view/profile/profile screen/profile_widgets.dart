//======================== Profile item list ================================||

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/authentication/login%20page/loginpage.dart';
import 'package:mabook/src/view/chat/chat_page.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/authentication/personal%20details/details_adding.dart';
import 'package:mabook/src/view/profile/profile%20items/personal_details/personal_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

Container ProfileItemList(BuildContext context, ctrl) {
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
              Get.to(() => UserDetailsScreen());
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
                const ChatPage(),
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
            onTap: () {},
            leading: const Icon(Icons.help_outline_sharp, color: green),
            title: const Text(
              'Helps',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.notifications_none_outlined, color: green),
            title: const Text(
              'Notification',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.contact_page, color: green),
            title: const Text(
              'Terms & Conditions',
              style: TextStyle(color: black, fontSize: 20),
            ),
            trailing: const Icon(Icons.navigate_next, color: green),
          ),
          ListTile(
            onTap: () {},
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