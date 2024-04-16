// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/appointments/appointment.dart';
import 'package:mabook/src/view/book/book.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/home.dart';
import 'package:mabook/src/view/profile/mainprofile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: black,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedItemColor: green,
          unselectedItemColor: const Color.fromARGB(255, 211, 211, 211),
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == 0) {
              Get.offAll(() => const homePage());
            } else if (index == 1) {
              Get.offAll(() => const select_Doctore());
            } else if (index == 2) {
              Get.offAll(() => const appoinments());
            } else if (index == 3) {
              Get.offAll(() => const profile_list());
            }
            //else {
            //   onTap(index);
            // }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 35,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.email_outlined, size: 32),
              label: 'book',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded, size: 35),
              label: 'appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 35),
              label: 'profile',
            ),
          ],
        ),
      ],
    );
  }
}
