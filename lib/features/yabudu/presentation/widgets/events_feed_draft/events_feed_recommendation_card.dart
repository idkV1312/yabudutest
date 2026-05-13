import 'package:flutter/material.dart';

class EventsFeedRecommendationCard extends StatelessWidget {
  const EventsFeedRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 296,
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
              'assets/images/chess.png',
              width: double.infinity,
              height: 188,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFE5E5E8),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Шахматы',
              style: TextStyle(
                fontFamily: 'FindSansPro',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '15 июля, 19:00',
              style: TextStyle(fontSize: 13, color: Color(0xFF909097)),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Сыромятнический переулок',
              style: TextStyle(fontSize: 13, color: Color(0xFF909097)),
            ),
          ),
        ],
      ),
    );
  }
}
