import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/home.dart';
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
        body: Stack(children: [
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                // Use ListView for scrollable page
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 85),
                      child: buildBuildWithPageNavigation(
                          90.0,
                          0.0,
                          'assets/images/image_1.jpg',
                          'Take a picture\nof your eye.',
                          ChatBotPage(theme: theme)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 85),
                      child: buildBuildWithPageNavigation(
                          90,
                          0.0,
                          'assets/images/image_5.jpg',
                          'Upload a picture\nof your eye.',
                          ChatBotPage(theme: theme)),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ]));
  }

  // Make widget with image inside
  Widget buildInkWellWithImageAndText(
      String imagePath, String title, VoidCallback onTap) {
    return InkWell(
      splashColor: currentTheme.color_1,
      onTap: onTap,
      child: Material(
        color: currentTheme.color_2,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Ink.image(
          image: ExactAssetImage(imagePath),
          height: 250,
          width: 178,
          fit: BoxFit.cover,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 15.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: buildTextWithShadow(title, useFontFamily, fontSize_2,
                    AppTheme.textColor_2, 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build each widget
  Widget buildBuildWithPageNavigation(double distance, double bottomeDistance,
      String imagePath, String displayText, pageRoute) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: currentTheme.color_1,
        onTap: () {
          goToPage(pageRoute);
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: distance, right: distance, bottom: bottomeDistance),
          child: buildInkWellWithImageAndText(
            imagePath,
            displayText,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageRoute,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Page navigation function
  Future goToPage(pageRoute) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageRoute, // Target page
      ),
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

// Build text with shadow
TextSpan buildTextWithShadow(String text, String fontFamily, double fontSize,
    Color textColor, double shadowOpacity) {
  return TextSpan(
    text: text,
    style: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: textColor,
      shadows: [
        Shadow(
          color: AppTheme.textShadowColor_1.withOpacity(shadowOpacity),
          blurRadius: 10.0,
          offset: const Offset(3, 3),
        ),
      ],
    ),
  );
}
