import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/disease.dart';
import 'package:nsc/home.dart';
import 'package:nsc/localization/app_localizations.dart';
import 'package:nsc/localization/locale_provider.dart';
import 'package:provider/provider.dart';

class DiseasesPage extends StatefulWidget {
  const DiseasesPage({super.key});

  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  late AppTheme currentTheme;
  static const double widgetGap = 32;

  @override
  void initState() {
    super.initState();
    currentTheme = AppTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
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
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/AMD.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('AMDTitle') ??
                                'AMD',
                            DiseasePage(
                              title: 'Age-related Macular Degeneration (AMD)',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('AMD') ??
                                  'assets/text/AMD.txt',
                              imagePath_1: 'assets/images/AMD_1.jpg',
                              imagePath_2: 'assets/images/AMD_2.jpg',
                              imagePath_3: 'assets/images/AMD_3.png',
                            ),
                            AppLocalizations.of(context)?.translate('AMDDes') ??
                                'AMD damages the macular, and causes blurry vision |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/astigmatism.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('AstigmatismTitle') ??
                                'Astigmatism',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('AstigmatismTitle') ??
                                  'Astigmatism',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Astigmatism') ??
                                  'assets/text/astigmatism.txt',
                              imagePath_1: 'assets/images/astigmatism_1.jpg',
                              imagePath_2: 'assets/images/astigmatism_2.jpg',
                              imagePath_3: 'assets/images/astigmatism_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('AstigmatismDes') ??
                                'A common imperfection in the curvature of the eye |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/BCD.png',
                            AppLocalizations.of(context)
                                    ?.translate('BCDTitle') ??
                                'BCD',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('BCDTitle') ??
                                  'BCD',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('BCD') ??
                                  'assets/text/BCD.txt',
                              imagePath_1: 'assets/images/BCD_1.jpg',
                              imagePath_2: 'assets/images/BCD_2.jpg',
                              imagePath_3: 'assets/images/BCD_3.jpg',
                            ),
                            AppLocalizations.of(context)?.translate('BCDDes') ??
                                'A rare genetic disease where crystals build up in your cornea  |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/blepharitis.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('BlepharitisTitle') ??
                                'Blepharitis',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('BlepharitisTitle') ??
                                  'Blepharitis',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Blepharitis') ??
                                  'assets/text/blepharitis.txt',
                              imagePath_1: 'assets/images/blepharitis_1.jpg',
                              imagePath_2: 'assets/images/blepharitis_2.jpg',
                              imagePath_3: 'assets/images/blepharitis_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('BlepharitisDes') ??
                                'Caused by bacteria on your eyelids |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/blepharospasm.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('BlepharospasmTitle') ??
                                'Blepharospasm',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('BlepharospasmTitle') ??
                                  'Blepharospasm',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Blepharospasm') ??
                                  'assets/text/blepharospasm.txt',
                              imagePath_1: 'assets/images/blepharospasm_1.jpg',
                              imagePath_2: 'assets/images/blepharospasm_2.jpg',
                              imagePath_3: 'assets/images/blepharospasm_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('BlepharospasmDes') ??
                                'Uncontrolled eyelid movements, like twitching |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/CRVO.png',
                            AppLocalizations.of(context)
                                    ?.translate('CRVOTitle') ??
                                'CRVO',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('CRVOTitle') ??
                                  'CRVO',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('CRVO') ??
                                  'assets/text/CRVO.txt',
                              imagePath_1: 'assets/images/CRVO_1.jpg',
                              imagePath_2: 'assets/images/CRVO_2.jpg',
                              imagePath_3: 'assets/images/CRVO_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('CRVODes') ??
                                'An eye condition that affects the retina |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/cataract.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('CataractTitle') ??
                                'Cataract',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('CataractTitle') ??
                                  'Cataract',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Cataract') ??
                                  'assets/text/cataract.txt',
                              imagePath_1: 'assets/images/cataract_1.jpg',
                              imagePath_2: 'assets/images/cataract_2.png',
                              imagePath_3: 'assets/images/cataract_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('CataractDes') ??
                                'A cloudy area in the lens of your eye |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/conjunctivitis.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('ConjunctivitisTitle') ??
                                'Conjunctivitis',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('ConjunctivitisTitle') ??
                                  'Conjunctivitis',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Conjunctivitis') ??
                                  'assets/text/conjunctivits.txt',
                              imagePath_1: 'assets/images/conjunctivitis_1.jpg',
                              imagePath_2: 'assets/images/conjunctivitis_2.jpg',
                              imagePath_3: 'assets/images/conjunctivitis_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('ConjunctivitisDes') ??
                                'An inflammation or infection of the transparent membrane |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/glaucoma.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('GlaucomaTitle') ??
                                'Glaucoma',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('GlaucomaTitle') ??
                                  'Glaucoma',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Glaucoma') ??
                                  'assets/text/glaucoma.txt',
                              imagePath_1: 'assets/images/glaucoma_1.jpg',
                              imagePath_2: 'assets/images/glaucoma_2.jpg',
                              imagePath_3: 'assets/images/glaucoma_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('GlaucomaDes') ??
                                'Caused by damage to your optic nerve |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/lazyeye.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('LazyEyeTitle') ??
                                'Lazy Eye',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('LazyEyeTitle') ??
                                  'Lazy Eye',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('LazyEye') ??
                                  'assets/text/lazyeye.txt',
                              imagePath_1: 'assets/images/lazyeye_1.jpg',
                              imagePath_2: 'assets/images/lazyeye_2.jpg',
                              imagePath_3: 'assets/images/lazyeye_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('LazyEyeDes') ??
                                'An abnormal visual development early in life |',
                          ),
                        ),
                        const SizedBox(height: widgetGap),
                        Container(
                          child: buildBuildWithPageNavigation(
                            context,
                            'assets/images/uveitis.jpg',
                            AppLocalizations.of(context)
                                    ?.translate('UveitisTitle') ??
                                'Uveitis',
                            DiseasePage(
                              title: AppLocalizations.of(context)
                                      ?.translate('UveitisTitle') ??
                                  'Uveitis',
                              infoPath: AppLocalizations.of(context)
                                      ?.translate('Uveitis') ??
                                  'assets/text/uveitis.txt',
                              imagePath_1: 'assets/images/uveitis_1.jpg',
                              imagePath_2: 'assets/images/uveitis_2.jpg',
                              imagePath_3: 'assets/images/uveitis_3.jpg',
                            ),
                            AppLocalizations.of(context)
                                    ?.translate('UveitisDes') ??
                                'The inflammation usually happens when an infection occurs. |',
                          ),
                        ),
                        const SizedBox(height: widgetGap + 75),
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
        );
      },
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

  Widget buildInkWellWithImageAndText(
    String imagePath,
    String title,
    VoidCallback onTap,
    String description,
  ) {
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
                    text: buildTextWithShadow(
                      title,
                      useFontFamily,
                      fontSize_2,
                      AppTheme.textColor_2,
                      0.5,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: buildTextWithShadow(
                        description,
                        useFontFamily,
                        fontSize_4,
                        AppTheme.textColor_2,
                        0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBuildWithPageNavigation(
    BuildContext context,
    String imagePath,
    String displayText,
    Widget pageRoute,
    String description,
  ) {
    return buildInkWellWithImageAndText(
      imagePath,
      displayText,
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageRoute),
      ),
      description,
    );
  }
}
