import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/LogInPages/auth_page.dart';
import 'package:nsc/LogInPages/auth_service.dart';

class Verificationscreen extends StatelessWidget {
  const Verificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EmailVerificationScreen(),
    );
  }
}

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late final CameraDescription camera;
  final _auth = AuthService();
  late Timer timer;
  void initstate() {
    super.initState();
    _auth.sendEmailVerificationLink();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
    FirebaseAuth.instance.currentUser?.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
      timer.cancel();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthPage(camera: camera)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please verify your email address.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _auth.sendEmailVerificationLink();
                },
                child: const Text('Resend Verification Email'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
