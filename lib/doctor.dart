import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
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
          textAlign: TextAlign.left,
          text: buildTextWithShadow(
              'This feature is still being developed.\nWe apologize for the inconvenience.\n:()',
              useFontFamily,
              fontSize_4,
              currentTheme.textColor_1,
              0.2),
        ),
      ),
    );
  }
}
