import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/pages/auth_screen.dart';
import 'package:yabudu/features/yabudu/presentation/pages/map_screen.dart';
import 'package:yabudu/features/yabudu/presentation/pages/reg_screen.dart';

void main() {
  runApp(const YabuduApp());
}

class YabuduApp extends StatelessWidget {
  const YabuduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YandexMapScreen(onShowListTap: () {}, filterLabels: []),
    );
  }
}
