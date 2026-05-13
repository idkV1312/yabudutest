import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  static Future<String?> getAuthRequestId() async {
    final url = Uri.parse(
      'http://localhost:8080/oauth/v2/authorize'
      '?redirect_uri=http://localhost:8082'
      '&response_type=code'
      '&client_id=345683804872048643'
      '&scope=openid profile email phone offline_access',
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['authRequestId'];
    }
    return null;
  }


  static Future<Map<String, dynamic>?> createPhoneSession(String phone) async {
    final url = Uri.parse(
      'https://develop.yabudu.club/api/v1/sessions/phone',
    );

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"login": phone}),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    }

    return null;
  }

  /// 3. verify session
  static Future<String?> verifyPhoneSession({
    required String authRequestId,
    required String sessionId,
    required String code,
  }) async {
    final url = Uri.parse(
      'https://develop.yabudu.club/api/v1/sessions/phone',
    );

    final res = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "authRequestId": authRequestId,
        "sessionId": sessionId,
        "code": code,
      }),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['authorizationCode'];
    }

    return null;
  }

  /// 4. exchange token
  static Future<String?> exchangeToken(String code) async {
    final url = Uri.parse('http://localhost:8080/oauth/v2/token');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": "http://localhost:8082",
        "client_id": "345683804872048643",
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['access_token'];
    }

    return null;
  }
}