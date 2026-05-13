import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yabudu/features/auth/data/auth_service.dart';

class MvpAuthorizationWorkingScreen extends StatefulWidget {
  const MvpAuthorizationWorkingScreen({super.key, this.onRegistrationTap});

  final VoidCallback? onRegistrationTap;

  @override
  State<MvpAuthorizationWorkingScreen> createState() =>
      _MvpAuthorizationWorkingScreenState();
}

class _MvpAuthorizationWorkingScreenState
    extends State<MvpAuthorizationWorkingScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _busy = false;

  bool get _isFormFilled => _phoneController.text.trim().isNotEmpty;

  void _onFieldChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onFieldChanged);
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _authorize() async {
    if (_busy || !_isFormFilled) return;

    final phone = _phoneController.text.trim();
    debugPrint('🔥 [MvpAuthorization] === НАЧИНАЕМ АВТОРИЗАЦИЮ ===');
    debugPrint('📱 Номер телефона: $phone');

    setState(() => _busy = true);

    try {
      debugPrint('1️⃣ Получаем authRequestId через parse from HTML...');
      final authRequestId = await _authService
          .fetchAuthRequestIdFromAuthorizeHtml();
      debugPrint('✅ authRequestId получен (из HTML): $authRequestId');

      debugPrint('2️⃣ Запускаем startPhoneSession...');
      final startResult = await _authService.startPhoneSession(
        phone,
        authRequestId: authRequestId,
      );
      debugPrint('✅ SMS отправлен. sessionId: ${startResult.sessionId}');
      debugPrint('✅ Verification code: ${startResult.verificationCode}');

      debugPrint('3️⃣ Подтверждаем сессию...');
      final tokens = await _authService.confirmPhoneSession(
        sessionId: startResult.sessionId,
        authRequestId: authRequestId,
        smsCode: startResult.verificationCode,
      );

      debugPrint('🎉 АВТОРИЗАЦИЯ УСПЕШНО ЗАВЕРШЕНА!');
      debugPrint('🔑 Access Token: ${tokens.accessToken}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Авторизация прошла успешно!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('❌ ОШИБКА АВТОРИЗАЦИИ: $e');
      debugPrint(stackTrace.toString());

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RegistrationScaffold(
      title: 'Авторизация',
      fields: <Widget>[
        _RoundedField(
          hint: 'Номер телефона',
          keyboardType: TextInputType.phone,
          controller: _phoneController,
        ),
      ],
      buttonLabel: _busy ? '...' : 'Далее',
      agreementPrefix: 'Нажимая кнопку «Далее», вы соглашаетесь\nс ',
      bottomPrefix: 'Нет аккаунта? ',
      bottomAction: 'Регистрация',
      topGapAfterLogo: 46,
      gapBeforeButton: 120,
      isButtonActive: _isFormFilled && !_busy,
      onButtonTap: _authorize,
      onBottomActionTap: widget.onRegistrationTap,
    );
  }
}

// =============================================================================
// UI-КОМПОНЕНТЫ
// =============================================================================

class _RegistrationScaffold extends StatelessWidget {
  const _RegistrationScaffold({
    required this.title,
    required this.fields,
    required this.buttonLabel,
    required this.agreementPrefix,
    required this.bottomPrefix,
    required this.bottomAction,
    required this.topGapAfterLogo,
    required this.gapBeforeButton,
    required this.isButtonActive,
    this.onButtonTap,
    this.onBottomActionTap,
  });

  final String title;
  final List<Widget> fields;
  final String buttonLabel;
  final String agreementPrefix;
  final String bottomPrefix;
  final String bottomAction;
  final double topGapAfterLogo;
  final double gapBeforeButton;
  final bool isButtonActive;
  final VoidCallback? onButtonTap;
  final VoidCallback? onBottomActionTap;

  // БЕЛЫЙ ФОН ВЕЗДЕ
  static const Color _bgColor = Colors.white;
  static const Color _cardColor = Colors.white;
  static const Color _mutedBlockColor = Color(0xFFF8F9FA);

  static const Color _titleColor = Color(0xFF202431);
  static const Color _hintColor = Color(0xFFB8BDC5);
  static const Color _mainTextColor = Color(0xFF2E313A);
  static const Color _linkColor = Color(0xFF2E45F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(18, 30, 18, 18),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Logo.png',
                          width: 136,
                          height: 58,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 100),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontFamilyFallback: <String>['FindSansPro'],
                            fontSize: 41,
                            fontWeight: FontWeight.w700,
                            height: 1.05,
                            color: _titleColor,
                          ),
                        ),
                        const SizedBox(height: 18),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: _mutedBlockColor,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Column(children: fields),
                        ),
                        SizedBox(height: 200),
                        _ActionButton(
                          label: buttonLabel,
                          enabled: isButtonActive,
                          onTap: onButtonTap,
                        ),
                        const SizedBox(height: 14),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontFamilyFallback: <String>['FindSansPro'],
                              fontSize: 13,
                              height: 1.35,
                              color: _mainTextColor,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: agreementPrefix),
                              const TextSpan(
                                text:
                                    'Условиями использования и Политикой\nконфиденциальности',
                                style: TextStyle(
                                  color: _linkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: onBottomActionTap,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontFamilyFallback: <String>['FindSansPro'],
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: _mainTextColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: bottomPrefix),
                          TextSpan(
                            text: bottomAction,
                            style: const TextStyle(
                              color: _linkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoundedField extends StatelessWidget {
  const _RoundedField({
    required this.hint,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontFamilyFallback: <String>['FindSansPro'],
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF4F535D),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontFamilyFallback: <String>['FindSansPro'],
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: _RegistrationScaffold._hintColor,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 17,
        ),
        border: InputBorder.none,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.enabled, this.onTap});

  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: enabled ? onTap : null,
        child: Container(
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: enabled ? const Color(0xFF2E45F4) : const Color(0xFFE5E7EA),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontFamilyFallback: const <String>['FindSansPro'],
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.1,
              color: enabled ? Colors.white : const Color(0xFFB8BCC3),
            ),
          ),
        ),
      ),
    );
  }
}
