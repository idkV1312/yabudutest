import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/presentation/pages/map_screen.dart';
import 'package:yabudu/theme/app_theme.dart';

void main() {
  runApp(const YabuduApp());
}

class YabuduApp extends StatelessWidget {
  const YabuduApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthScreen());
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: YandexMapScreen(
        onShowListTap: () {},
        filterLabels: const [
          'Тест-фильтр A',
          'Фейковая дата',
          'Demo категория',
        ],
      ),
    );
>>>>>>> 67977a2bff26cbdd9008f7433e73185c0f8a0c6d
  }
}
