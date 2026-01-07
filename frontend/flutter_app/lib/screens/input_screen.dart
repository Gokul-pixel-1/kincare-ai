import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();
  final TextEditingController bpController = TextEditingController();

  bool useApi = false;

  void submitData() async {
    if (!useApi) {
      var dummyResponse = {
        "risks": {"diabetes": 45, "heart": 25, "hypertension": 35, "obesity": 60},
        "recommendations": ["Walk 30 mins daily", "Reduce sugar", "BP check weekly"]
      };
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(response: dummyResponse)),
      );
    } else {
      var response = await ApiService.predictDisease(
        age: int.parse(ageController.text),
        bmi: double.parse(bmiController.text),
        sugar: double.parse(sugarController.text),
        bp: double.parse(bpController.text),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(response: response)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Patient Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: ageController, decoration: InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
            TextField(controller: bmiController, decoration: InputDecoration(labelText: "BMI"), keyboardType: TextInputType.number),
            TextField(controller: sugarController, decoration: InputDecoration(labelText: "Sugar Level"), keyboardType: TextInputType.number),
            TextField(controller: bpController, decoration: InputDecoration(labelText: "Blood Pressure"), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text("Use FastAPI Backend"),
              subtitle: Text("Turn ON after backend is ready"),
              value: useApi,
              onChanged: (val) => setState(() => useApi = val),
            ),
            ElevatedButton(onPressed: submitData, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
