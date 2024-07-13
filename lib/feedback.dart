import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURLInBrowser() async {
  final url = Uri.parse('https://forms.gle/EkZFwbob37mirj698');
  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode
          .externalApplication, // Ensures the link is opened in a browser
    );
  } else {
    throw 'Could not launch $url';
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key, required String title});

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Page'),
      ),
      body: ListView(
        children: [
          Text(
            'Please give us any advice via this link https://forms.gle/EkZFwbob37mirj698',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: currentTheme.textColor_1,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: _launchURLInBrowser,
            child: Text(
              'คลิ๊กที่นี่เพื่อเปิดลิงค์ ("Click here to open URL")',
              style: TextStyle(
                fontSize: 16.5,
                color: currentTheme.textColor_1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Image.asset('assets/images/feedbackQR.jpg'),
        ],
      ),
    );
  }
}
