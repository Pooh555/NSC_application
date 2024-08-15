import 'dart:async';
// Import the carousel_slider package with an alias to avoid conflicts
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/diseases.dart';
import 'package:nsc/doctor.dart';
import 'package:nsc/feedback.dart';
import 'package:nsc/hospital.dart';
import 'package:nsc/localization/locale_provider.dart';
import 'package:nsc/localization/app_localizations.dart';
// import 'package:nsc/scanoption.dart';
import 'package:nsc/scan.dart';
import 'package:provider/provider.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  void _changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
    setState(() {});
  }

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
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final locale = localeProvider.locale;
        return MaterialApp(
          locale: locale, // Add this line to ensure localization
          title: 'home', // Homepage title
          theme: ThemeData(
            scaffoldBackgroundColor:
                currentTheme.color_1, // Homepage's background color
            appBarTheme: AppBarTheme(
              backgroundColor:
                  currentTheme.color_2, // AppBar's background color
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
                        buildProfileWidget('assets/images/profile.jpg', 45.0),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 190),
                                    child: buildSwitchThemeButton(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 190),
                              child: DropdownButton<String>(
                                value: Localizations.localeOf(context)
                                    .languageCode,
                                items: [
                                  DropdownMenuItem(
                                      value: 'en',
                                      child: RichText(
                                          text: const TextSpan(
                                              text: 'English',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 95, 95, 95))))),
                                  DropdownMenuItem(
                                      value: 'th',
                                      child: RichText(
                                          text: const TextSpan(
                                              text: 'ไทย',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 95, 95, 95))))),
                                ],
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    _changeLanguage(newValue);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // The rest of the Homepage
                    Expanded(
                      // Use ListView for scrollable page

                      child: ListView(
                        children: [
                          Container(
                            child: buildWelcomeText(
                                useFontFamily,
                                AppLocalizations.of(context)
                                        ?.translate('WelcomeText_1') ??
                                    'Take Care',
                                AppLocalizations.of(context)
                                        ?.translate('WelcomeText_2') ??
                                    'of your vision'),
                          ),
                          buildMainWidget(),
                          const SizedBox(
                            height: 5,
                          ),
                          buildScanWidget(AppLocalizations.of(context)
                                  ?.translate('ScanHome') ??
                              'Scan your Eye'),
                          Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: buildRowWidget(
                                  0.0,
                                  'assets/images/image_2.jpg',
                                  AppLocalizations.of(context)
                                          ?.translate('DiseaseHome') ??
                                      'Know your disease',
                                  DiseasesPage(),
                                  20.0,
                                  'assets/images/image_3.jpg',
                                  AppLocalizations.of(context)
                                          ?.translate('DoctorHome') ??
                                      'Contact Doctor',
                                  DoctorPage())),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: buildRowWidget(
                              0.0,
                              'assets/images/image_4.jpg',
                              AppLocalizations.of(context)
                                      ?.translate('HospitalHome') ??
                                  'Contact Hospital',
                              const HospitalPage(),
                              20.0,
                              'assets/images/image_5.jpg',
                              AppLocalizations.of(context)
                                      ?.translate('ContactHome') ??
                                  'Contact And Feedback',
                              const FeedbackPage(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                buildChatBotWidget(
                    AppLocalizations.of(context)?.translate('ChatBotHome') ??
                        'Ask our chatbot anything...'),
              ],
            ),
          ),
        );
      },
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

  Widget buildChatBotWidget(String displayText) {
    return Stack(
      children: [
        Positioned(
          bottom: 30,
          right: 20, // Adjusted from 15 to 20
          child: buildChatBotWidget_2(60.0, 300.0, displayText),
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

  Widget buildChatBotWidget_2(double height, double width, String displayText) {
    return Builder(
      builder: (context) => SizedBox(
        height: height,
        width: width,
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
                text: buildTextWithShadow(displayText, useFontFamily,
                    fontSize_4, AppTheme.textColor_3, 0.2),
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

  Widget buildScanWidget(String displayText) {
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
                  builder: (context) => const ScanRoute(),
                  /*
                  builder: (context) => ScanOptionPage(
                    camera: widget.camera,
                  ), 
                  */
                ),
              );
            },
            child: Material(
              color: currentTheme.color_2,
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Ink.image(
                image: const AssetImage("assets/images/image_1.jpg"),
                height: 200,
                width: 375,
                fit: BoxFit.cover,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: buildTextWithShadow(displayText, useFontFamily,
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

// List of page routes for each image
  late final List<Widget> imageRoutes = [
    const ScanRoute(),
    DiseasesPage(),
    DoctorPage(),
    const HospitalPage(),
    FeedbackPage()
  ];

  Widget buildMainWidget() {
    // List of titles for each image
    List<String> imageTitles = [
      AppLocalizations.of(context)?.translate('ScanHomeNoNL') ??
          'Scan your Eye',
      AppLocalizations.of(context)?.translate('DiseaseHomeNoNL') ??
          'Know your disease',
      AppLocalizations.of(context)?.translate('DoctorHomeNoNL') ??
          'Contact The Doctor',
      AppLocalizations.of(context)?.translate('HospitalHomeNoNL') ??
          'Contact Hospital',
      AppLocalizations.of(context)?.translate('ContactHomeNoNL') ??
          'Contact And Feedback',
      AppLocalizations.of(context)?.translate('ChatBotHomeNoNL') ??
          'Ask our chat bot anything...',
    ];

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
                  imagePaths[index], // Use 'index' instead of '_currentIndex'
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: buildTextWithShadow(
                    imageTitles[
                        index], // Use 'index' instead of '_currentIndex'
                    useFontFamily,
                    fontSize_2,
                    AppTheme.textColor_2,
                    0.5,
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: 275.0,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
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
  Widget buildWelcomeText(
      String fontFamily, String languageState_1, String languageState_2) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: languageState_1,
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: fontSize_1,
          fontStyle: FontStyle.normal,
          color: currentTheme.textColor_1,
        ),
        children: <TextSpan>[
          TextSpan(
            text: languageState_2,
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
