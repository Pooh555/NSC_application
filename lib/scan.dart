import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
      home: ScanPage(
        camera: camera,
      ),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class ScanPage extends StatefulWidget {
  final CameraDescription camera;

  const ScanPage({super.key, required this.camera});

  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  File? selectedImage;
  String message = "";
  bool uploading = false;

  uploadImage(String collect) async {
    if (selectedImage == null) {
      setState(() {
        message = "Please select or take a photo to upload";
      });
      return;
    }

    setState(() {
      uploading = true;
    });

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://2644-110-164-80-250.ngrok-free.app/upload"),
    );

    request.fields['Collect'] = collect;

    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      selectedImage!.path,
    ));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final resJson = jsonDecode(response.body);
        setState(() {
          message = resJson['message'];
        });
      } else {
        setState(() {
          message =
              "Failed to upload image. Server returned status code ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        message = "An error occurred: $e";
      });
    } finally {
      setState(() {
        uploading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    // Initialize the controller. This returns a Future.
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
      appBar: AppBar(title: const Text('Scan Your Eye')),
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
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();
                setState(() {
                  selectedImage = File(image.path); // Update selectedImage here
                });
                if (!context.mounted) return;
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      imagePath: image.path,
                    ),
                  ),
                );
              } catch (e) {
                // print('Error taking picture: $e');
              }
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
