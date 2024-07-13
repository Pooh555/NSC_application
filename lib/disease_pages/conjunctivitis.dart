import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nsc/home.dart';

class ConjunctivitisPage extends StatefulWidget {
  const ConjunctivitisPage({super.key});

  @override
  ConjunctivitisPageState createState() => ConjunctivitisPageState();
}

class ConjunctivitisPageState extends State<ConjunctivitisPage> {
  AppTheme currentTheme = AppTheme(theme);
  late Future<String> _textFromFile;

  @override
  void initState() {
    super.initState();
    _textFromFile = _loadTextFromFile();
  }

  Future<String> _loadTextFromFile() async {
    return await rootBundle.loadString('assets/text/conjunctivitis.txt');
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = AppTheme(theme);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conjunctivitis Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            FutureBuilder<String>(
              future: _textFromFile,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return RichText(
                    text: buildTextWithShadow(
                      snapshot.data ?? '',
                      useFontFamily,
                      fontSize_4,
                      currentTheme.textColor_1,
                      0.2,
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText("assets/images/conjunctivitis_1.jpg"),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText("assets/images/conjunctivitis_2.jpg"),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText("assets/images/conjunctivitis_3.jpg"),
          ],
        ),
      ),
    );
  }

  Widget buildInkWellWithImageAndText(String imagePath) {
    return InkWell(
      splashColor: currentTheme.color_1,
      child: Material(
        color: currentTheme.color_2,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Ink.image(
          image: ExactAssetImage(imagePath),
          height: 250,
          width: 178,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
