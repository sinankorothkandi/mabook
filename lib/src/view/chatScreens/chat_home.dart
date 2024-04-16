import 'package:flutter/material.dart';
import 'package:mabook/src/view/const/bottomNavebar.dart';
import 'package:mabook/src/view/const/colors.dart';

class chat_Home extends StatefulWidget {
  const chat_Home({super.key});

  @override
  State<chat_Home> createState() => _chat_HomeState();
}

class _chat_HomeState extends State<chat_Home> {
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Message",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: DefaultTabController(
                length: 3,
                initialIndex: 1,
                child: Column(
                  children: [
                    TabBar(
                        dividerColor: Color.fromARGB(255, 255, 255, 255),
                        labelColor: black,
                        unselectedLabelColor:
                            Color.fromARGB(255, 166, 166, 166),
                        indicatorColor: green,
                        indicatorWeight: 4,
                        tabs: [
                          Tab(
                            child: Text(
                              'Doctors',
                            ),
                          ),
                          Tab(
                            child: Text('Hospital'),
                          ),
                          Tab(
                            child: Text('Calls'),
                          ),
                        ]),
                  ],
                )),
          )
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

  Widget tabText(String data) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(data,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}
