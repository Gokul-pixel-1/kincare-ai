import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map results;
  final String region;
  final List<String> familyDiseases;

  ResultScreen({required this.results, required this.region, required this.familyDiseases});

  String getDietPlan(String r) {
    Map<String,String> diets = {
      "North India": "Breakfast: 1 roti + sprouts + milk (no sugar)\nLunch: 2 roti + dal + paneer + salad\nDinner: 1 bowl rice + dal + veg\nWalk 30 mins/day",
      "South India": "Breakfast: 2 idli/dosa + sambar + chutney\nLunch: 1 plate rice + sambar/rasam + poriyal + curd\nDinner: ½ plate rice + dal + veg\nWalk 35 mins/day",
      "East India": "Breakfast: poha + peanuts + tea (no sugar)\nLunch: rice + fish curry (optional) + dal + mustard oil sauté veg\nDinner: 1 small bowl rice + dal\nWalk 25 mins/day + breathing",
      "West India": "Breakfast: poha/upma + sprouts + tea (no sugar)\nLunch: 2 bajra roti + dal + groundnut chutney + salad\nDinner: khichdi (less oil)\nWalk 40 mins/day",
      "Central India": "Breakfast: poha + peanuts + lemon + tea (no sugar)\nLunch: maize/jowar roti + dal + veg + salad\nDinner: khichdi + veg\nWalk 20 mins/day + yoga",
      "North-East India": "Breakfast: herbal tea + sweet potato + egg\nLunch: rice + bamboo shoot veg + dal + herbs\nDinner: rice + boiled veg + pork (optional)\nWalk 30 mins/day",
    };
    return diets[r] ?? "Balanced diet + 30 min walk/day";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediction Results")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Predicted Disease Risks:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(results.toString(), style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text("Family Disease History:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...familyDiseases.map((d) => Text("• $d", style: TextStyle(fontSize: 16))),
              SizedBox(height: 20),
              Text("Detailed Diet Plan for $region:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(getDietPlan(region), style: TextStyle(fontSize:16)),
            ],
          ),
        ),
      ),
    );
  }
}
