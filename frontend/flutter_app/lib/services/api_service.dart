import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map> predictDisease({
    required String age,
    required String bmi,
    required String sugar,
    required String systolicBp,
    required String diastolicBp,
    required String cholesterol,
    required String state,
    required String familyId,
  }) async {
    var res = await http.post(
      Uri.parse("http://192.168.29.42:8000/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "age": int.parse(age),
        "bmi": double.parse(bmi),
        "sugar": double.parse(sugar),
        "systolic_bp": double.parse(systolicBp),
        "diastolic_bp": double.parse(diastolicBp),
        "cholesterol": double.parse(cholesterol),
        "state": state,
        "family_id": familyId,
      }),
    );

    return jsonDecode(res.body);
  }
}

