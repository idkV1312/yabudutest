import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://develop.yabudu.club';

  Future<bool> savePreferences(
    List<String> preferences, {
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/users/preferences'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"preferences": preferences}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 401) {
        print('Ошибка 401: Не авторизован');
        return false;
      } else {
        print('Ошибка ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Ошибка при отправке предпочтений: $e');
      return false;
    }
  }
}
