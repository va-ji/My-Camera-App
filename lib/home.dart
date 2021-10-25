import 'dart:io';

import 'package:camera_app/screens/sec_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.cams,
  }) : super(key: key);

  final String title;
  final List<CameraDescription> cams;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _controller;
  late Future<void> _initController;
  int selectedCam = 0;

  void initCamera(int index) async {
    _controller = CameraController(widget.cams[index], ResolutionPreset.max);
    _initController = _controller.initialize();
  }

  @override
  void initState() {
    initCamera(selectedCam);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePic() async {
    XFile file = await _controller.takePicture();
    Logger().i(file.path);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecPage(),
          settings: RouteSettings(arguments: File(file.path)),
        ));
  }

  void _changeCam() {
    Logger().i(widget.cams.length);
    if (widget.cams.length > 1) {
      setState(() {
        selectedCam = selectedCam == 0 ? 1 : 0;
        initCamera(selectedCam);
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Picture App',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<void>(
              future: _initController,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    height: 500,
                    width: 500,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              },
            ),
            IconButton(
              onPressed: _changeCam,
              icon:
                  const Icon(Icons.switch_camera_rounded, color: Colors.black),
            ),
            ElevatedButton(
              child: const Text(
                'Capture pic',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => (Colors.green))),
              onPressed: _takePic,
            ),
          ],
        ),
      ),
    );
  }
}
