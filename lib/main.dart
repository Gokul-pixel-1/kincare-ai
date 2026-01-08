import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const KincareApp());
}

class KincareApp extends StatelessWidget {
  const KincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kincare AI",
      home: const LoginScreen(),
    );
  }
}
