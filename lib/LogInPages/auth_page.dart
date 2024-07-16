import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/home.dart';
import 'login_or_register_page.dart';
import 'verification.dart';

class AuthPage extends StatelessWidget {
  final CameraDescription camera;

  const AuthPage({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.emailVerified == true) {
            return HomePage(camera: camera);
          }
          return Verificationscreen();
        } else {
          return const LoginOrRegisterPage();
        }
      },
    ));
  }
}
