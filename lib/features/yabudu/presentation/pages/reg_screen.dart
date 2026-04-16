import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final phoneController = TextEditingController();
  final smsController = TextEditingController();

  String? authRequestId;
  String? sessionId;
  String? accessToken;

  static const baseUrl = "https://develop.yabudu.club/api/v1";

  // =========================
  // OAUTH
  // =========================
  Future<void> getAuthRequestId() async {
    print("🚀 OAUTH START");

    final url = Uri.encodeFull(
      "https://auth-develop.yabudu.club/oauth/v2/authorize"
      "?redirect_uri=http://localhost:3000/callback"
      "&response_type=code"
      "&client_id=368263087813296502"
      "&scope=openid profile email phone offline_access",
    );

    print("🌐 OAUTH URL: $url");

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: "myapp",
      );
      print("📥 CALLBACK RAW: $result");

      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];

      print("🔑 CODE: $code");

      setState(() {
        authRequestId = code;
      });

      print("✅ AUTH DONE");
    } catch (e) {
      print("❌ OAUTH ERROR: $e");
    }
  }

  // =========================
  // START SESSION
  // =========================
  Future<void> startPhoneSession() async {
    print("📱 START SESSION");

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/sessions/phone"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"login": phoneController.text.trim()}),
      );

      print("📡 STATUS: ${res.statusCode}");
      print("📦 BODY: ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          sessionId = data["sessionId"];
        });

        print("✅ SESSION ID: $sessionId");
      } else {
        print("❌ SESSION FAILED");
      }
    } catch (e) {
      print("❌ SESSION ERROR: $e");
    }
  }

  // =========================
  // CONFIRM
  // =========================
  Future<void> confirmSession() async {
    print("🚀 CONFIRM START");

    print("➡️ SESSION: $sessionId");
    print("➡️ CODE: ${smsController.text}");
    print("➡️ AUTH: $authRequestId");

    try {
      final res = await http.patch(
        Uri.parse("$baseUrl/sessions/phone"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "sessionId": sessionId,
          "code": smsController.text.trim(),
          "authRequestId": authRequestId,
        }),
      );

      print("📡 STATUS: ${res.statusCode}");
      print("📦 BODY: ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          accessToken = data["accessToken"];
        });

        print("🎉 LOGIN SUCCESS");
        print("🔐 TOKEN: $accessToken");
      } else {
        print("❌ CONFIRM FAILED");
      }
    } catch (e) {
      print("❌ CONFIRM ERROR: $e");
    }
  }

  // =========================
  // FULL FLOW
  // =========================
  Future<void> fullFlow() async {
    print("🔥 FULL FLOW START");

    if (phoneController.text.isEmpty) {
      print("❌ PHONE EMPTY");
      return;
    }

    print("📱 PHONE: ${phoneController.text}");

    await getAuthRequestId();
    await startPhoneSession();

    print("✅ FULL FLOW DONE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DEBUG AUTH")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(hintText: "Phone"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                print("💥 BUTTON PRESSED");
                fullFlow();
              },
              child: const Text("1. START"),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: smsController,
              decoration: const InputDecoration(hintText: "SMS code"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: confirmSession,
              child: const Text("2. CONFIRM"),
            ),

            const SizedBox(height: 30),

            if (authRequestId != null) Text("AUTH: $authRequestId"),

            if (sessionId != null) Text("SESSION: $sessionId"),

            if (accessToken != null) SelectableText("TOKEN:\n$accessToken"),
          ],
        ),
      ),
    );
  }
}
