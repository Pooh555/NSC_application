import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nsc/home.dart';

class DiseasePage extends StatefulWidget {
  const DiseasePage(
      {super.key,
      required this.title,
      required this.infoPath,
      required this.imagePath_1,
      required this.imagePath_2,
      required this.imagePath_3});

  final String title;
  final String infoPath;
  final String imagePath_1;
  final String imagePath_2;
  final String imagePath_3;

  @override
  _DiseasePageState createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  AppTheme currentTheme = AppTheme(theme);
  late Future<String> _textFromFile;

  @override
  void initState() {
    super.initState();
    _textFromFile = _loadTextFromFile();
  }

  Future<String> _loadTextFromFile() async {
    return await rootBundle.loadString(widget.infoPath);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = AppTheme(theme);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            buildInkWellWithImageAndText(widget.imagePath_1),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText(widget.imagePath_2),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText(widget.imagePath_3),
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
