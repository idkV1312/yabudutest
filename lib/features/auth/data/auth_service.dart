import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class AuthService {
  final String clientId = "366841700565451299";
  final String redirectUri = "com.yabudu.flutter://callback";

  final String authUrl =
      "https://auth-develop.yabudu.club/oauth/v2/authorize";

  Future<String?> login() async {
    final url =
        "$authUrl"
        "?client_id=$clientId"
        "&response_type=code"
        "&redirect_uri=$redirectUri"
        "&scope=openid profile email";

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: "com.yabudu.flutter",
      );

      final code = Uri.parse(result).queryParameters["code"];

      return code;
    } catch (e) {
      print("Auth error: $e");
      return null;
    }
  }
}