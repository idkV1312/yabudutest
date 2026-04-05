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
  @override
  void initState() {
    super.initState();

    firstNameController.addListener(_updateState);
    lastNameController.addListener(_updateState);
    phoneController.addListener(_updateState);
    birthDateController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  bool get isFormValid {
    return firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        birthDateController.text.trim().length == 10 &&
        selectedGender != null;
  }

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
      builder: (_) => GenderSheet(initialGender: selectedGender),
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
        "email": "test_${DateTime.now().millisecondsSinceEpoch}@yabudu.dev",
        "password": password,
      };

      debugPrint("ОТПРАВКА: ${jsonEncode(body)}");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
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
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              'Регистрация',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'FindSansPro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                TextField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Имя',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Monserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 171, 176, 180),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                      255,
                                      242,
                                      243,
                                      244,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Фамилия',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Monserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 171, 176, 180),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                      255,
                                      242,
                                      243,
                                      244,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Номер телефона',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Monserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 171, 176, 180),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                      255,
                                      242,
                                      243,
                                      244,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: birthDateController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [dateMask],
                                  decoration: InputDecoration(
                                    hintText: 'Дата рождения',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Monserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 171, 176, 180),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                      255,
                                      242,
                                      243,
                                      244,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
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
                                      style: TextStyle(
                                        fontFamily: 'Monserrat',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: selectedGender == null
                                            ? const Color.fromARGB(
                                                255,
                                                171,
                                                176,
                                                180,
                                              )
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Spacer(),

                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isFormValid ? registerUser : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isFormValid
                                      ? const Color(0xFF0004E3)
                                      : const Color.fromARGB(
                                          255,
                                          242,
                                          243,
                                          244,
                                        ),
                                  foregroundColor: isFormValid
                                      ? Colors.white
                                      : Colors.grey.shade500,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Зарегистрироваться',
                                  style: TextStyle(fontFamily: 'FindSansPro'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Нажимая «Зарегистрироваться», вы соглашаетесь с ',
                                    style: TextStyle(fontFamily: 'Monsterrat'),
                                  ),
                                  TextSpan(
                                    text: 'Условиями использования',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 47, 50, 249),
                                      fontFamily: 'Monsterrat',
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' и ',
                                    style: TextStyle(fontFamily: 'Monsterrat'),
                                  ),
                                  TextSpan(
                                    text: 'Политикой конфиденциальности',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 47, 50, 249),
                                      fontFamily: 'Monsterrat',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Уже зарегистрированы? ',
                  style: TextStyle(fontFamily: 'Monsterrat'),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Войти',
                    style: TextStyle(
                      color: Color.fromARGB(255, 47, 50, 249),
                      fontFamily: 'Monsterrat',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
