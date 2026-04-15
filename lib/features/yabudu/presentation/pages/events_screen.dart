import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabudu/features/yabudu/data/models/event_item_model.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_bloc.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_event.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_state.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/bottom_nav_bar.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/event_card.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/filter_chip_widget.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/recommendation_carousel.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/search_header.dart';
import 'package:yabudu/theme/app_theme.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.94);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YabuduBloc, YabuduState>(
      builder: (context, state) {
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3EE),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      '1 Круги',
                      style: TextStyle(
                        color: Color(0xFFFF7D57),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              BottomNavBar(
                currentIndex: state.bottomNav,
                onTap: (i) =>
                    context.read<YabuduBloc>().add(ChangeBottomNav(i)),
                onAddTap: () {},
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchHeader(),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 28,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      itemCount: state.filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final f = state.filters[i];
                        return FilterChipWidget(
                          label: f.label,
                          hasArrow: f.hasArrow,
                          selected: state.selectedFilterId == f.id,
                          onTap: () =>
                              context.read<YabuduBloc>().add(SelectFilter(f.id)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  _SectionGrid(
                    title: 'События поблизости',
                    items: state.nearby.take(4).toList(),
                  ),
                  const SizedBox(height: 16),
                  RecommendationCarousel(
                    items: state.recommended,
                    controller: _pageController,
                    onPageChanged: (i) {
                      context.read<YabuduBloc>().add(ChangeRecommendationPage(i));
                    },
                  ),
                  const SizedBox(height: 14),
                  _SectionGrid(
                    title: 'Популярные события',
                    items: state.popularEvents.take(4).toList(),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionGrid extends StatelessWidget {
  final String title;
  final List<EventItemModel> items;

  const _SectionGrid({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ui.sectionTitleSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF131722),
            height: 0.95,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: items.map((e) => EventCard(item: e, compact: true)).toList(),
        ),
      ],
    );
  }
}
