import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FrasesApp());
}

class FrasesApp extends StatelessWidget {
  const FrasesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Frases BD',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}