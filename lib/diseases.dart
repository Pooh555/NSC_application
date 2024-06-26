import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/disease_pages/cataract.dart';
import 'package:nsc/home.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select your option')),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 95),
                        child: buildBuildWithPageNavigation(
                          'assets/images/image_1.jpg',
                          'Take a picture\nof your eye.',
                          ChatBotPage(
                            theme: theme,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 95),
                        child: buildBuildWithPageNavigation(
                          'assets/images/image_5.jpg',
                          'Upload a picture\nof your eye.',
                          null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

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

  Widget buildBuildWithPageNavigation(
      String imagePath, String displayText, pageRoute) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: currentTheme.color_1,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    pageRoute)), // Navigation inside build method
        child: Center(
          child: buildInkWellWithImageAndText(
            imagePath,
            displayText,
            () => {}, // Empty callback as navigation happens on tap
          ),
        ),
      ),
    );
  }
}
