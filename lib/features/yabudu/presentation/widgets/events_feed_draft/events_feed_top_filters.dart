import 'package:flutter/material.dart';

class EventsFeedTopFilters extends StatelessWidget {
  const EventsFeedTopFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: Row(
              children: [
                Expanded(
                  flex: 273,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.search,
                            size: 22,
                            color: Color(0xFF9A9AA0),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Название события',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF9A9AA0),
                              fontFamily: 'FindSansPro',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.filter_list,
                            size: 24,
                            color: Color(0xFF2F33F9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 62,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Center(
                    child: Icon(Icons.person_outline, size: 28),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 26,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  EventsFeedChipLabel('Избранные', true),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Дата', false, showArrow: true),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Тип события', false, showArrow: true),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Цена', false, showArrow: true),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Геолокация', false, showArrow: true),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Популярные', false),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Доступные места', false),
                  SizedBox(width: 8),
                  EventsFeedChipLabel('Возрастные ограничения 18+', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsFeedChipLabel extends StatelessWidget {
  const EventsFeedChipLabel(
    this.text,
    this.active, {
    super.key,
    this.showArrow = false,
  });

  final String text;
  final bool active;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2F33F9) : const Color(0xFFE4E9FF),
        borderRadius: BorderRadius.circular(13),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'FindSansPro',
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              color: active ? Colors.white : const Color(0xFF2F33F9),
            ),
          ),
          if (showArrow) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: active ? Colors.white : const Color(0xFF2F33F9),
            ),
          ],
        ],
      ),
    );
  }
}
