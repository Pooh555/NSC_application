import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Feedback page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
