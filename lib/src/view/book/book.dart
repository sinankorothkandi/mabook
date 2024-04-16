import 'package:flutter/material.dart';
import 'package:mabook/src/view/const/bottomNavebar.dart';


class select_Doctore extends StatefulWidget {
  const select_Doctore({super.key});

  @override
  State<select_Doctore> createState() => _homePageState();
}

class _homePageState extends State<select_Doctore> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Find Doctore",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const SizedBox(
                  height: 48,
                  width: 47,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 115, 115, 115),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'search doctore',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 280),
            child: Text(
              'Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 232, 232, 232),
            height: 200,
            width: double.infinity,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 160),
            child: Text(
              'Recommended Doctors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 232, 232, 232),
            height: 200,
            width: double.infinity,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 190),
            child: Text(
              'Your Recent Doctors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 232, 232, 232),
            height: 120,
            width: double.infinity,
          ),
        ],
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
