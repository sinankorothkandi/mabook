import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/login&signin/signUn_Auth.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final userCtrl = Get.put(AuthController());
  // FirebaseAuth auth = FirebaseAuth.instance;
  //List<UserModel> userList = [];
  var chats = FirebaseFirestore.instance.collection("chats");
  String? chatId;
  String userId = auth.currentUser!.uid;
  String userName = auth.currentUser!.displayName ?? '';
  String? friendId;
  String? friendName;
  final picker = ImagePicker();
  var isLoading = false.obs;

  getChatId() async {
    isLoading.value = true;
    await chats
        .where(
          "users",
          isEqualTo: {
            friendId: null,
            userId: null,
          },
        )
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            // if chat room is already created then assign the id to chatId variable
            chatId = snapshot.docs.single.id;
          } else {
            // if no chat room is created then create one
            await chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': friendName,
              'user_name': userName,
              'toId': "",
              'fromId': "",
              'created_on': null,
              'last_message': "",
            }).then((value) {
              {
                chatId = value.id;
              }
            });
          }
        });
    isLoading.value = false;
  }

  sentMessage(String msg) {
    // try {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatId).update({
        "created_at": FieldValue.serverTimestamp(),
        "last_message": msg,
        "toId": friendId,
        "fromId": auth.currentUser!.uid,
      });
      // save msg in database
      chats.doc(chatId).collection("messages").doc().set({
        "created_on": FieldValue.serverTimestamp(),
        "msg": msg,
        "last_message": msg,
        "image_url": "",
        "uid": auth
            .currentUser!.uid, //uid is used to identify who sent the message
      }).then((value) {
        messageController.clear();
      });
    }
  }

  pickAndUploadImage() async {
    isLoading.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(File(pickedFile.path));
      final imageUrl = await storageRef.getDownloadURL();
      sendMessageWithImage(imageUrl);
    }
    isLoading.value = false;
  }

  sendMessageWithImage(String imageUrl) {
    isLoading.value = true;
    chats.doc(chatId).collection("messages").doc().set({
      "created_on": FieldValue.serverTimestamp(),
      "msg": "",
      "image_url": imageUrl,
      "uid": auth.currentUser!.uid,
    });
    isLoading.value = false;
  }

  getChats() {
    return chats
        .doc(chatId)
        .collection("messages")
        .orderBy("created_on", descending: true)
        .snapshots();
  }

  getMessage() {
    return chats
        .where("users.${auth.currentUser!.uid}", isEqualTo: null)
        .where("created_on", isEqualTo: null)
        .orderBy('created_on', descending: true)
        .snapshots();
}
}