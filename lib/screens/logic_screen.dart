import 'package:flutter/material.dart';

class LogicScreen extends StatelessWidget {
  final Map results;
  final String age, bmi, sugar, systolicBp, diastolicBp, cholesterol, state, familyId;

  const LogicScreen({
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
      appBar: AppBar(title: const Text("Clinical Logic")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Clinical Logic:\n\n"
          "Age: $age\n"
          "BMI: $bmi\n"
          "Sugar: $sugar\n"
          "BP: $systolicBp/$diastolicBp\n"
          "Cholesterol: $cholesterol\n"
          "State: $state\n"
          "Family: $familyId\n\n"
          "Risk explanation will be generated with doctor cloud integration soon.",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
