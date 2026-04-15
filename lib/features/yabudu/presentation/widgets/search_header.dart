import 'package:flutter/material.dart';
import 'package:yabudu/theme/app_theme.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: ui.chipBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 16, color: ui.mutedIcon),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Название события',
                      style: TextStyle(
                        fontSize: 10,
                        color: ui.mutedText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.tune_rounded, size: 16, color: ui.mutedIcon),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: ui.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, size: 18, color: Colors.white),
              ),
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC843),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.4),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: Color(0xFF2F33F9),
                    ),
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
