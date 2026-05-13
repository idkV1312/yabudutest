import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yabudu/features/auth/data/user_service.dart';
import 'package:yabudu/features/yabudu/presentation/pages/category_select_screen.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/gender_sheet_mockuo.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key, this.userService, this.onLoginTap});

  final UserService? userService;
  final VoidCallback? onLoginTap;

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  // ===== SERVICES =====
  late final UserService _userService = widget.userService ?? UserService();
  late final RegistrationRequestBuilder _requestBuilder =
      RegistrationRequestBuilder();

  // ===== CONTROLLERS =====
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDateController = TextEditingController();

  // ===== STATE =====
  bool _busy = false;
  String? selectedGender;

  bool get isFormValid {
    return firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        birthDateController.text.trim().isNotEmpty &&
        selectedGender != null;
  }

  @override
  void initState() {
    super.initState();

    firstNameController.addListener(_updateState);
    lastNameController.addListener(_updateState);
    phoneController.addListener(_updateState);
    birthDateController.addListener(_updateState);
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    firstNameController.removeListener(_updateState);
    lastNameController.removeListener(_updateState);
    phoneController.removeListener(_updateState);
    birthDateController.removeListener(_updateState);

    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();

    super.dispose();
  }

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
  Future<void> _register() async {
    if (_busy || !isFormValid) return;

    setState(() => _busy = true);

    try {
      final request = _requestBuilder.build(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        birthDateRaw: birthDateController.text,
      );

      debugPrint(
        '[RegScreen] Register payload: '
        'email=${request.email}, '
        'birthDate=${request.birthDate}',
      );

      await _userService.registerUser(request);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InterestsScreen()),
      );
    } on FormatException catch (e) {
      if (mounted) {
        _showError(e.message);
      }
    } catch (e) {
      debugPrint('[RegScreen] Registration error: $e');

      if (mounted) {
        _showError('Ошибка регистрации: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
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
                                _buildField(
                                  controller: firstNameController,
                                  hint: 'Имя',
                                ),

                                const SizedBox(height: 10),

                                _buildField(
                                  controller: lastNameController,
                                  hint: 'Фамилия',
                                ),

                                const SizedBox(height: 10),

                                _buildField(
                                  controller: phoneController,
                                  hint: 'Номер телефона',
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),

                                const SizedBox(height: 10),

                                _buildField(
                                  controller: birthDateController,
                                  hint: 'Дата рождения',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    const BirthDateInputFormatter(),
                                  ],
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
                                onPressed: isFormValid && !_busy
                                    ? _register
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isFormValid && !_busy
                                      ? const Color(0xFF0004E3)
                                      : const Color.fromARGB(
                                          255,
                                          242,
                                          243,
                                          244,
                                        ),
                                  foregroundColor: isFormValid && !_busy
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
                                child: Text(
                                  _busy ? '...' : 'Зарегистрироваться',
                                  style: const TextStyle(
                                    fontFamily: 'FindSansPro',
                                  ),
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
                                        'Нажимая «Зарегистрироваться», вы соглашаетесь с ',
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
                  onTap: widget.onLoginTap,
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Monserrat',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Color.fromARGB(255, 171, 176, 180),
        ),
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
      ),
    );
  }
}

// =============================================
// RegistrationRequestBuilder
// =============================================
class RegistrationRequestBuilder {
  RegisterUserRequest build({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String birthDateRaw,
  }) {
    final normalizedBirthDate = normalizeBirthDateOrNull(birthDateRaw);

    if (birthDateRaw.trim().isNotEmpty && normalizedBirthDate == null) {
      throw const FormatException(
        'Дата рождения должна быть в формате ДД.ММ.ГГГГ',
      );
    }

    return RegisterUserRequest(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      email: 'stub_${DateTime.now().millisecondsSinceEpoch}@example.com',
      password: 'Bukabu17!',
      phoneNumber: phoneNumber.trim(),
      birthDate: normalizedBirthDate,
    );
  }

  static String? normalizeBirthDateOrNull(String rawInput) {
    final raw = rawInput.trim();

    if (raw.isEmpty) return null;

    String year;
    String month;
    String day;

    final isoMatch = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(raw);

    if (isoMatch != null) {
      year = isoMatch.group(1)!;
      month = isoMatch.group(2)!;
      day = isoMatch.group(3)!;
    } else {
      final dotMatch = RegExp(r'^(\d{2})\.(\d{2})\.(\d{4})$').firstMatch(raw);

      final slashMatch = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(raw);

      final match = dotMatch ?? slashMatch;

      if (match == null) return null;

      day = match.group(1)!;
      month = match.group(2)!;
      year = match.group(3)!;
    }

    final parsed = DateTime.tryParse('$year-$month-$day');

    if (parsed == null) return null;

    final y = int.parse(year);
    final m = int.parse(month);
    final d = int.parse(day);

    if (parsed.year != y || parsed.month != m || parsed.day != d) {
      return null;
    }

    return '$year-$month-$day';
  }
}

// =============================================
// BirthDate formatter
// =============================================
class BirthDateInputFormatter extends TextInputFormatter {
  const BirthDateInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    final clipped = digits.length > 8 ? digits.substring(0, 8) : digits;

    final buffer = StringBuffer();

    for (var i = 0; i < clipped.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('.');
      }

      buffer.write(clipped[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
