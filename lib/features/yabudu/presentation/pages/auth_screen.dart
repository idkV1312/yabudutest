import 'package:flutter/material.dart';
import 'package:yabudu/features/auth/data/auth_service.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

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
                heightFactor: 0.90,
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
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          height: 80,
                          child: Image.asset('assets/images/Logo.png'),
                        ),
                      ),

                      const Spacer(),

                      Column(
                        children: [
                          const Text(
                            'Авторизация',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'FindSansPro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
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
                        ],
                      ),

                      const Spacer(),

                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final auth = AuthService();

                                try {
                                  final token = await auth.login();
                                  print("TOKEN: $token");
                                } catch (e) {
                                  print(e);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: const Color.fromARGB(
                                  255,
                                  242,
                                  243,
                                  244,
                                ),
                                disabledForegroundColor: Colors.grey.shade500,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  0,
                                  4,
                                  227,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Далее',
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
                                      'Нажимая кнопку «Далее», вы соглашаетесь с ',
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
                'Нет аккаунта? ',
                style: TextStyle(fontFamily: 'Monsterrat'),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Регистрация',
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
