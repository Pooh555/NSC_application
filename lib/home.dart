import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nsc/diseases.dart';
import 'package:nsc/scan.dart';
import 'profile.dart';

const double fontSize_1 = 50;

// List of images for ScanEye widget
final List<String> imagePaths = [
  'assets/images/image_1.jpg',
  'assets/images/image_2.jpg',
  'assets/images/image_3.jpg',
  'assets/images/image_4.jpg',
  'assets/images/image_5.jpg',
];

// Initialize theme
String theme = "dark";

// Initialize Theme class (dark theme is the default theme)
class AppTheme {
  String theme = "dark"; // Set default theme as dark

  dynamic color_1; // Primary/Background color
  dynamic color_2; // Secondary color
  dynamic color_3; // Tertiary color
  dynamic textColor_1; // Primary text color

  // Theme object constructor
  AppTheme(String theme) {
    // Light theme
    if (theme == "light") {
      color_1 = const Color.fromARGB(255, 255, 255, 255);
      color_2 = const Color.fromARGB(255, 197, 243, 255);
      color_3 = const Color.fromARGB(255, 232, 250, 255);
      textColor_1 = const Color.fromARGB(255, 0, 0, 0);
    }
    // Dark theme
    if (theme == "dark") {
      color_1 = const Color.fromARGB(255, 43, 43, 43);
      color_2 = const Color.fromARGB(255, 138, 138, 138);
      color_3 = const Color.fromRGBO(253, 253, 253, 1);
      textColor_1 = const Color.fromARGB(255, 255, 255, 255);
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialize theme
  late AppTheme currentTheme;

  // Initialize currentTheme based on global "theme" variable
  @override
  void initState() {
    super.initState();
    currentTheme = AppTheme(theme);
    _startTimer(); // Start initial timer
  }

  int _currentIndex = 0; // Index of the current image

  // Timer to change image every 1 seconds
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => setState(() {
        _currentIndex = (_currentIndex + 1) % imagePaths.length;
      }),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel timer when the widget is disposed
    super.dispose();
  }

  // Toggle the selected theme
  void toggleTheme() {
    setState(() {
      theme = (theme == "light") ? "dark" : "light";
      currentTheme = AppTheme(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home', // Homepage title
      theme: ThemeData(
        scaffoldBackgroundColor:
            currentTheme.color_1, // Homepage's background color
        appBarTheme: AppBarTheme(
          backgroundColor: currentTheme.color_1, // AppBar's background color
          foregroundColor:
              currentTheme.textColor_1, // AppBar's foreground color
        ),
      ),
      home: Scaffold(
        body: Column(
          children: [
            // Row widget for Profile widget and SwitchTheme widget
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 160, left: 20),
                  child: SizedBox(height: 0),
                ),
                Builder(
                  // Wrap GestureDetector with Builder(To prevent exception error)
                  builder: (context) => GestureDetector(
                    onTap: () {
                      // Navigate to Profilepage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    // User's profile picture
                    child: const CircleAvatar(
                      radius: 45.0, // Icon size
                      backgroundImage: // User's profile image path
                          ExactAssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                ),
                // SwitchTheme button position
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 220),
                    child: SwitchTheme(
                      currentTheme: currentTheme,
                      toggleTheme: toggleTheme,
                    ),
                  ),
                ),
              ],
            ),
            // The rest of the Homepage
            Expanded(
              // Use ListView for scrollable page
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0), // Control ListView position
                    child: Builder(
                      builder: (context) {
                        // Text "Take care of your vision"
                        return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Take care\n",
                            style: TextStyle(
                              fontFamily: 'Fira_Sans',
                              fontWeight: FontWeight.w900,
                              fontSize: fontSize_1,
                              fontStyle: FontStyle.normal,
                              color: currentTheme.textColor_1,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'of your vision',
                                style: TextStyle(
                                  fontFamily: 'Fira_Sans',
                                  fontWeight: FontWeight.w100,
                                  fontSize: fontSize_1,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Builder(
                        builder: (context) => InkWell(
                          splashColor: currentTheme.color_1,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ScanPage(), // Replace with your target page
                              ),
                            );
                          },
                          child: Material(
                            color: currentTheme.color_2,
                            borderRadius: BorderRadius.circular(15),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Ink.image(
                              image: AssetImage(imagePaths[_currentIndex]),
                              height: 200,
                              width: 375,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => InkWell(
                            splashColor: currentTheme.color_1,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DiseasesPage(), // Replace with your target page
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Material(
                                color: currentTheme.color_2,
                                borderRadius: BorderRadius.circular(15),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Ink.image(
                                  image: const ExactAssetImage(
                                      'assets/images/image_2.jpg'),
                                  height: 300,
                                  width: 178,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => InkWell(
                            splashColor: currentTheme.color_1,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DiseasesPage(), // Replace with your target page
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Material(
                                color: currentTheme.color_2,
                                borderRadius: BorderRadius.circular(15),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Ink.image(
                                  image: const ExactAssetImage(
                                      'assets/images/image_3.jpg'),
                                  height: 300,
                                  width: 178,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SwitchTheme button
class SwitchTheme extends StatelessWidget {
  const SwitchTheme({
    super.key,
    required this.currentTheme,
    required this.toggleTheme,
  });

  final AppTheme currentTheme;
  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: theme == "light",
      activeColor: currentTheme.color_2,
      onChanged: (bool value) {
        toggleTheme();
      },
    );
  }
}
