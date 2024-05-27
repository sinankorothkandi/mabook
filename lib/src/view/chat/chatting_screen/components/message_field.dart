import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/const/colors.dart';

Row messageField(BuildContext context) {
  final chatCtrl = Get.put(ChatController());

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: const BoxDecoration(
            color: white,
          ),
          child: TextField(
            controller: chatCtrl.messageController,
            style: GoogleFonts.poppins(color: white, fontSize: 20),
            decoration: InputDecoration(
              // prefix: const SizedBox(width: 10),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    await chatCtrl.pickAndUploadImage();
                  },
                  child: const Icon(Icons.attachment_outlined)),
              suffixIconColor: green,
              hintText: "Type here ...",
              hintStyle: GoogleFonts.poppins(color: black),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
          )),
      GestureDetector(
        onTap: () {},
        child: CircleAvatar(
          radius: 25,
          backgroundColor: white,
          child: Center(
            child: IconButton(
              onPressed: () async {
                await chatCtrl.sentMessage(chatCtrl.messageController.text);
              },
              icon: const Icon(
                Icons.send,
                size: 25,
                color: green,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
