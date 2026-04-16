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

                    // Рекомендации — горизонтальный скролл
                    const _SectionTitle('Рекомендации'),
                    const SizedBox(height: 8),

                    // Горизонтально прокручиваемая секция
                    SizedBox(
                      height: 296, // высота одной карточки
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(
                          right: 16,
                        ), // отступ справа от последнего элемента
                        child: Row(
                          children: const [
                            _RecommendationCard(),
                            SizedBox(
                              width: 8,
                            ), // расстояние между карточками = 8
                            _RecommendationCard(), // второй такой же блок справа
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167, // точная ширина
      height: 225, // точная высота всего блока
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение занимает всю ширину карточки
          Container(
            width: double.infinity,
            height:
                148, // высота изображения (подобрано, чтобы общая высота была ~225)
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E8),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                // +99
                Positioned(
                  left: 6,
                  top: 6,
                  child: Container(
                    width: 34,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    alignment: Alignment.center,
                    child: const Text('+99', style: TextStyle(fontSize: 10)),
                  ),
                ),
                // Сердечко
                Positioned(
                  right: 6,
                  top: 6,
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      size: 13,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                // Цена
                Positioned(
                  right: 6,
                  bottom: 6,
                  child: Container(
                    height: 18,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EAFF),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '500 ₽',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF2F33F9),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Отступ 9 после изображения
          const SizedBox(height: 9),

          // Название события
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

          // Отступ 4
          const SizedBox(height: 4),

          // Дата
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: const Text(
              '17-19 августа 2025', // пример, можешь менять
              style: TextStyle(fontSize: 11, color: Color(0xFF909097)),
            ),
          ),

          // Отступ 4
          const SizedBox(height: 4),

          // Адрес
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: const Text(
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

// ====================== ОБНОВЛЁННЫЙ _RecommendationCard ======================
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
          // Изображение
          Container(
            width: double.infinity,
            height: 188, // подобрано под общую высоту 296
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E8),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text('+36', style: TextStyle(fontSize: 10)),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      size: 15,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EAFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '500 ₽',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF2F33F9),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Название
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Шахматы',
              style: TextStyle(
                fontFamily: 'FindSansPro',
                fontSize: 22, // чуть увеличил для красоты
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Дата
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '15 июля, 19:00',
              style: TextStyle(fontSize: 13, color: Color(0xFF909097)),
            ),
          ),

          const SizedBox(height: 4),

          // Адрес
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
        child: const Text(
          '343 x 1438 Hug',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8), // ← изменил на 16
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF2F33F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.home, color: Colors.white, size: 20),
          ),
          const Icon(Icons.groups_2_outlined, size: 19),
          const Icon(Icons.wallet_outlined, size: 19),
          const Icon(Icons.grid_view_rounded, size: 19),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFEDEDEF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 18, color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
