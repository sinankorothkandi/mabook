import 'package:flutter/material.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/profile/profile_widgets.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('assets/logo.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Elizabeth Blackwell',
            style: TextStyle(
                color: white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 70,
          ),
          profile_Item_List(context)
        ],
      ),
    );
  }
}
