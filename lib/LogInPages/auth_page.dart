import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/home.dart';
import 'login_or_register_page.dart';

void main() async {
  List<CameraDescription> cameras = await availableCameras();

  // Pass the first camera from the list to AuthPage
  runApp(AuthPage(camera: cameras.first));
}

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
            return HomePage(camera: camera); // Remove const here
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
