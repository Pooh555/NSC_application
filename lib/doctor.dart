import 'package:flutter/material.dart';
import 'package:nsc/home.dart';
import 'package:nsc/localization/app_localizations.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late AppTheme currentTheme;

  @override
  void initState() {
    super.initState();
    currentTheme = AppTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)?.translate('doctor_page_title') ??
                'Doctor Page'),
      ),
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: buildTextWithShadow(
            AppLocalizations.of(context)?.translate('Doctor') ??
                "This feature is still\nbeing developed.\nWe apologize for the inconvenience.\n:(",
            useFontFamily,
            fontSize_3,
            currentTheme.textColor_1,
            0.2,
          ),
        ),
      ),
    );
  }
}
