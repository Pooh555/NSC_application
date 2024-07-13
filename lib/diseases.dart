import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/disease_pages/cataract.dart';
import 'package:nsc/home.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  static const double widgetGap = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eye diseases')),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(
                    height: widgetGap,
                  ),
                  Container(
                    child: buildBuildWithPageNavigation(
                        'assets/images/cataract.jpg',
                        'Cataract',
                        const CataractPage()),
                  ),
                  const SizedBox(
                    height: widgetGap,
                  ),
                  Container(
                    child: buildBuildWithPageNavigation(
                        'assets/images/conjunctivitis.jpg',
                        'Conjunctivitis',
                        const CataractPage()),
                  ),
                  const SizedBox(
                    height: widgetGap,
                  ),
                  Container(
                    child: buildBuildWithPageNavigation(
                        'assets/images/glaucoma.jpg',
                        'glaucoma',
                        const CataractPage()),
                  ),
                  const SizedBox(
                    height: widgetGap,
                  ),
                ],
              ))
            ],
          ),
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
          height: 200,
          width: 350,
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
