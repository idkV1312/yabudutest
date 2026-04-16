import 'package:flutter/material.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  static const Color _screenBackground = Color(0xFFF1F1F1);
  static const Color _tileBackground = Color(0xFFF5F5F5);
  static const Color _activeTileBackground = Color(0xFF2F33F9);
  static const Color _iconColor = Color(0xFF2D2D2D);

  static const List<_InterestItem> _items = [
    _InterestItem(label: 'Концерт', icon: Icons.speaker_outlined),
    _InterestItem(label: 'Театр', icon: Icons.theater_comedy_outlined),
    _InterestItem(
      label: 'Детям',
      icon: Icons.toys_outlined,
      isSelected: true,
    ),
    _InterestItem(label: 'Стендап', icon: Icons.mic_none_rounded),
    _InterestItem(label: 'Спорт', icon: Icons.sports_bar_outlined),
    _InterestItem(label: 'Кино', icon: Icons.photo_camera_outlined),
    _InterestItem(label: 'Выставка', icon: Icons.crop_free_outlined),
    _InterestItem(label: 'Катки', icon: Icons.ac_unit_outlined),
    _InterestItem(label: 'Квест', icon: Icons.search_rounded),
    _InterestItem(label: 'Экскурсия', icon: Icons.apartment_outlined),
    _InterestItem(label: 'Шоу', icon: Icons.album_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBackground,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430.66, maxHeight: 932),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.3),
                border: Border.all(color: Colors.black.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF120F28).withOpacity(0.12),
                    blurRadius: 6.63,
                    offset: const Offset(0, 3.31),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const _MockStatusBar(),
                  const SizedBox(height: 24),
                  const Text(
                    'Что вам нравится?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'FindSansPro',
                      fontSize: 24,
                      height: 37.545 / 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 11),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 37.5),
                    child: Text(
                      'Поделитесь ответами, а мы подберём события специально для вас. Это займёт меньше минутки',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'FindSansPro',
                        fontSize: 14,
                        height: 22.085 / 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                  const SizedBox(height: 27),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26.5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _items.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 11.04,
                        crossAxisSpacing: 13.25,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return _InterestTile(
                          item: item,
                          backgroundColor: item.isSelected
                              ? _activeTileBackground
                              : _tileBackground,
                          iconColor: item.isSelected ? Colors.white : _iconColor,
                          textColor: item.isSelected ? Colors.white : Colors.black,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'В другой раз',
                    style: TextStyle(
                      fontFamily: 'FindSansPro',
                      fontSize: 14,
                      height: 25.398 / 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 67),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MockStatusBar extends StatelessWidget {
  const _MockStatusBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          const Text(
            '9:41',
            style: TextStyle(
              color: Color(0xFF242524),
              fontSize: 16,
              height: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.signal_cellular_alt_rounded, size: 16, color: Colors.black),
          const SizedBox(width: 4),
          const Icon(Icons.wifi_rounded, size: 16, color: Colors.black),
          const SizedBox(width: 4),
          Container(
            width: 24,
            height: 12,
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 14,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestTile extends StatelessWidget {
  const _InterestTile({
    required this.item,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  final _InterestItem item;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(17.67),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24.3),
          Icon(item.icon, size: 37.5, color: iconColor),
          const SizedBox(height: 10),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'FindSansPro',
              fontSize: 15,
              height: 22.085 / 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestItem {
  const _InterestItem({
    required this.label,
    required this.icon,
    this.isSelected = false,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
}
