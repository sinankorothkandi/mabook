import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart' as intl;
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/const/colors.dart';

import 'message_field.dart';

// ignore: must_be_immutable
class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.friendID});
  final chatCtrl = Get.put(ChatController());
  String friendID;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: white,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
          height: MediaQuery.of(context).size.height * 0.81,
          child: StreamBuilder<QuerySnapshot>(
              stream: chatCtrl.getChats(friendID),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    "Start a new\nconversation",
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      color:grey,
                    ),
                  ));
                }
                return ListView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!.docs.map((document) {
                    var data = document.data() as Map<String, dynamic>;
                    var t = data['created_on'] == null
                        ? DateTime.now()
                        : data['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return Column(
                      crossAxisAlignment:
                          data['fromId'] == auth.currentUser!.uid
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              data['fromId'] == auth.currentUser!.uid
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: document['fromId'] ==
                                          auth.currentUser!.uid
                                      ? green
                                      : white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: green,
                                      width: 0.5)),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.7),
                                child: document['image_url'] != ""
                                    ? Image.network(document['image_url'])
                                    : Text(
                                        document['msg'],
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: document['fromId'] ==
                                                    auth.currentUser!.uid
                                                ? white
                                                : green),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: Text(
                            time,
                            style: GoogleFonts.poppins(
                                color:green,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
        ),
        messageField(context, friendID)
     ],
);
}
}