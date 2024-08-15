import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/home.dart';
import 'login_or_register_page.dart';
import 'verification.dart';

class AuthPage extends StatelessWidget {

  const AuthPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.emailVerified == true) {
              return const HomePage(); // Updated to not pass camera
            }
            return const Verificationscreen();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
