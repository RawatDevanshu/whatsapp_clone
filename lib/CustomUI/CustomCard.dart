import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Model/chat_model.dart';
import 'package:whatsapp_clone/Pages/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IndividualPage(
                  chatModel: chatModel,
                )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                "assets/person.svg",
                height: 37,
                width: 37,
                color: Colors.white,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(children: [
              Icon(Icons.done_all),
              Text(
                chatModel.currentMessage,
                style: TextStyle(fontSize: 13),
              )
            ]),
            trailing: Text(chatModel.time),
          ),
        ],
      ),
    );
  }
}
