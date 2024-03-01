import "package:flutter/material.dart";
import "package:toto/screen/page1.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import "package:toto/screen/page2.dart";

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Assignment App",
      // home: Add_Widget(),
      home: Add_Widget(),
    );
  }
}
