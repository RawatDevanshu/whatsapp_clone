import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Screens/Homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Color(0xFF075E54), secondary: Color(0xFF128C7E)),
      ),
      home: HomeScreen(),
    );
  }
}
// primaryColor: Color(0xFF075E54),
//         accentColor: Color(0xFF128C7E),