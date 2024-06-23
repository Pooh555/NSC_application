import 'package:flutter/material.dart';

class HospitalPage extends StatelessWidget {
  const HospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Hospital page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
