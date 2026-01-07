import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../services/api_service.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String region = "South India";
  final TextEditingController age = TextEditingController();
  final TextEditingController bmi = TextEditingController();
  final TextEditingController sugar = TextEditingController();
  final TextEditingController bp = TextEditingController();
  final TextEditingController family = TextEditingController();

  List<String> regionList = [
    "North India","South India","East India","West India","Central India","North-East India"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Input")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: age, decoration: InputDecoration(labelText: "Age")),
            TextField(controller: bmi, decoration: InputDecoration(labelText: "BMI")),
            TextField(controller: sugar, decoration: InputDecoration(labelText: "Sugar Level")),
            TextField(controller: bp, decoration: InputDecoration(labelText: "BP")),
            DropdownButtonFormField(
              value: region,
              items: regionList.map((r) => DropdownMenuItem(child: Text(r), value: r)).toList(),
              onChanged: (val) { setState(() { region = val.toString(); }); },
              decoration: InputDecoration(labelText: "Patient Region"),
            ),
            TextField(
              controller: family,
              decoration: InputDecoration(
                labelText: "Family Diseases",
                hintText: "Father-Diabetes, Mother-BP, Sibling-Heart Disease"
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                List<String> famList = family.text.split(",").map((e) => e.trim()).toList();
                var response = await ApiService.predictDisease(
                  age: age.text,
                  bmi: bmi.text,
                  sugar: sugar.text,
                  bp: bp.text,
                  region: region,
                  family: famList,
                );
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ResultScreen(
                    results: response,
                    region: region,
                    familyDiseases: famList,
                  ),
                ));
              },
              child: Text("Predict"),
            ),
          ],
        ),
      ),
    );
  }
}
