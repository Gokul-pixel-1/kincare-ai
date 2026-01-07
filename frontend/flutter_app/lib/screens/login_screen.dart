import 'package:flutter/material.dart';
import 'input_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController doctorId = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: doctorId, decoration: InputDecoration(labelText: "Doctor ID")),
            TextField(controller: password, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => InputScreen()));
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
