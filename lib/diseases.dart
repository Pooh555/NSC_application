import 'package:flutter/material.dart';
import 'package:nsc/disease.dart';
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
                          'assets/images/AMD.jpg',
                          'AMD',
                          const DiseasePage(
                              title: 'Age-related Macular Degeneration (AMD)',
                              infoPath: 'assets/text/AMD.txt',
                              imagePath_1: 'assets/images/AMD_1.jpg',
                              imagePath_2: 'assets/images/AMD_2.jpg',
                              imagePath_3: 'assets/images/AMD_3.png'),
                          "AMD damages the macular, and causes blurry vision |"),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/astigmatism.jpg',
                          'Astigmatism',
                          const DiseasePage(
                              title: 'Astigmatism',
                              infoPath: 'assets/text/astigmatism.txt',
                              imagePath_1: 'assets/images/astigmatism_1.jpg',
                              imagePath_2: 'assets/images/astigmatism_2.jpg',
                              imagePath_3: 'assets/images/astigmatism_3.jpg'),
                          "A common imperfection in the curvature of the eye |"),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/cataract.jpg',
                          'Cataract',
                          const DiseasePage(
                              title: 'Cataract',
                              infoPath: 'assets/text/cataract.txt',
                              imagePath_1: 'assets/images/cataract_1.jpg',
                              imagePath_2: 'assets/images/cataract_2.png',
                              imagePath_3: 'assets/images/cataract_3.jpg'),
                          "A cloudy area in the lens of your eye |"),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/conjunctivitis.jpg',
                          'Conjunctivitis',
                          const DiseasePage(
                              title: 'Conjunctivitis',
                              infoPath: 'assets/text/conjunctivitis.txt',
                              imagePath_1: 'assets/images/conjunctivitis_1.jpg',
                              imagePath_2: 'assets/images/conjunctivitis_2.jpg',
                              imagePath_3:
                                  'assets/images/conjunctivitis_3.jpg'),
                          "An inflammation or infection of the transparent membrane |"),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/glaucoma.jpg',
                          'Glaucoma',
                          const DiseasePage(
                              title: 'Glaucoma',
                              infoPath: 'assets/text/glaucoma.txt',
                              imagePath_1: 'assets/images/glaucoma_1.jpg',
                              imagePath_2: 'assets/images/glaucoma_2.jpg',
                              imagePath_3: 'assets/images/glaucoma_3.jpg'),
                          "Caused by a damage in your optic nerve |"),
                    ),
                    const SizedBox(
                      height: widgetGap,
                    ),
                    Container(
                      child: buildBuildWithPageNavigation(
                          context,
                          'assets/images/lazyeye.jpg',
                          'Lazy Eye',
                          const DiseasePage(
                              title: 'Lazy Eye',
                              infoPath: 'assets/text/lazyeye.txt',
                              imagePath_1: 'assets/images/lazyeye_1.jpg',
                              imagePath_2: 'assets/images/lazyeye_2.jpg',
                              imagePath_3: 'assets/images/lazyeye_3.jpg'),
                          "An abnormal visual development early in life |"),
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
      String imagePath, String title, VoidCallback onTap, String description) {
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: buildTextWithShadow(title, useFontFamily, fontSize_2,
                        AppTheme.textColor_2, 0.5),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: buildTextWithShadow(description, useFontFamily,
                          fontSize_4, AppTheme.textColor_2, 0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBuildWithPageNavigation(BuildContext context, String imagePath,
      String displayText, Widget pageRoute, String description) {
    return buildInkWellWithImageAndText(
        imagePath,
        displayText,
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pageRoute),
            ),
        description);
  }
}
