import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nsc/components/my_button.dart';
import 'package:nsc/home.dart';

class DisclaimerPage extends StatefulWidget {

  const DisclaimerPage({super.key});

  @override
  _DisclaimerPageState createState() => _DisclaimerPageState();
}

class _DisclaimerPageState extends State<DisclaimerPage> {
  late Future<String> _textFromFile;

  @override
  void initState() {
    super.initState();
    _textFromFile = _loadTextFromFile();
  }

  Future<String> _loadTextFromFile() async {
    return await rootBundle.loadString('assets/text/disclaimer.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<String>(
          future: _textFromFile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading disclaimer.'));
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      snapshot.data!,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      text: "Sign In",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute( 
                              builder: (context) =>
                                  const HomePage(),
                        ));
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No disclaimer text found.'));
            }
          },
        ),
      ),
    );
  }
}
