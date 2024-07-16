import 'package:flutter/material.dart';
import 'package:nsc/home.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChatBotUsageWarningPage extends StatefulWidget {
  const ChatBotUsageWarningPage({super.key});

  @override
  _ChatBotUsageWarningPage createState() => _ChatBotUsageWarningPage();
}

class _ChatBotUsageWarningPage extends State<ChatBotUsageWarningPage> {
  AppTheme currentTheme = AppTheme(theme);
  late Future<String> _textFromFile;

  @override
  void initState() {
    super.initState();
    _textFromFile = _loadTextFromFile();
  }

  Future<String> _loadTextFromFile() async {
    return await rootBundle.loadString('assets/text/chatbotwarning.txt');
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = AppTheme(theme);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Usage Cautious'),
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
          ],
        ),
      ),
    );
  }
}
