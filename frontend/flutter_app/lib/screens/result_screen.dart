import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map response;
  ResultScreen({required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediction Results")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Disease Risk Scores:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Diabetes: ${response['risks']['diabetes']}%"),
            Text("Heart Disease: ${response['risks']['heart']}%"),
            Text("Hypertension: ${response['risks']['hypertension']}%"),
            Text("Obesity: ${response['risks']['obesity']}%"),
            SizedBox(height: 20),
            Text("Doctor Recommendations:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...response['recommendations'].map<Widget>((rec) => Text("• $rec")).toList(),
            SizedBox(height: 20),
            Text("Note: This is a doctor decision-support system.", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
