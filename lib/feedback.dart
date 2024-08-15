import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nsc/home.dart';
import 'package:nsc/localization/app_localizations.dart';
import 'package:nsc/localization/locale_provider.dart';
import 'package:provider/provider.dart';

_launchURLInBrowser() async {
  final url = Uri.parse('https://forms.gle/EkZFwbob37mirj698');
  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Opens the link in a browser
    );
  } else {
    throw 'Could not launch $url';
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        final appTheme = AppTheme(theme);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)?.translate('FeedbackPageTitle') ??
                  'Feedback Page',
            ),
          ),
          body: ListView(
            children: [
              const SizedBox(height: 50),
              Text(
                AppLocalizations.of(context)?.translate('Feedback') ??
                    'We appreciate every suggestion you provide.\nYou can provide us suggestions via this link\n\nhttps://forms.gle/EkZFwbob37mirj698',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: appTheme.textColor_1,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: _launchURLInBrowser,
                child: Text(
                  AppLocalizations.of(context)?.translate('ClickHere') ??
                      "Click here to open URL",
                  style: TextStyle(
                    fontSize: 16.5,
                    color: appTheme.textColor_1,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/images/feedbackQR.jpg'),
            ],
          ),
        );
      },
    );
  }
}
