import 'package:flutter/material.dart';

// Initiaize Theme class (dark theme is the default theme)
class Theme {
  final color_1 = const Color.fromARGB(255, 43, 43, 43);
  final color_2 = const Color.fromARGB(255, 138, 138, 138);
  final color_3 = const Color.fromRGBO(253, 253, 253, 1);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Initialize theme
  var currentTheme = Theme();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      theme: ThemeData(scaffoldBackgroundColor: currentTheme.color_1),
      home: const MyHomePage(title: 'home'),
    );
  }
}

// Home page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// This widget defines the state of the home page.
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /*
    return ListView(padding: const EdgeInsets.only(top: 34), children: <Widget>[
      Container(
        height: 50,
        color: Colors.amber[600],
        child: const Center(child: Text("test")),
      )
    ]);
    */

    return const Scaffold();
  }
}
