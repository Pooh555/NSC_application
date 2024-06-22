import 'package:flutter/material.dart';

const double fontSize_1 = 50;

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

  @override
  void initState() {
    super.initState();
    currentTheme = AppTheme(theme);
  }

  void toggleTheme() {
    setState(() {
      theme = (theme == "light") ? "dark" : "light";
      currentTheme = AppTheme(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      theme: ThemeData(
        scaffoldBackgroundColor: currentTheme.color_1,
        appBarTheme: AppBarTheme(
          backgroundColor: currentTheme.color_1,
          foregroundColor: currentTheme.textColor_1,
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
                GestureDetector(
                  onTap: () {
                    print("Nice");
                  },
                  child: const CircleAvatar(
                    radius: 45.0,
                    backgroundImage:
                        ExactAssetImage('assets/images/profile.jpg'),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 220), // Optional padding
                    child: SwitchTheme(
                      currentTheme: currentTheme,
                      toggleTheme: toggleTheme,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Builder(
                      builder: (context) {
                        return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Take care\n",
                            style: TextStyle(
                              fontFamily: 'Fira_Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: fontSize_1,
                              fontStyle: FontStyle.normal,
                              color: currentTheme.textColor_1,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'of your vision',
                                style: TextStyle(
                                  fontFamily: 'Fira_Sans',
                                  fontWeight: FontWeight.w200,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchTheme extends StatelessWidget {
  const SwitchTheme(
      {super.key, required this.currentTheme, required this.toggleTheme});

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
