import 'package:flutter/material.dart';

class EventsFeedBlueCounter extends StatelessWidget {
  const EventsFeedBlueCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2DA2FF),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
