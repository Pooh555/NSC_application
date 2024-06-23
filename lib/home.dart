import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nsc/diseases.dart';
import 'package:nsc/doctor.dart';
import 'package:nsc/feedback.dart';
import 'package:nsc/hospital.dart';
import 'package:nsc/scan.dart';
import 'profile.dart';

// List of images for ScanEye widget
final List<String> imagePaths = [
  'assets/images/image_1.jpg',
  'assets/images/image_2.jpg',
  'assets/images/image_3.jpg',
  'assets/images/image_4.jpg',
  'assets/images/image_5.jpg',
];

// Initialize theme
String theme = 'dark';
String useFontFamily = 'Fira_Sans';

// Declare font sizes
const double fontSize_1 = 50;
const double fontSize_2 = 40;
const double fontSize_3 = 35;

// Initialize Theme class (dark theme is the default theme)
class AppTheme {
  String theme = "dark"; // Set default theme as dark

  dynamic color_1; // Primary/Background color
  dynamic color_2; // Secondary color
  dynamic color_3; // Tertiary color
  dynamic textColor_1; // Primary text color
  static Color textColor_2 =
      const Color.fromARGB(255, 255, 255, 255); // Secondary text color
  static Color textShadowColor_1 =
      const Color.fromARGB(255, 0, 0, 0); // Primary text shadow color

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
          backgroundColor: currentTheme.color_2, // AppBar's background color
          foregroundColor:
              currentTheme.textColor_1, // AppBar's foreground color
          toolbarHeight: 50,
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
                ),
                buildProfileWidget('assets/images/profile.jpg', 45.0),
                // SwitchTheme button position
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 220),
                    child: buildSwitchThemeButton(),
                  ),
                ),
              ],
            ),
            // The rest of the Homepage
            Expanded(
              // Use ListView for scrollable page
              child: ListView(
                children: [
                  Container(
                    child: buildWelcomeText(useFontFamily),
                  ),
                  buildMainWidget(),
                  Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: buildRowWidget(
                          0.0,
                          'assets/images/image_2.jpg',
                          'Know\nThe\nDisease',
                          const DiseasesPage(),
                          20.0,
                          'assets/images/image_3.jpg',
                          'Contact\nThe\nDoctor',
                          const DoctorPage())),
                  Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: buildRowWidget(
                          0.0,
                          'assets/images/image_4.jpg',
                          'Contact\nHospital',
                          const HospitalPage(),
                          20.0,
                          'assets/images/image_5.jpg',
                          'Contact\nAnd\nFeedback',
                          const FeedbackPage())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build each widgets
  Widget buildBuildWithPageNavigation(
      double leftDistance, String imagePath, String displayText, pageRoute) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: currentTheme.color_1,
        onTap: () {
          goToPage(pageRoute);
        },
        child: Padding(
          padding: EdgeInsets.only(left: leftDistance),
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
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 15.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: buildTextWithShadow(title, useFontFamily, fontSize_3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMainWidget() {
    return Padding(
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
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: buildTextWithShadow(
                        'Scan Your Eye', useFontFamily, fontSize_2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build profile widget
  Widget buildProfileWidget(String profilePath, double radius) {
    return Builder(
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
        child: CircleAvatar(
          radius: radius, // Icon size
          backgroundImage: // User's profile image path
              ExactAssetImage(profilePath),
        ),
      ),
    );
  }

  // Build row widget made out of 2 subwidgets
  Widget buildRowWidget(
      double leftDistance_1,
      String imagePath_1,
      String displayText_1,
      pageRoute_1,
      double leftDistance_2,
      String imagePath_2,
      String displayText_2,
      pageRoute_2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Widget "Contact Hospital"
        buildBuildWithPageNavigation(
            leftDistance_1, imagePath_1, displayText_1, pageRoute_1),
        // Widget "Contact And Feedback"
        buildBuildWithPageNavigation(
            leftDistance_2, imagePath_2, displayText_2, pageRoute_2),
      ],
    );
  }

  // Build SwitchTheme button
  Widget buildSwitchThemeButton() {
    return SwitchTheme(
      currentTheme: currentTheme,
      toggleTheme: toggleTheme,
    );
  }

  // Build welcome text
  Widget buildWelcomeText(String fontFamily) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Take care\n",
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: fontSize_1,
          fontStyle: FontStyle.normal,
          color: currentTheme.textColor_1,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'of your vision',
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w100,
              fontSize: fontSize_1,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
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

// Build text with shadow
TextSpan buildTextWithShadow(String text, String fontFamily, double fontSize) {
  return TextSpan(
    text: text,
    style: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: AppTheme.textColor_2,
      shadows: [
        Shadow(
          color: AppTheme.textShadowColor_1.withOpacity(0.5),
          blurRadius: 10.0,
          offset: const Offset(3, 3),
        ),
      ],
    ),
  );
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
