import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/LogInPages/auth_service.dart';
import 'package:nsc/LogInPages/login_page.dart';
import 'package:nsc/home.dart';

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
  AppTheme currentTheme = AppTheme(theme);
  late final CameraDescription camera;
  final _auth = AuthService();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _auth.sendEmailVerificationLink();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
      timer.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(onTap: togglePages)),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool showLoginPage = true;

  //between login&register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
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
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(onTap: togglePages)),
                  );
                },
                child: const Text('Back to Authentication page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
