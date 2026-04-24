import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/pages/map_screen.dart';
import 'package:yabudu/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<YabuduBloc>(
      create: (_) => YabuduBloc(),
      child: MaterialApp(
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
      ),
    );
  }
}
