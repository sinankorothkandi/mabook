import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/controller/login&signin/signUn_Auth.dart';
import 'package:mabook/src/view/chats/chatting_screen/components/appbar.dart';
import 'package:mabook/src/view/chats/chatting_screen/components/chat_bubble.dart';
import 'package:mabook/src/view/const/colors.dart';


// ignore: must_be_immutable
class ChattingScreen extends StatefulWidget {
  ChattingScreen(
      {super.key, required this.friendId});
  String friendId;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final chatCtrl = Get.put(ChatController());
  final authCtrl = Get.put(AuthController());
  List data = ['User name unavailable', null, '', ''];
  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  fetchUserData() async {
    data = await authCtrl.getUserDetailsByUId(widget.friendId);
    appbar(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double initialX = 0.0;
    double finalX = 0.0;
    // chatCtrl.getChatId();
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          initialX = details.localPosition.dx;
        },
        onHorizontalDragUpdate: (details) {
          finalX = details.localPosition.dx;
        },
        onHorizontalDragEnd: (details) {
          if (finalX - initialX > 0) {
            Get.back();
          } else {
            // while swiping from right to left
          }
        },
        child: Scaffold(
          appBar: appbar(data),
          body: SingleChildScrollView(
            child: Obx(
              () => chatCtrl.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                      color: green,
                    ))
                  : ChatBubble(
                      friendID: widget.friendId,
                    ),
            ),
          ),
        ),
    ),
);
}
}