import 'package:flutter/material.dart';
import 'package:mabook/src/view/const/bottomNavebar.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/profile/profile_widgets.dart';

class profile_list extends StatefulWidget {
  const profile_list({super.key});

  @override
  State<profile_list> createState() => _profile_listState();
}

class _profile_listState extends State<profile_list> {
  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 90,
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
              height: 60,
            ),
            profile_Item_List(context)
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          }),
    );
  }
}
