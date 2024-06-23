import 'package:flutter/material.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Diseases page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
