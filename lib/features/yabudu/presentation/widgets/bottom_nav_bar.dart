import 'package:flutter/material.dart';
import 'package:yabudu/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
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
      height: 72,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 10),
      decoration: BoxDecoration(
        color: ui.chipBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (i) {
          final active = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: active ? ui.primary : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icons[i],
                size: 20,
                color: active ? Colors.white : const Color(0xFF272B36),
              ),
            ),
          );
        }),
      ),
    );
  }
}
