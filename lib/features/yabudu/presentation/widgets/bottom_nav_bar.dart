import 'package:flutter/material.dart';
import 'package:yabudu/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    const icons = [
      Icons.home_rounded,
      Icons.groups_2_outlined,
      Icons.confirmation_num_outlined,
      Icons.grid_view_rounded,
    ];

    return Container(
      height: 68,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x170E1430),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (i) {
                final active = i == currentIndex;
                return GestureDetector(
                  onTap: () => onTap(i),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: active ? ui.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icons[i],
                      size: 18,
                      color: active ? Colors.white : const Color(0xFF272B36),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onAddTap,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFFF7D57),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 14),
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
