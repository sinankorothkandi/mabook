import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/chat/chatting_screen/chatting_screen.dart';
import 'package:mabook/src/view/const/colors.dart';

SizedBox messageBubble(DocumentSnapshot doc) {
  final chatCtrl = Get.find<ChatController>();
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return SizedBox(
    child: ListTile(
      onTap: () async {
        chatCtrl.friendId= doc['toId'];
        chatCtrl.friendName= doc['user_name'];
        await chatCtrl.getChatId();
        Get.to(
          () => const ChattingScreen(),
          transition: Transition.rightToLeft,
        );
      },
      leading: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: green, borderRadius: BorderRadius.circular(50)),
        child: const CircleAvatar(
          radius: 28,
          backgroundColor: Colors.black12,
          backgroundImage: AssetImage(
            "assets/profile.jpeg",
          ),
        ),
      ),
      title: Text(
        auth.currentUser!.uid == doc['toId']
            ? doc['friend_name']
            : doc['user_name'],
        style: GoogleFonts.poppins(),
      ),
      subtitle: Text(
        truncateWithEllipsis(15, doc['last_message'] ?? ''),
      ),
      trailing: Text(
        time,
        style: GoogleFonts.poppins(color: grey),
      ),
    ),
  );
}

String truncateWithEllipsis(int cutoff, String text) {
  return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
}
