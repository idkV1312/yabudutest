import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/data/models/event_item_model.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/event_card.dart';
import 'package:yabudu/theme/app_theme.dart';

class RecommendationCarousel extends StatelessWidget {
  final List<EventItemModel> items;
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const RecommendationCarousel({
    super.key,
    required this.items,
    required this.controller,
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
            fontWeight: FontWeight.w800,
            color: const Color(0xFF131722),
            height: 0.96,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
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
      ],
    );
  }
}
