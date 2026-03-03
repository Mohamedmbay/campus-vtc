import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  static Future<void> createCourse({
    required String destination,
    required String typeVehicule,
    required double prix,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/courses"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "destination": destination,
        "typeVehicule": typeVehicule,
        "prix": prix,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Erreur API");
    }
  }
}