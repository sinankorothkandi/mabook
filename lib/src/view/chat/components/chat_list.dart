import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/chat/chatting_screen/chatting_screen.dart';
import 'package:mabook/src/view/chat/chatting_screen/components/chat_bubble.dart';
import 'package:mabook/src/view/chat/components/message_bubble.dart';
import 'package:mabook/src/view/const/colors.dart';

// ignore: must_be_immutable
class ChatList extends StatelessWidget {
  ChatList({super.key});
  final chatCtrl = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: StreamBuilder(
          stream: chatCtrl.getMessage(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(green),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "no messages",
                  style: GoogleFonts.poppins(
                    color: white,
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: snapshot.data!.docs.asMap().entries.map((e) {
                  int index = e.key;
                  // var document = e.value;
                  var doc = snapshot.data!.docs[index];
                  return messageBubble(doc);
                }).toList(),
              );
            }
          }),
    );
  }
}
