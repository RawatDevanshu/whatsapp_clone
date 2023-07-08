import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/Screens/CameraView.dart';
import 'package:whatsapp_clone/Screens/VideoView.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _camController;
  late Future<void> cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _camController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _camController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _camController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_camController);
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Center(child: CircularProgressIndicator()));
              }
            }),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black,
              height: (MediaQuery.of(context).size.height / 100) * 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        setState(() {
                          flash = !flash;
                        });
                        flash
                            ? _camController.setFlashMode(FlashMode.torch)
                            : _camController.setFlashMode(FlashMode.off);
                      },
                      icon: Icon(
                        flash ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      )),
                  GestureDetector(
                    onLongPress: () async {
                      await _camController.startVideoRecording();
                      setState(() {
                        isRecoring = true;
                      });
                    },
                    onLongPressUp: () async {
                      XFile videopath =
                          await _camController.stopVideoRecording();
                      setState(() {
                        isRecoring = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VideoViewPage(
                                    path: videopath.path,
                                  )));
                    },
                    onTap: () {
                      if (!isRecoring) takePhoto(context);
                    },
                    child: isRecoring
                        ? Icon(
                            Icons.radio_button_on,
                            color: Colors.red,
                            size: 80,
                          )
                        : Icon(
                            Icons.panorama_fish_eye,
                            color: Colors.white,
                            size: 70,
                          ),
                  ),
                  IconButton(
                    iconSize: 30,
                    onPressed: () async {
                      setState(() {
                        iscamerafront = !iscamerafront;
                        transform = transform + pi;
                      });
                      int cameraPos = iscamerafront ? 0 : 1;
                      _camController = CameraController(
                          cameras[cameraPos], ResolutionPreset.high);
                      cameraValue = _camController.initialize();
                    },
                    icon: Transform.rotate(
                      angle: transform,
                      child: Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  )
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton.small(
              backgroundColor: Colors.transparent,
              elevation: 1,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ),
        )
      ]),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _camController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
                  path: file.path,
                )));
  }
}
