import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/disease_pages/cataract.dart';
import 'package:nsc/home.dart';
import 'package:path/path.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases Page'),
      ),
      body: Align(
        child: ListView(
          children: [
            buildBuildWithPageNavigation(
              '/assets/images/image_1.jpg',
              'MOTHERFUCKER',
              const CataractPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBuildWithPageNavigation(
      String imagePath, String displayText, pageRoute) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: currentTheme.color_1,
        onTap: () {
          goToPage(pageRoute);
        },
        child: Center(
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

  Future goToPage(pageRoute) {
    return Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => pageRoute, // Target page
      ),
    );
  }
}
