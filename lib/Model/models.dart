class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;

  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
  });
}

class ContactModel {
  String name;
  String status;
  bool select;
  ContactModel({
    required this.name,
    required this.status,
    this.select = false,
  });
}
