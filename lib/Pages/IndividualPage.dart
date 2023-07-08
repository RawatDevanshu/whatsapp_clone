import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/CustomUI/OwnMessageCard.dart';
import 'package:whatsapp_clone/CustomUI/ReplyCard.dart';
import 'package:whatsapp_clone/Model/models.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:whatsapp_clone/Screens/CameraScreen.dart';
import 'package:socket_io_client/socket_io_client.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  late Socket socket;
  late VoidCallback onTap;
  TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  FocusNode _focus = FocusNode();

  void connect() {
    //socket = io(uri);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener(() {
      if (_focus.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          onWillPop: () {
            if (emojiShowing) {
              setState(() {
                emojiShowing = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height - 140,
              child: ListView(
                shrinkWrap: true,
                children: [
                  OwnMessageCard(),
                  ReplyMessageCard(),
                  OwnMessageCard(),
                  ReplyMessageCard(),
                  OwnMessageCard(),
                  ReplyMessageCard(),
                  OwnMessageCard(),
                  ReplyMessageCard(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width - 65,
                            child: TextFormField(
                              focusNode: _focus,
                              controller: _controller,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                  hintText: "Type a message",
                                  contentPadding: EdgeInsets.all(5),
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      _focus.unfocus();
                                      _focus.canRequestFocus = false;
                                      setState(() {
                                        emojiShowing = !emojiShowing;
                                      });
                                    },
                                    icon: Icon(Icons.emoji_emotions_outlined),
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet());
                                          },
                                          icon: Icon(Icons.attach_file)),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CameraScreen()));
                                          },
                                          icon: Icon(Icons.camera_alt))
                                    ],
                                  )),
                            )),
                        CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.mic),
                        ),
                      ],
                    ),
                    Offstage(
                        offstage: !emojiShowing,
                        child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            textEditingController: _controller,
                            onBackspacePressed: _onBackspacePressed,
                            config: Config(
                              columns: 7,
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 32 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.30
                                      : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor: const Color(0xFFF2F2F2),
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              recentTabBehavior: RecentTabBehavior.RECENT,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Recents',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      "Document", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CameraScreen()));
                  }),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.insert_photo, Colors.purple, "Gallery", () {}),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.location_pin, Colors.teal, "Location", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icons, Color color, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
