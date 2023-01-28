import 'package:flutter/material.dart';
import 'package:sticky_notes_app/Pages/introductionScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterTodo',
      home: SplashPage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}

