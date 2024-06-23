import 'package:flutter/material.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot Page'),
      ),
      body: const Center(
        child: Text(
          'This is the ChatBot page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
