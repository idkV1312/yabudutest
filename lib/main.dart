import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:yabudu/features/yabudu/presentation/pages/category_select_screen.dart';
import 'package:yabudu/features/yabudu/presentation/pages/events_feed_draft_layout.dart';
import 'package:yabudu/features/yabudu/presentation/pages/glassmorphism_draft_layout.dart';
import 'package:yabudu/features/yabudu/presentation/pages/poll_draft_layout.dart';
import 'package:yabudu/features/yabudu/presentation/pages/reg_screen.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_event.dart';
import 'package:yabudu/features/yabudu/presentation/pages/map_screen.dart';
import 'package:yabudu/theme/app_theme.dart';
>>>>>>> c97ecd5 (map screen)

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: EventsFeedDraftLayout(),
=======
      theme: AppTheme.light,
      home: YandexMapScreen(
        onShowListTap: () {},
        filterLabels: const [
          'Тест-фильтр A',
          'Фейковая дата',
          'Demo категория',
        ],
      ),
>>>>>>> c97ecd5 (map screen)
    );
  }
}
