import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CustomUI/CustomCard.dart';
import 'package:whatsapp_clone/Model/models.dart';
import 'package:whatsapp_clone/Pages/NewChatPage.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = [
      ChatModel(
          name: "mob 1",
          icon: "person.svg",
          isGroup: false,
          time: "time",
          currentMessage: "currentMessage"),
      ChatModel(
          name: "mob 2",
          icon: "person.svg",
          isGroup: false,
          time: "time",
          currentMessage: "currentMessage"),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewChatPage()));
          },
          child: Icon(Icons.chat)),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(chatModel: chats[index]),
      ),
    );
  }
}
