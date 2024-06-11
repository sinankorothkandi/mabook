import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/const/colors.dart';


Row messageField(BuildContext context, String friendID) {
  final chatCtrl = Get.put(ChatController());

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: white,
          ),
          child: TextField(
            controller: chatCtrl.messageController,
            style: GoogleFonts.poppins(
                color: green, fontSize: 20),
            decoration: InputDecoration(
              prefix: const SizedBox(width: 10),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    await chatCtrl.pickAndUploadImage(friendID);
                  },
                  child: const Icon(Icons.attachment_outlined)),
              suffixIconColor:green,
              hintText: "Type here ...",
              hintStyle: GoogleFonts.poppins(color: green),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
          )),
      CircleAvatar(
        radius: 25,
        backgroundColor: green,
        child: Center(
          child: IconButton(
            onPressed: () async {
              chatCtrl.getChats(friendID);
              await chatCtrl.sentMessage(
                  chatCtrl.messageController.text, friendID);
            },
            icon: Icon(
              Icons.send,
              size: 25,
              color: white,
            ),
          ),
        ),
      ),
],
);
}