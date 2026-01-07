import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map> predictDisease({
    required int age,
    required double bmi,
    required double sugar,
    required double bp,
  }) async {
    final url = Uri.parse("http://10.0.2.2:8000/predict");
    final body = jsonEncode({"age": age, "bmi": bmi, "sugar": sugar, "bp": bp});

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    return jsonDecode(res.body);
  }
}
