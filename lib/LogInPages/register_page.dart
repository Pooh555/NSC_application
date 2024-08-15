import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/components/my_button.dart';
import 'package:nsc/components/my_textfield.dart';
import 'package:nsc/components/square_tile.dart';
import 'package:nsc/disclaimer.dart';
import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Add user details
        try {
          await addUserDetails(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            emailController.text.trim(),
            int.parse(_ageController.text.trim()),
          );
        } catch (e) {
          Navigator.pop(context); // Close loading dialog
          showErrorMessage("Failed to add user details: $e");
          return;
        }

        Navigator.pop(context); // Close loading dialog

        // Navigate to DisclaimerPage on successful registration
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DisclaimerPage(),
            ));
      } else {
        // Show error
        showErrorMessage("Passwords don't match.");
        Navigator.pop(context); // Close loading dialog
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog
      // Show error message
      showErrorMessage(e.message ?? "An error occurred.");
    }
  }

  Future<void> addUserDetails(
      String firstName, String lastName, String email, int age) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'age': age,
      });
      // print("User added to Firestore: $firstName, $lastName, $email, $age");
    } catch (e) {
      // print("Failed to add user to Firestore: $e");
      rethrow; // rethrow the error to be caught in signUserUp method
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Image.asset("assets/images/app_icon.png",
                    width: 150.0, height: 150.0),

                // welcome back, you've been missed!
                Text(
                  'Let\'s create an account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                // firstname textfield
                MyTextField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: _ageController,
                  hintText: 'Age',
                  obscureText: false,
                  keyboardType: TextInputType.number, // Added for numeric input
                ),
                const SizedBox(height: 20),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType:
                      TextInputType.emailAddress, // Added for email input
                ),

                const SizedBox(height: 20),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // sign up button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png',
                    ),

                    const SizedBox(width: 25),

                    // apple button
                    SquareTile(
                      onTap: () => {}, // Add functionality if needed
                      imagePath: 'assets/images/apple.png',
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
