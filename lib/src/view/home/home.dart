import 'package:flutter/material.dart';
import 'package:mabook/src/view/const/bottomNavebar.dart';
import 'package:mabook/src/view/home/home_Widgets.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: Column(
          children: [
            SearchButton(),
            carousilSlider(),
            const SizedBox(
              height: 30,
            ),
            TopDoctors(),
            Helth_articles(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            }),
        floatingActionButton: floatingBotton());
  }

 

}
