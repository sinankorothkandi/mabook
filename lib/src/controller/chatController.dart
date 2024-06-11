import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/login&signin/signUn_Auth.dart';


class ChatController extends GetxController {
  var isLoading = false.obs;
  String? chatId;
  final picker = ImagePicker();
  final authCtrl = Get.put(AuthController());

  var chatsdb = db.collection('chats');
  final messageController = TextEditingController();

  generateChatId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join("_");
  }

  getOrCreateChat(String userId1, String userId2) async {
    String chatId = generateChatId(userId1, userId2);
    this.chatId = chatId;
    DocumentReference chatDoc = chatsdb.doc(chatId);

    DocumentSnapshot snapshot = await chatDoc.get();
    await addUserToChatWithList(userId2);
    if (!snapshot.exists) {
      await chatDoc.set({
        'userIds': [userId1, userId2],
        'createdAt': '',
        'last_message': "",
      });
    }
    return chatId;
  }

  addUserToChatWithList(String uid) async {
    CollectionReference users = db.collection('users');

    QuerySnapshot userQuerySnapshot =
        await users.where('id', isEqualTo: auth.currentUser!.uid).get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userQuerySnapshot.docs.first;
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      List chatWith = data['chatWith'];
      if (!chatWith.contains(uid)) {
        chatWith.add(uid);
        await users.doc(userDoc.id).update({'chatWith': chatWith});
      }
    }

    QuerySnapshot querySnapshot = await users.where('id', isEqualTo: uid).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      List chatWith = data['chatWith'];
      if (!chatWith.contains(auth.currentUser!.uid)) {
        chatWith.add(auth.currentUser!.uid);
        await users.doc(userDoc.id).update({'chatWith': chatWith});
      }
    } else {
      Get.snackbar("Error", "No user found with id: $uid");
      Get.back();
    }
  }

  sentMessage(String msg, String friendID, String? friendToken) {
    try {
      if (msg.trim().isNotEmpty) {
        chatsdb.doc(chatId).update({
          'createdAt': FieldValue.serverTimestamp(),
          'last_message': msg,
        });
        chatsdb.doc(chatId).collection('messages').doc().set({
          "created_on": FieldValue.serverTimestamp(),
          "msg": msg,
          "last_message": msg,
          "image_url": "",
          "fromId": auth.currentUser!.uid,
          "toID": friendID,
        }).then((value) {
          // PushNotificationService().sendNotification(friendToken);
          messageController.clear();
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  pickAndUploadImage(String friendID) async {
    isLoading.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(File(pickedFile.path));
      final imageUrl = await storageRef.getDownloadURL();
      sendMessageWithImage(imageUrl, friendID);
    }
    isLoading.value = false;
  }

  sendMessageWithImage(String imageUrl, String friendID) {
    isLoading.value = true;
    chatsdb.doc(chatId).collection("messages").doc().set({
      "created_on": FieldValue.serverTimestamp(),
      "msg": "",
      "last_message": "📷",
      "image_url": imageUrl,
      "fromId": auth.currentUser!.uid,
      "toID": friendID,
    });
    isLoading.value = false;
  }

  getMessages() {
    return chatsdb.snapshots();
  }

  Stream<QuerySnapshot> getChats(String friendID) {
    return chatsdb
        .doc(chatId)
        .collection('messages')
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  Future<List<List<dynamic>>> getListChatWith() async {
    QuerySnapshot querySnapshot = await db
        .collection('users')
        .where('id', isEqualTo: auth.currentUser!.uid)
        .get();
    List<List<dynamic>> result = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        for (int i = 0; i < data['chatWith'].length; i++) {
          final list = await authCtrl.getUserDetailsByUId(data['chatWith'][i]);
          result.add(list);
        }
      }
    }
    return result;
  }

}
