import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RegisterUserRequest {
  const RegisterUserRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.birthDate,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String? birthDate;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
    if (birthDate != null && birthDate!.trim().isNotEmpty) {
      json['birthDate'] = birthDate;
    }
    return json;
  }
}

class UserService {
  UserService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final String _baseUrl = 'https://develop.yabudu.club';

  Future<void> registerUser(RegisterUserRequest request) async {
    final payload = request.toJson();
    debugPrint(
      '[UserService] POST /api/v1/users payload: ${jsonEncode(payload)}',
    );
    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/users'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    debugPrint(
      '[UserService] POST /api/v1/users response: ${response.statusCode} ${response.body}',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    }

    throw Exception(
      'Registration failed (${response.statusCode}): ${response.body}',
    );
  }
}
