import 'package:flutter/material.dart';

import '../CustomUI/ButtonCard.dart';
import '../CustomUI/ContactCard.dart';
import '../Model/models.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({super.key, required this.contacts});
  List<ContactModel> contacts;
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ContactModel> contacts = [
    ContactModel(name: "mob1", status: "status1"),
    ContactModel(name: "mob2", status: "status2"),
  ];
  List<ContactModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 19),
            ),
            Text(
              "Add participants",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF128C7E),
          onPressed: () {},
          child: Icon(Icons.arrow_forward)),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (contacts[index].select == false) {
                  setState(() {
                    contacts[index].select = true;
                    groups.add(contacts[index]);
                  });
                } else {
                  setState(() {
                    contacts[index].select = false;
                    groups.remove(contacts[index]);
                  });
                }
              },
              child: ContactCard(
                contact: contacts[index],
              ),
            );
          }),
    );
  }
}
