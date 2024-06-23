import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Doctor page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
