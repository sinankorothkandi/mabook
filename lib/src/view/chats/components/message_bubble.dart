import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/chats/chatting_screen/chatting_screen.dart';
import 'package:mabook/src/view/const/colors.dart';

Padding messageBubble(
    String username, String imageUrl, String friendID, String friendToken) {
  final chatCtrl = Get.put(ChatController());

  return Padding(
    padding: const EdgeInsets.all(10),
    child: ListTile(
      onTap: () async {
        await chatCtrl.getOrCreateChat(auth.currentUser!.uid, friendID);
        Get.to(
          () => ChattingScreen(
            friendId: friendID,
          ),
          transition: Transition.rightToLeft,
        );
      },
      leading: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(50)),
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.black12,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
      ),
      title: Text(
        username,
        style: GoogleFonts.poppins(),
      ),
      subtitle: Text(
        "message",
        style: GoogleFonts.poppins(color:grey),
      ),
),
);
}