import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/home.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = AppTheme(theme);

    return Scaffold(
      appBar: AppBar(title: const Text('Log out page'), actions: [
        IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
      ]),
      body: ListView(
        children: [
          const SizedBox(height: 300),
          Center(
            child: Text(
              "LOGGED IN AS: ${user.email!}\nClick the button here to log out\nor click the botton at the \ntop right corner of your screen",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: currentTheme.textColor_1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 100,
            height: 100,
            child: IconButton(
              onPressed: signUserOut,
              iconSize: 120,
              icon: Icon(
                Icons.logout,
                color: currentTheme.textColor_1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
