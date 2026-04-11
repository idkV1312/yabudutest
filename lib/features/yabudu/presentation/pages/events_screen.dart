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
  final PageController _pageController = PageController(viewportFraction: 0.92);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    return BlocBuilder<YabuduBloc, YabuduState>(
      builder: (context, state) {
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ui.chipBg,
            elevation: 0,
            onPressed: () {},
            child: Icon(Icons.add, color: ui.accent),
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: state.bottomNav,
            onTap: (i) => context.read<YabuduBloc>().add(ChangeBottomNav(i)),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const SearchHeader(),
                const SizedBox(height: 10),
                SizedBox(
                  height: 34,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionGrid(
                          title: 'События поблизости',
                          items: state.nearby,
                        ),
                        const SizedBox(height: 18),
                        RecommendationCarousel(
                          items: state.recommended,
                          controller: _pageController,
                          currentPage: state.recommendationPage,
                          onPageChanged: (i) {
                            context.read<YabuduBloc>().add(
                              ChangeRecommendationPage(i),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1E2330),
            height: 0.95,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 14,
          children: items
              .map((e) => EventCard(item: e, compact: true))
              .toList(),
        ),
      ],
    );
  }
}
