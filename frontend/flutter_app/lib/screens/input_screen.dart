import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final ageCtrl = TextEditingController();
  final bmiCtrl = TextEditingController();
  final sugarCtrl = TextEditingController();
  final systolicCtrl = TextEditingController();
  final diastolicCtrl = TextEditingController();
  final cholCtrl = TextEditingController();
  final familyIdCtrl = TextEditingController();

  String selectedState = "Tamil Nadu";

  List<String> states = [
    "Tamil Nadu", "Kerala", "Karnataka", "Andhra Pradesh", "Telangana",
    "Delhi", "Punjab", "Haryana", "Uttar Pradesh", "Uttarakhand", "Himachal Pradesh",
    "Maharashtra", "Gujarat", "Rajasthan", "Goa",
    "West Bengal", "Odisha", "Bihar", "Jharkhand",
    "Assam", "Arunachal Pradesh", "Manipur", "Mizoram", "Nagaland",
    "Tripura", "Meghalaya", "Sikkim",
    "Madhya Pradesh", "Chhattisgarh"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Inputs")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: ageCtrl, decoration: const InputDecoration(labelText: "Age")),
            TextField(controller: bmiCtrl, decoration: const InputDecoration(labelText: "BMI")),
            TextField(controller: sugarCtrl, decoration: const InputDecoration(labelText: "Sugar")),
            TextField(controller: systolicCtrl, decoration: const InputDecoration(labelText: "Systolic BP")),
            TextField(controller: diastolicCtrl, decoration: const InputDecoration(labelText: "Diastolic BP")),
            TextField(controller: cholCtrl, decoration: const InputDecoration(labelText: "Cholesterol")),
            DropdownButtonFormField(
              value: selectedState,
              items: states.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => selectedState = v.toString()),
              decoration: const InputDecoration(labelText: "State"),
            ),
            TextField(controller: familyIdCtrl, decoration: const InputDecoration(labelText: "Family ID")),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var response = await ApiService.predictDisease(
                  age: ageCtrl.text,
                  bmi: bmiCtrl.text,
                  sugar: sugarCtrl.text,
                  systolicBp: systolicCtrl.text,
                  diastolicBp: diastolicCtrl.text,
                  cholesterol: cholCtrl.text,
                  state: selectedState,
                  familyId: familyIdCtrl.text,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      results: response,
                      age: ageCtrl.text,
                      bmi: bmiCtrl.text,
                      sugar: sugarCtrl.text,
                      systolicBp: systolicCtrl.text,
                      diastolicBp: diastolicCtrl.text,
                      cholesterol: cholCtrl.text,
                      state: selectedState,
                      familyId: familyIdCtrl.text,
                    ),
                  ),
                );
              },
              child: const Text("Predict"),
            )
          ],
        ),
      ),
    );
  }
}
