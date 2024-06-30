import 'package:flutter/material.dart';

class CataractPage extends StatelessWidget {
  const CataractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cataract Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Cataract page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
