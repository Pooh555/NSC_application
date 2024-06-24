import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nsc/scan.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ScanOptionPage(
        camera: camera,
      ),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class ScanOptionPage extends StatefulWidget {
  final CameraDescription camera;

  const ScanOptionPage({super.key, required this.camera});

  @override
  ScanOptionPageState createState() => ScanOptionPageState();
}

class ScanOptionPageState extends State<ScanOptionPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select your option')),
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 45.0),
        child: SizedBox(
          width: 100.0, // Adjust the width as needed
          height: 100.0, // Adjust the height as needed
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanPage(
                    camera: widget.camera,
                  ), // Replace with your target page
                ),
              );
            },
            shape: const CircleBorder(),
            child: const Center(
              child: Icon(
                Icons.photo_camera_outlined,
                size: 60,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // Adjust the location as needed
    );
  }

  Widget buildOptionWidget() {
    return Stack(
      children: [
        Positioned(
          child: FloatingActionButton(
            onPressed: () {},
          ),
        ),
        Positioned(
          child: FloatingActionButton(
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.file(File(imagePath)),
    );
  }
}
