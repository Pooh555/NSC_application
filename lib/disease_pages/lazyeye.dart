import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nsc/home.dart';

class LazyEyePage extends StatefulWidget {
  const LazyEyePage({super.key});

  @override
  _LazyEyePageState createState() => _LazyEyePageState();
}

class _LazyEyePageState extends State<LazyEyePage> {
  AppTheme currentTheme = AppTheme(theme);
  late Future<String> _textFromFile;

  @override
  void initState() {
    super.initState();
    _textFromFile = _loadTextFromFile();
  }

  Future<String> _loadTextFromFile() async {
    return await rootBundle.loadString('assets/text/lazyeye.txt');
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = AppTheme(theme);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Eye'),
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
            buildInkWellWithImageAndText("assets/images/lazyeye_1.jpg"),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText("assets/images/lazyeye_2.jpg"),
            const SizedBox(
              height: 25,
            ),
            buildInkWellWithImageAndText("assets/images/lazyeye_3.jpg"),
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
