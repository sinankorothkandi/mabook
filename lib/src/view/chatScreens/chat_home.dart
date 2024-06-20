// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mabook/firebase.dart';
// import 'package:mabook/src/controller/chat_controller.dart';
// import 'package:mabook/src/view/chat/chatting_screen/chatting_screen.dart';
// import 'package:mabook/src/view/const/colors.dart';

// class ChatHome extends StatelessWidget {
//   const ChatHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final chatCtrl = Get.put(ChatController());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Messages",
//           style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           Center(
//             child: DefaultTabController(
//               length: 3,
//               initialIndex: 1,
//               child: Column(
//                 children: [
//                   const TabBar(
//                     dividerColor: Color.fromARGB(255, 255, 255, 255),
//                     labelColor: black,
//                     unselectedLabelColor: Color.fromARGB(255, 166, 166, 166),
//                     indicatorColor: green,
//                     indicatorWeight: 4,
//                     tabs: [
//                       Tab(child: Text('Doctors')),
//                       Tab(child: Text('Hospital')),
//                       Tab(child: Text('Calls')),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 600,
//                     width: double.infinity,
//                     child: TabBarView(
//                       children: [
//                         // Tab 1: Doctors
//                         StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('users')
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                   child: CircularProgressIndicator());
//                             }
//                             if (snapshot.hasError) {
//                               return Center(
//                                   child: Text('Error: ${snapshot.error}'));
//                             }

//                             final doctorDocs = snapshot.data?.docs ?? [];

//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 15),
//                               child: ListView.builder(
//                                 itemCount: doctorDocs.length,
//                                 itemBuilder: (context, index) {
//                                   final doc = doctorDocs[index];
//                                   final doctorData =
//                                       doc.data() as Map<String, dynamic>;

//                                   final profilePaths =
//                                       doctorData['imageUrls'] ?? [];
//                                   final profilePath = profilePaths.isNotEmpty
//                                       ? profilePaths[0]
//                                       : '';

//                                   return ListTile(
//                                       leading: profilePath.isNotEmpty
//                                           ? FutureBuilder(
//                                               future: _loadImage(profilePath),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.connectionState ==
//                                                     ConnectionState.waiting) {
//                                                   return const CircleAvatar(
//                                                     radius: 25,
//                                                     backgroundColor: bodygrey,
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   );
//                                                 } else if (snapshot.hasError) {
//                                                   return const CircleAvatar(
//                                                     backgroundColor: bodygrey,
//                                                     radius: 25,
//                                                     child: Icon(Icons.error,
//                                                         color: Colors.red),
//                                                   );
//                                                 } else {
//                                                   return CircleAvatar(
//                                                     radius: 25,
//                                                     backgroundColor: bodygrey,
//                                                     backgroundImage:
//                                                         NetworkImage(
//                                                             profilePath),
//                                                   );
//                                                 }
//                                               },
//                                             )
//                                           : const CircleAvatar(
//                                               backgroundColor: bodygrey,
//                                               radius: 25,
//                                               child: Icon(Icons.person,
//                                                   color: grey),
//                                             ),
//                                       title: Text(
//                                         doctorData['name'] ?? 'N/A',
//                                         style:
//                                             GoogleFonts.poppins(color: black),
//                                       ),
//                                       subtitle: Text(
//                                         doctorData['number']?.toString() ??
//                                             'N/A',
//                                         style: GoogleFonts.poppins(color: grey),
//                                       ),
//                                       trailing: const Icon(Icons.navigate_next),
//                                       onTap: () async {
//                                         await chatCtrl.getOrCreateChat(
//                                             auth.currentUser!.uid,
//                                             doctorData['id']);
//                                         Get.to(
//                                           () => ChattingScreen(
//                                             friendId: doc.id, friendToken:'',
//                                           ),
//                                           transition: Transition.rightToLeft,
//                                         );
//                                       });
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                         // Tab 2: Hospital (Placeholder)
//                         const Center(child: Text('Hospital tab content here')),
//                         // Tab 3: Calls (Placeholder)
//                         const Center(child: Text('Calls tab content here')),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> _loadImage(String url) async {
//     try {
//       await NetworkImage(url).evict();
//     } catch (e) {
//       throw Exception('Failed to load image');
//     }
//   }
// }
