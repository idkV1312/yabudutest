import 'package:flutter/material.dart';

class EventsFeedDraftLayout extends StatelessWidget {
  const EventsFeedDraftLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F5),
      body: SafeArea(
        child: Column(
          children: [
            const _TopFilters(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  6,
                  16,
                  24,
                ), // ← изменил на 16
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('События поблизости'),
                    const SizedBox(height: 12),
                    const _NearbyGrid(),

                    const SizedBox(height: 16),

                    const _SectionTitle('Рекомендации'),
                    const SizedBox(height: 8),

                    SizedBox(
                      height: 296,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          children: const [
                            _RecommendationCard(),
                            SizedBox(width: 8),
                            _RecommendationCard(),
                            SizedBox(width: 8),
                            // Можно добавить ещё карточки, если нужно
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const _SectionTitle('Популярные события'),
                    const SizedBox(height: 12),
                    const _NearbyGrid(),

                    const SizedBox(height: 16),
                    const _BlueCounter(),
                  ],
                ),
              ),
            ),
            const _BottomNav(),
          ],
        ),
      ),
    );
  }
}

class _TopFilters extends StatelessWidget {
  const _TopFilters();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8), // ← изменил на 16
      child: Column(
        children: [
          // Строка поиска
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
                // Правая иконка 62×52
                Container(
                  width: 62,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_outline,
                      size: 28,
                    ), // замени на свою иконку
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Чипы
          SizedBox(
            height: 26,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  _ChipLabel('Избранные', true),
                  SizedBox(width: 8),
                  _ChipLabel('Дата', false, showArrow: true),
                  SizedBox(width: 8),
                  _ChipLabel('Цвет события', false),
                  SizedBox(width: 8),
                  _ChipLabel('Цена', false),
                  SizedBox(width: 8),
                  _ChipLabel('Геолокация', false),
                  SizedBox(width: 8),
                  _ChipLabel('Тип события', false),
                  SizedBox(width: 8),
                  _ChipLabel('Время', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipLabel extends StatelessWidget {
  const _ChipLabel(this.text, this.active, {this.showArrow = false});

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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343, // точная ширина 343
      height: 32, // точная высота 32
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'FindSansPro',
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

class _NearbyGrid extends StatelessWidget {
  const _NearbyGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12, // отступ снизу между карточками = 12
        crossAxisSpacing: 9, // отступ между карточками по горизонтали = 9
        childAspectRatio: 167 / 225, // точное соотношение 167×225
      ),
      itemBuilder: (_, index) => _SmallEventCard(index: index),
    );
  }
}

class _SmallEventCard extends StatelessWidget {
  const _SmallEventCard({required this.index});

  final int index;

  static const _titles = [
    'Керамический\nмастер-класс',
    'Квартирник',
    'Бесплатный мастер-\nкласс',
    'Арт встречи',
  ];

  // Пути к изображениям в порядке индекса
  static const _images = [
    'assets/images/keramic.png', // 0 - Керамический мастер-класс
    'assets/images/kvartirnik.png', // 1 - Квартирник
    'assets/images/master_class.png', // 2 - Бесплатный мастер-класс
    'assets/images/art_meeting.png', // 3 - Арт встречи (добавил логичное название)
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
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              '17-19 августа 2025',
              style: TextStyle(fontSize: 11, color: Color(0xFF909097)),
            ),
          ),

          const SizedBox(height: 4),

          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              'Сыромятнический переулок',
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

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard();

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

class _BlueCounter extends StatelessWidget {
  const _BlueCounter();

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

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 68,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E6E8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.home, color: Color(0xFF2F33F9), size: 24),
              Icon(Icons.groups_2_outlined, size: 24),
              Icon(Icons.wallet_outlined, size: 24),
              Icon(Icons.grid_view_rounded, size: 24),
            ],
          ),
        ),

        Positioned(
          bottom: 85,
          right: 16 + 8,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.deepOrange, // оранжевый плюс
            ),
          ),
        ),
      ],
    );
  }
}
