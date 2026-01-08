import 'package:flutter/material.dart';
import 'logic_screen.dart';

class ResultScreen extends StatelessWidget {
  final Map results;
  final String age;
  final String bmi;
  final String sugar;
  final String systolicBp;
  final String diastolicBp;
  final String cholesterol;
  final String state;
  final String familyId;

  const ResultScreen({
    super.key,
    required this.results,
    required this.age,
    required this.bmi,
    required this.sugar,
    required this.systolicBp,
    required this.diastolicBp,
    required this.cholesterol,
    required this.state,
    required this.familyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prediction Results")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Predicted Diseases:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            ...results["diseases"].entries.map(
              (e) => Text("${e.key}: ${e.value}", style: const TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LogicScreen(
                      results: results,
                      age: age,
                      bmi: bmi,
                      sugar: sugar,
                      systolicBp: systolicBp,
                      diastolicBp: diastolicBp,
                      cholesterol: cholesterol,
                      state: state,
                      familyId: familyId,
                    ),
                  ),
                );
              },
              child: const Text("View Clinical Logic"),
            ),
          ],
        ),
      ),
    );
  }
}
