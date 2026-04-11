import 'package:flutter/material.dart';
import 'package:yabudu/theme/app_theme.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: ui.chipBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: ui.mutedIcon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Название события',
                      style: TextStyle(fontSize: 14, color: ui.mutedText),
                    ),
                  ),
                  Icon(Icons.tune, size: 18, color: ui.mutedIcon),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: ui.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: ui.accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
