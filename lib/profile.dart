import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsc/home.dart';

String currentLanguageStr = "english";

class Language {
  String language = "english";
  late String homePageText_1;
  late String homePageText_2;
  late String homePageText_3;
  late String homePageText_4;
  late String homePageText_5;
  late String homePageText_6;
  late String homePageText_7;
  late String homePageText_8;
  late String homePageText_9;
  late String homePageText_10;
  late String homePageText_11;
  late String homePageText_12;

  Language(language) {
    if (language == "english") {
      homePageText_1 = "Take Care";
      homePageText_2 = "of your vision";
      homePageText_3 = "Scan Your Eye";
      homePageText_4 = "Know The Disease";
      homePageText_5 = "Contact The Doctor";
      homePageText_6 = "Contact Hospital";
      homePageText_7 = "Contact and Feedback";
      homePageText_8 = "Scan Your Eye";
      homePageText_9 = "Know\nThe\nDisease";
      homePageText_10 = "Contact\nThe\nDoctor";
      homePageText_11 = "Contact\nHospital";
      homePageText_12 = "Contact\nand\nFeedback";
    }
    if (language == "thai") {
      homePageText_1 = "รักษาสุขภาพ";
      homePageText_2 = "ตาของคุณ";
      homePageText_3 = "วินิจฉัยโรคตาของคุณ";
      homePageText_4 = "ทำความรู้จักโรคตาต่างๆ";
      homePageText_5 = "นัดพบแพทย์";
      homePageText_6 = "ติดต่อโรงพยาบาล";
      homePageText_7 = "ข้อเสนอแนะ";
      homePageText_8 = "วินิจฉัยโรคตาของคุณ";
      homePageText_9 = "ทำความ\nรู้จักโรค\nตาต่างๆ";
      homePageText_10 = "นัด\nพบ\nแพทย์";
      homePageText_11 = "ติดต่อ\nโรงพยาบาล";
      homePageText_12 = "เขียน\nข้อเสนอแนะ";
    }
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Language currentLanguage = Language(currentLanguageStr);
  final user = FirebaseAuth.instance.currentUser!;
  String language = "english";

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void toggleLanguage() {
    setState(() {
      language = language == "english" ? "thai" : "english";
    });
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
              "LOGGED IN AS: ${user.email!}\nClick the button here to log out\nor click the button at the \ntop right corner of your screen",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: currentTheme.textColor_1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text(
                  "Language: $language",
                  style: TextStyle(
                    fontSize: 20,
                    color: currentTheme.textColor_1,
                  ),
                ),
                Switch(
                  value: language == "thai",
                  onChanged: (bool value) {
                    toggleLanguage();
                  },
                ),
              ],
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
