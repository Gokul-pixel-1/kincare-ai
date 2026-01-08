import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map> predictDisease({required String age, required String bmi, required String sugar, required String bp, required String region, required List family}) async {
    var res = await http.post(
      Uri.parse("http://localhost:8000/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "age": age,
        "bmi": bmi,
        "sugar": sugar,
        "bp": bp,
        "region": region,
        "family_diseases": family,
      }),
    );
    return jsonDecode(res.body);
  }
}
