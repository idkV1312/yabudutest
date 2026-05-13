import 'package:flutter/material.dart';

class EventsFeedSectionTitle extends StatelessWidget {
  const EventsFeedSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 32,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'FindSansPro',
            height: 1,
          ),
        ),
      ),
    );
  }
}
