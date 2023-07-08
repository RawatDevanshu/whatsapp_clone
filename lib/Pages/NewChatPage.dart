import 'package:flutter/material.dart';

import '../CustomUI/ButtonCard.dart';
import '../CustomUI/ContactCard.dart';
import '../Model/models.dart';
import 'NewGroup.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  @override
  Widget build(BuildContext context) {
    List<ContactModel> contacts = [
      ContactModel(name: "mob1", status: "status1"),
      ContactModel(name: "mob2", status: "status2"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19),
            ),
            Text(
              "Num Contacts",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            padding: EdgeInsets.all(0),
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CreateGroup(contacts: contacts,)));
                },
                child: ButtonCard(
                  icon: Icons.group,
                  name: "New group",
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
              );
            }
            return ContactCard(
              contact: contacts[index - 2],
            );
          }),
    );
  }
}
