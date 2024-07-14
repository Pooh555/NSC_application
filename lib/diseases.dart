import 'package:flutter/material.dart';
import 'package:nsc/disease_pages/astigmatism.dart';
import 'package:nsc/disease_pages/cataract.dart';
import 'package:nsc/disease_pages/conjunctivitis.dart';
import 'package:nsc/disease_pages/glaucoma.dart';
import 'package:nsc/disease_pages/lazyeye.dart';
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
                          context,
                          'assets/images/astigmatism.jpg',
                          'Astigmatism',
                          const AstigmatismPage()),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/cataract.jpg',
                          'Cataract',
                          const CataractPage()),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/conjunctivitis.jpg',
                          'Conjunctivitis',
                          const ConjunctivitisPage()),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/glaucoma.jpg',
                          'Glaucoma',
                          const GlaucomaPage()),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/lazyeye.jpg',
                          'Lazy Eye',
                          const LazyEyePage()),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInkWellWithImageAndText(
      String imagePath, String title, VoidCallback onTap) {
    AppTheme currentTheme = AppTheme(theme); // Move initialization here
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

  Widget buildBuildWithPageNavigation(BuildContext context, String imagePath,
      String displayText, Widget pageRoute) {
    return buildInkWellWithImageAndText(
      imagePath,
      displayText,
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageRoute),
      ),
    );
  }
}
