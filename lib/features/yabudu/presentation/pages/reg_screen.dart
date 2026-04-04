import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/gender_sheet_mockuo.dart';
import 'dart:math';

String formatDate(String input) {
  final parts = input.split('.');
  if (parts.length != 3) return input;

  final day = parts[0];
  final month = parts[1];
  final year = parts[2];

  return "$year-$month-$day";
}

String generatePassword({int length = 12}) {
  const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const symbols = '!@#\$%^&*';

  final rand = Random.secure();

  // гарантируем обязательные символы
  String password = '';
  password += letters[rand.nextInt(letters.length)];
  password += letters[rand.nextInt(letters.length)];
  password += numbers[rand.nextInt(numbers.length)];
  password += symbols[rand.nextInt(symbols.length)];

  const all = letters + numbers + symbols;

  for (int i = password.length; i < length; i++) {
    password += all[rand.nextInt(all.length)];
  }

  return password;
}

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  // ===== MASK =====
  final dateMask = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // ===== STATE =====
  String? selectedGender;

  // ===== CONTROLLERS =====
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDateController = TextEditingController();

  // ===== GENDER =====
  Future<void> _openGenderSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => GenderSheet(
        initialGender: selectedGender,
      ),
    );

    if (result != null) {
      setState(() {
        selectedGender = result;
      });
    }
  }

  // ===== REGISTER =====
  Future<void> registerUser() async {
  try {
    final url = Uri.parse('https://develop.yabudu.club/api/v1/users');

    final password = generatePassword();

    final body = {
      "firstname": firstNameController.text.trim(),
      "lastname": lastNameController.text.trim(),
      "phoneNumber": phoneController.text.trim(),
      "birthDate": formatDate(birthDateController.text.trim()),
      "email":
          "test_${DateTime.now().millisecondsSinceEpoch}@yabudu.dev",
      "password": password,
    };

    debugPrint("ОТПРАВКА: ${jsonEncode(body)}");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    if (response.statusCode == 201) {
      debugPrint("SUCCESS 🎉");
    } else {
      debugPrint("ERROR ❌");
    }
  } catch (e) {
    debugPrint("NETWORK ERROR: $e");
  }
}

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  // ===== UI =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: FractionallySizedBox(
                  heightFactor: 0.9,
                  widthFactor: 0.9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: 80,
                            child: Image.asset('assets/images/Logo.png'),
                          ),
                        ),

                        const Spacer(),

                        Column(
                          children: [
                            const Text(
                              'Регистрация',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            TextField(
                              controller: firstNameController,
                              decoration: _input("Имя"),
                            ),
                            const SizedBox(height: 10),

                            TextField(
                              controller: lastNameController,
                              decoration: _input("Фамилия"),
                            ),
                            const SizedBox(height: 10),

                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: _input("Номер телефона"),
                            ),
                            const SizedBox(height: 10),

                            TextField(
                              controller: birthDateController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [dateMask],
                              decoration: _input("Дата рождения"),
                            ),
                            const SizedBox(height: 10),

                            GestureDetector(
                              onTap: _openGenderSheet,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    242,
                                    243,
                                    244,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Text(
                                  selectedGender ?? 'Пол',
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: registerUser,
                            child: const Text('Зарегистрироваться'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _input(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color.fromARGB(255, 242, 243, 244),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
    );
  }
}