import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map res;
  ResultScreen({required this.res});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Disease Prediction Result")),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Risk Scores", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Diabetes: ${res['risks']['diabetes']}%"),
            Text("Heart Disease: ${res['risks']['heart']}%"),
            Text("Hypertension: ${res['risks']['hypertension']}%"),
            Text("Obesity: ${res['risks']['obesity']}%"),
            SizedBox(height: 20),
            Text("Recommendations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...res['recommendations'].map<Widget>((r) => Text("• $r")).toList(),
            SizedBox(height: 25),
            Text("Note: Decision support system for doctors", style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
