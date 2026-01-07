import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() => _S();
}

class _S extends State<InputScreen> {
  final TextEditingController age = TextEditingController();
  final TextEditingController bmi = TextEditingController();
  final TextEditingController sugar = TextEditingController();
  final TextEditingController bp = TextEditingController();

  // Family + extra controllers
  final TextEditingController fatherDiabetes = TextEditingController();
  final TextEditingController motherHeart = TextEditingController();
  final TextEditingController siblingBP = TextEditingController();
  final TextEditingController report1 = TextEditingController();
  final TextEditingController report2 = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController notes = TextEditingController();
  final TextEditingController urgency = TextEditingController();
  final TextEditingController lastCheckup = TextEditingController();

  bool api = false;

  void submit() async {
    Map res;

    if (!api) {
      res = {
        "risks": {"diabetes": 55, "heart": 20, "hypertension": 40, "obesity": 75},
        "recommendations": ["Walk 30 mins daily", "Reduce sugar intake", "BP check weekly"]
      };
    } else {
      res = await ApiService.predict(
        int.parse(age.text),
        double.parse(bmi.text),
        double.parse(sugar.text),
        double.parse(bp.text),
      );
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => ResultScreen(res: res)));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient & Family Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(icon: Icon(Icons.monitor_heart), text: "Vitals"),
                  Tab(icon: Icon(Icons.family_restroom), text: "Family"),
                  Tab(icon: Icon(Icons.medical_information), text: "More"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab 1 – Vitals
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(controller: age, decoration: InputDecoration(labelText: "Age", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 10),
                          TextField(controller: bmi, decoration: InputDecoration(labelText: "BMI", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 10),
                          TextField(controller: sugar, decoration: InputDecoration(labelText: "Sugar Level", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 10),
                          TextField(controller: bp, decoration: InputDecoration(labelText: "Blood Pressure", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                        ],
                      ),
                    ),

                    // Tab 2 – Family History + Links
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text("Family Disease History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15),
                          TextField(controller: fatherDiabetes, decoration: InputDecoration(labelText: "Father – Diabetes %", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 10),
                          TextField(controller: motherHeart, decoration: InputDecoration(labelText: "Mother – Heart Disease %", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 10),
                          TextField(controller: siblingBP, decoration: InputDecoration(labelText: "Sibling – BP %", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 15),
                          Text("Report / Contact Links", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          TextField(controller: report1, decoration: InputDecoration(labelText: "Report URL 1", border: OutlineInputBorder())),
                          SizedBox(height: 10),
                          TextField(controller: report2, decoration: InputDecoration(labelText: "Report URL 2", border: OutlineInputBorder())),
                          SizedBox(height: 10),
                          TextField(controller: contact, decoration: InputDecoration(labelText: "Patient Contact (WhatsApp/Phone)", border: OutlineInputBorder())),
                        ],
                      ),
                    ),

                    // Tab 3 – Additional Info
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text("Additional Doctor Inputs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          TextField(controller: notes, decoration: InputDecoration(labelText: "Doctor Notes", border: OutlineInputBorder())),
                          SizedBox(height: 10),
                          TextField(controller: urgency, decoration: InputDecoration(labelText: "Urgency Level (1–5)", border: OutlineInputBorder()), keyboardType: TextInputType.number),
                          SizedBox(height: 10),
                          TextField(controller: lastCheckup, decoration: InputDecoration(labelText: "Last Checkup Date", border: OutlineInputBorder())),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              SwitchListTile(title: Text("Use FastAPI Backend"), subtitle: Text("Enable only when backend is ready"), value: api, onChanged: (v) => setState(() => api = v)),
              SizedBox(height: 10),
              ElevatedButton(onPressed: submit, child: Text("Submit All Data")),
            ],
          ),
        ),
      ),
    );
  }
}
