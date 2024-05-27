import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:intl/intl.dart' as intl;

import 'message_field.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key});
  final chatCtrl = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    // chatCtrl.getChatId();
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: white,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
          height: MediaQuery.of(context).size.height * 0.81,
          child: StreamBuilder(
              stream: chatCtrl.getChats(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return ListView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!.docs.asMap().entries.map((entry) {
                    var document = entry.value;
                    var t = document['created_on'] == null
                        ? DateTime.now()
                        : document['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return Column(
                      crossAxisAlignment:
                          document['uid'] == auth.currentUser!.uid
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              document['uid'] == auth.currentUser!.uid
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                  color:
                                      document['uid'] == auth.currentUser!.uid
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
                                            color: document['uid'] ==
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
                                  MediaQuery.of(context).size.width * 0.07),
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
        messageField(context)
      ],
    );
  }
}
