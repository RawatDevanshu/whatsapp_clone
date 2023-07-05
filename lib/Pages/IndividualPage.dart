import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Model/chat_model.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.arrow_back),
            CircleAvatar(
              radius: 20,
              child: SvgPicture.asset(
                "assets/person.svg",
                height: 36,
                width: 36,
              ),
            ),
          ]),
        ),
        title: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatModel.name,
                style: TextStyle(fontSize: 18.5),
              ),
              Text(
                "last seen",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("View contact"),
                value: "View contact",
              ),
              PopupMenuItem(
                child: Text("Media,links,and docs"),
                value: "Media,links,and docs",
              ),
              PopupMenuItem(
                child: Text("Mute notifications"),
                value: "Mute notifications",
              ),
              PopupMenuItem(
                child: Text("Diappearing messages"),
                value: "Mute notifications",
              ),
              PopupMenuItem(
                child: Text("Wallpaper"),
                value: "Wallpaper",
              ),
              PopupMenuItem(
                child: Text("More"),
                value: "More",
              ),
            ];
          }),
        ],
      ),
    );
  }
}
