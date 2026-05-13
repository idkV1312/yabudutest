import 'package:flutter/material.dart';

class EventsFeedSmallEventCard extends StatelessWidget {
  const EventsFeedSmallEventCard({super.key, required this.index});

  final int index;

  static const _titles = [
    'Керамический мастер-класс',
    'Квартирник',
    'Бесплатный мастер-класс',
    'Арт встречи',
  ];

  static const _images = [
    'assets/images/keramic.png',
    'assets/images/kvartirnik.png',
    'assets/images/master_class.png',
    'assets/images/art_meeting.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167,
      height: 225,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              _images[index],
              width: double.infinity,
              height: 148,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFE5E5E8),
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              _titles[index],
              style: const TextStyle(
                fontFamily: 'FindSansPro',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              '17-19 августа',
              style: TextStyle(fontSize: 11, color: Color(0xFF909097)),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              'Сыромятнический переулок ',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF909097),
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
