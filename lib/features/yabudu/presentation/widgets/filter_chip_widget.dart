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
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? ui.chipSelectedBg : ui.chipBg,
          borderRadius: BorderRadius.circular(ui.chipRadius),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected ? ui.chipSelectedText : ui.primary,
              ),
            ),
            if (hasArrow) ...[
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 14, color: ui.primary),
            ],
          ],
        ),
      ),
    );
  }
}
