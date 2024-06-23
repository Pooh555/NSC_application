import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';
import 'package:nsc/home.dart';

class ChatBotWarningPage extends StatelessWidget {
  const ChatBotWarningPage({super.key, required String theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot usage precautious'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.left,
          text: buildTextWithShadow(
              'Gemini may display inaccurate info, including about people, so double-check its responses. Find out more at https://support.google.com/gemini/answer/13594961?visit_id=638547562061438594-2589289274&p=privacy_help&rd=1\n\nIf you are concern about your health, please contact medical professionals ',
              useFontFamily,
              fontSize_3,
              currentTheme.textColor_1,
              0.2),
        ),
      ),
    );
  }
}
