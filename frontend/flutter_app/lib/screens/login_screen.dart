import 'package:flutter/material.dart';
import 'input_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController user = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_hospital, size: 90),
            SizedBox(height: 12),
            Text("Kincare AI – Doctor Login",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            TextField(
              controller: user,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InputScreen())),
              child: Text("Login", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 10),
            Text("Dummy login for MVP", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
