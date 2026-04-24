import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/presentation/pages/category_select_screen.dart';
import 'package:yabudu/features/yabudu/presentation/pages/events_feed_draft_layout.dart';
import 'package:yabudu/features/yabudu/presentation/pages/glassmorphism_draft_layout.dart';
import 'package:yabudu/features/yabudu/presentation/pages/poll_draft_layout.dart';
import 'package:yabudu/features/yabudu/presentation/pages/reg_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthScreen());
  }
}
