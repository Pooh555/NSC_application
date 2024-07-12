import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/chatbot.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log out page'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 300),
          Center(
            child: Text(
              "LOGGED IN AS: ${user.email!}\nClick the button to log out.",
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
