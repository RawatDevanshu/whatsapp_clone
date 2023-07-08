import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.white,
          child: const Stack(children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 20),
              child: Text(
                "dummy YOUU!! dummy YOUU!!dummy YOUU!!dummy YOUU!!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 10,
              child: Row(
                children: [
                  Text(
                    "time",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.done_all,
                    size: 15,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
