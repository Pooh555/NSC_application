import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nsc/home.dart';

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
  const FeedbackPage({super.key, required this.title});
  final String title;

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  // Placeholder for your AppTheme class
  AppTheme currentTheme = AppTheme(theme);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          Text(
            'We appreciate every suggestion you provide.\nYou can provide us suggestions via this link\n\nhttps://forms.gle/EkZFwbob37mirj698',
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
              "Click here to open URL",
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
