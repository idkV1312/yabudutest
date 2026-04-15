import 'package:flutter/material.dart';
import 'package:yabudu/theme/app_theme.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final bool hasArrow;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.hasArrow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE9EBF7) : const Color(0xFFE9EBF0),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 32 / 3,
                fontWeight: FontWeight.w700,
                color: ui.primary,
              ),
            ),
            if (hasArrow) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: ui.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
