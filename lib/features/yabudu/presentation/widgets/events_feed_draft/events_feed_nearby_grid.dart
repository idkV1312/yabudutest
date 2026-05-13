import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/events_feed_draft/events_feed_small_event_card.dart';

class EventsFeedNearbyGrid extends StatelessWidget {
  const EventsFeedNearbyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 9,
        childAspectRatio: 167 / 225,
      ),
      itemBuilder: (_, index) => EventsFeedSmallEventCard(index: index),
    );
  }
}
