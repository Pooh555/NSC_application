import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/home.dart';
import 'package:nsc/read%20data/get_username.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> getDocId() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      return snapshot.docs.map((document) => document.id).toList();
    } catch (e) {
      print("Error getting document IDs: $e");
      return [];
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL ?? 'https://example.com/default_avatar.png'),
              backgroundColor: cu.textColor_1.withOpacity(0.1),
            ),*/
            const SizedBox(height: 20),
            Text(
              "LOGGED IN AS: ${user.email!}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: AppTheme.textColor_2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: AppTheme.textColor_2,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<String>>(
              future: getDocId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  docIDs = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: docIDs.length, //change
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            leading: const Icon(Icons.person, color: Colors.blueAccent),
                            title: GetUserName(
                              documentId: docIDs[index],
                              email: user.email!,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
