import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  final String email;

  const GetUserName({super.key, required this.documentId, required this.email});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No data found'));
        } else {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          if (data['email'] == email) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${data['firstname']}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Surname: ${data['lastname']}',
                  style: const TextStyle(
                    fontSize: 18,
                    color:  Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Age: ${data['age']} years old',
                  style: const TextStyle(
                    fontSize: 16,
                    color:   Colors.black
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );
  }
}
