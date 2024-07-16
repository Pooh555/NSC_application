import 'package:flutter/material.dart';
import 'package:nsc/LogInPages/auth_service.dart';
import 'package:nsc/LogInPages/login_page.dart';
import 'package:nsc/components/my_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = AuthService();
  final TextEditingController _email = TextEditingController();

  bool showLoginPage = true;

  // Toggle between login & register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter email to send you a password reset email"),
              const SizedBox(height: 20),
              MyTextField(
                controller: _email,
                hintText: "Enter your email",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _auth.sendPasswordResetLink(_email.text);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "An email for password reset has been sent to your email."),
                  ));
                  Navigator.pop(context);
                },
                child: const Text('Send Reset Email'),
              ),
              ElevatedButton(
                onPressed: () {
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
