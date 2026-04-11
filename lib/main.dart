import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_event.dart';
import 'package:yabudu/features/yabudu/presentation/pages/events_screen.dart';
import 'package:yabudu/theme/app_theme.dart';

void main() {
  runApp(
    BlocProvider<YabuduBloc>(
      create: (_) => YabuduBloc()..add(const LoadYabudu()),
      child: const YabuduApp(),
    ),
  );
}

class YabuduApp extends StatelessWidget {
  const YabuduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const EventsScreen(),
    );
  }
}
