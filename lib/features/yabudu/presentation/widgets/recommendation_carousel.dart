import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/data/models/event_item_model.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/event_card.dart';
import 'package:yabudu/theme/app_theme.dart';

class RecommendationCarousel extends StatelessWidget {
  final List<EventItemModel> items;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const RecommendationCarousel({
    super.key,
    required this.items,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Рекомендации',
          style: TextStyle(
            fontSize: ui.sectionTitleSize,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1E2330),
            height: 0.95,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 308,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            onPageChanged: onPageChanged,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: EventCard(item: items[i], compact: false),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length, (i) {
            final active = i == currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: active ? 14 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: active ? ui.primary : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}
