import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Color(0xffdcf8c6),
          child: const Stack(children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 20),
              child: Text(
                "dummy!! dummy!!dummy!!dummy!!dummy!!dummy!!dummy!!dummy!!dummy!!dummy!!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
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
