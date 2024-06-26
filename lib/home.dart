import 'dart:async';

import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/diseases.dart';
import 'package:nsc/doctor.dart';
import 'package:nsc/feedback.dart';
import 'package:nsc/hospital.dart';
import 'package:nsc/scan.dart';
import 'package:nsc/scanoption.dart';
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
const double fontSize_4 = 13;

// Initialize Theme class (dark theme is the default theme)
class AppTheme {
  String theme = "dark"; // Set default theme as dark

  late Color color_1; // Primary/Background color
  late Color color_2; // Secondary color
  late Color color_3; // Tertiary color
  late Color textColor_1; // Primary text color
  static Color textColor_2 =
      const Color.fromARGB(255, 255, 255, 255); // Secondary text color (fixed)
  static Color textColor_3 =
      const Color.fromARGB(255, 117, 117, 117); // Tertiary text color (fixed)
  static Color textShadowColor_1 =
      const Color.fromARGB(255, 0, 0, 0); // Primary text shadow color
  late Color msgSent; // Color of message sent
  late Color msgRecieve; // Color of message recieved

  // Theme object constructor
  AppTheme(String theme) {
    // Light theme
    if (theme == "light") {
      color_1 = const Color.fromARGB(255, 255, 255, 255);
      color_2 = const Color.fromARGB(255, 197, 243, 255);
      color_3 = const Color.fromARGB(255, 232, 250, 255);
      textColor_1 = const Color.fromARGB(255, 0, 0, 0);
      msgSent = const Color.fromARGB(255, 123, 173, 214);
      msgRecieve = const Color.fromARGB(255, 154, 232, 233);
    }
    // Dark theme
    if (theme == "dark") {
      color_1 = const Color.fromARGB(255, 43, 43, 43);
      color_2 = const Color.fromARGB(255, 138, 138, 138);
      color_3 = const Color.fromRGBO(253, 253, 253, 1);
      textColor_1 = const Color.fromARGB(255, 255, 255, 255);
      msgSent = const Color.fromARGB(255, 145, 145, 145);
      msgRecieve = const Color.fromARGB(255, 206, 206, 206);
    }
  }
}

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

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

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

  // Timer to change image every 3 seconds
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
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // Row widget for Profile widget and SwitchTheme widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
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
                      const SizedBox(
                        height: 5,
                      ),
                      buildScanWidget(),
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
            buildChatBotWidget(),
          ],
        ),
      ),
    );
  }

  // Build each widget
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

  Widget buildChatBotWidget() {
    return Stack(
      children: [
        Positioned(
          bottom: 30,
          right: 20, // Adjusted from 15 to 20
          child: buildChatBotWidget_2(60.0, 300.0),
        ),
        Positioned(
          bottom: 10,
          right: 20, // Adjusted from 10 to 20
          child: buildChatBotWidget_1(50.0, 'assets/images/chatbot.jpg'),
        ),
      ],
    );
  }

  // Build a ChatBot widget that user can interact with
  Widget buildChatBotWidget_1(double radius, String chatbotPath) {
    return Builder(
      // Wrap GestureDetector with Builder (to prevent exception error)
      builder: (context) => GestureDetector(
        onTap: () {
          // Navigate to ProfilePage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatBotPage(
                theme: theme,
              ),
            ),
          );
        },
        // User's profile picture
        child: CircleAvatar(
          radius: radius, // Icon size
          backgroundImage: ExactAssetImage(chatbotPath), // Profile image path
        ),
      ),
    );
  }

  Widget buildChatBotWidget_2(double height, double width) {
    return Builder(
      builder: (context) => SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FloatingActionButton(
            backgroundColor: currentTheme.color_3,
            onPressed: () {
              // Navigate to ChatBotPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatBotPage(theme: theme),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 85),
              child: RichText(
                textAlign: TextAlign.left,
                text: buildTextWithShadow('Ask our chatbot anything...',
                    useFontFamily, fontSize_4, AppTheme.textColor_3, 0.2),
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
                text: buildTextWithShadow(title, useFontFamily, fontSize_3,
                    AppTheme.textColor_2, 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildScanWidget() {
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
                  builder: (context) => ScanOptionPage(
                    camera: widget.camera,
                  ), // Replace with your target page
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
                    text: buildTextWithShadow('Scan Your Eye', useFontFamily,
                        fontSize_2, AppTheme.textColor_2, 0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // List of titles for each image
  final List<String> imageTitles = [
    'Scan Your Eye',
    'Know The Disease',
    'Contact The Doctor',
    'Contact Hospital',
    'Contact And Feedback',
  ];

// List of page routes for each image
  late final List<Widget> imageRoutes = [
    ScanOptionPage(camera: widget.camera),
    const DiseasesPage(),
    const DoctorPage(),
    const HospitalPage(),
    const FeedbackPage(),
  ];

  Widget buildMainWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () {
              // Navigate to the corresponding page when the image is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => imageRoutes[index],
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imagePaths[_currentIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Text(
                  imageTitles[_currentIndex],
                  style: TextStyle(
                    fontSize: 35.0,
                    color: currentTheme.textColor_1,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // Build profile widget
  Widget buildProfileWidget(String profilePath, double radius) {
    return Builder(
      // Wrap GestureDetector with Builder (to prevent exception error)
      builder: (context) => GestureDetector(
        onTap: () {
          // Navigate to ProfilePage
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
          backgroundImage: ExactAssetImage(profilePath), // Profile image path
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
