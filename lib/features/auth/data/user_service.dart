import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "https://develop.yabudu.club";

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String birthDate,
    required String gender,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/v1/users"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstname": firstName,
        "lastname": lastName,
        "phoneNumber": phone,
        "birthDate": birthDate,
        "gender": gender,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}