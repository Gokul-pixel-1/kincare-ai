import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Kincare AI Doctor",
    theme: ThemeData(useMaterial3: true),
    home: LoginScreen(),
  ));
}
