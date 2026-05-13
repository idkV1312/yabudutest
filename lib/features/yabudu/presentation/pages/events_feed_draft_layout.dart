import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/events_feed_draft/events_feed_draft_widgets.dart';

class EventsFeedDraftLayout extends StatelessWidget {
  const EventsFeedDraftLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F5),
      body: SafeArea(
        child: Column(
          children: [
            const EventsFeedTopFilters(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EventsFeedSectionTitle('События поблизости'),
                    const SizedBox(height: 12),
                    const EventsFeedNearbyGrid(),
                    const SizedBox(height: 16),
                    const EventsFeedSectionTitle('Рекомендации'),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 296,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          children: const [
                            EventsFeedRecommendationCard(),
                            SizedBox(width: 8),
                            EventsFeedRecommendationCard(),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const EventsFeedSectionTitle('Популярные события'),
                    const SizedBox(height: 12),
                    const EventsFeedNearbyGrid(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const EventsFeedBottomNav(),
          ],
        ),
      ),
    );
  }
}
