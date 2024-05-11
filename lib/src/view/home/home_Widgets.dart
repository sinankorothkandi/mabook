import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:mabook/src/view/const/colors.dart';

//========================CarouselSlider=======================||
CarouselSlider carousilSlider() {
  return CarouselSlider(
    items: [
      Image.asset('assets/image.png'),
      Image.asset('assets/image.png'),
      Image.asset('assets/image.png'),
      Image.asset('assets/image.png'),
    ],
    options: CarouselOptions(
      height: 150,
      autoPlay: true,
      enlargeCenterPage: true,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
    ),
  );
}
//=============================================================||

//=====================search Button ===========================||

Padding SearchButton() {
  return Padding(
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
              labelText: 'search doctore,drugs,articles',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
//==============================================================||

//======================== app bar================================||

AppBar appBar() {
  return AppBar(
    title: const Row(
      children: [
        Text(
          'MA',
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        Text(
          'B',
          style: TextStyle(
              color: green, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        Text(
          'O',
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        Text(
          'OK',
          style: TextStyle(
              color: green, fontSize: 23, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Image.asset('assets/logo.png'),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.local_hospital_outlined,
            color: Colors.black,
          )),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: 26,
          ))
    ],
  );
}

//================================================================||

//======================== Top Doctors ===========================||
// Column TopDoctors() {
//   return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Top Doctors',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   width: 200,
//                 ),
//                 Text('See all', style: TextStyle(color: Colors.blue[700])),
//               ],
//             ),
//             Container(
//               color: const Color.fromARGB(255, 232, 232, 232),
//               height: 250,
//               width: double.infinity,
//             ),
//           ],
//         );
// }
//================================================================||

//======================== Helth article =========================||
Row Helth_articles() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Helth article',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 200,
      ),
      Text('See all', style: TextStyle(color: green)),
    ],
  );
}

//================================================================||


