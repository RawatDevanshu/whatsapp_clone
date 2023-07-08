import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Screens/CameraScreen.dart';
import 'package:whatsapp_clone/Screens/Homescreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans",
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Color(0xFF075E54), secondary: Color(0xFF128C7E)),
      ),
      home: HomeScreen(),
    );
  }
}
// primaryColor: Color(0xFF075E54),
//         accentColor: Color(0xFF128C7E),