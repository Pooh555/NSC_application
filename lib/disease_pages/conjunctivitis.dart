import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nsc/home.dart';

class CataractPage extends StatefulWidget {
  const CataractPage({super.key});

  @override
  _CataractPageState createState() => _CataractPageState();
}

class _CataractPageState extends State<CataractPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cataract Page'),
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
                      AppTheme.textColor_2,
                      0.5,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
