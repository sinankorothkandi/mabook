import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:mabook/src/view/appointments/dislpay%20appointments/appointment.dart';
import 'package:mabook/src/view/chats/chat_page.dart';
import 'package:mabook/src/view/chatScreens/chat_home.dart';
import 'package:mabook/src/view/search%20screen/search_screen.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/home/home.dart';
import 'package:mabook/src/view/profile/profile%20screen/mainprofile.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchScreen(
      autoFocus: false,
    ),
    const ChatHome(),
    // const ChatPage(),
    const Appoinments(),
    const ProfileList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _pages[currentIndex],
          Align(
            alignment: Alignment.bottomRight,
            child: CrystalNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: green,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.black.withOpacity(0.1),
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                CrystalNavigationBarItem(
                    icon: EneftyIcons.home_bold,
                    unselectedIcon: EneftyIcons.home_outline),
                CrystalNavigationBarItem(
                    icon: EneftyIcons.search_normal_2_bold,
                    unselectedIcon: EneftyIcons.search_normal_2_outline),
                CrystalNavigationBarItem(
                    icon: EneftyIcons.messages_2_bold,
                    unselectedIcon: EneftyIcons.messages_2_outline),
                CrystalNavigationBarItem(
                    icon: EneftyIcons.calendar_2_bold,
                    unselectedIcon: EneftyIcons.calendar_2_outline),
                CrystalNavigationBarItem(
                  icon: EneftyIcons.profile_bold,
                  unselectedIcon: EneftyIcons.profile_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
