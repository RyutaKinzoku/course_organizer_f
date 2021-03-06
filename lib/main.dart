import 'package:flutter/material.dart';
import 'View/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Organizer',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Login(title: 'Course Organizer'),
    );
  }
}