import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/chatController.dart';
import 'package:mabook/src/view/chat/chatting_screen/components/appbar.dart';
import 'package:mabook/src/view/chat/chatting_screen/components/chat_bubble.dart';
import 'package:mabook/src/view/const/colors.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final chatCtrl = Get.put(ChatController());

  @override
  dispose() {
    super.dispose();
    chatCtrl.friendId = '';
    chatCtrl.friendName = '';
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
          appBar: appbar(chatCtrl.friendName ?? ''),
          body: SingleChildScrollView(
            child: Obx(
              () => chatCtrl.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                      color:green,
                    ))
                  : ChatBubble(),
            ),
          ),
        ),
      ),
    );
  }
}
