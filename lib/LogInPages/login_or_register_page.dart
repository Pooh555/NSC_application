import 'package:flutter/material.dart';
import 'package:nsc/LogInPages/login_page.dart';
import 'register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
   const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // Initial with LoginPage
  bool showLoginPage = true;

  // Toggle between login & register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
