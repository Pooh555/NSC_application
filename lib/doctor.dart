import 'package:flutter/material.dart';
import 'package:nsc/home.dart';

class DoctorPage extends StatelessWidget {
  DoctorPage({super.key});

  AppTheme currentTheme = AppTheme(theme);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Page'),
      ),
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: buildTextWithShadow(
              'This feature is still being developed.\nWe apologize for the inconvenience.\n:(',
              useFontFamily,
              fontSize_3,
              currentTheme.textColor_1,
              0.2),
        ),
      ),
    );
  }
}
