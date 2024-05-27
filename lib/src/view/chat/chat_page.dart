import 'package:flutter/material.dart';
import 'package:mabook/src/view/chat/components/chat_list.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'components/appbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      appBar: appbar(),
      body: ChatList(),
    );
  }
}
