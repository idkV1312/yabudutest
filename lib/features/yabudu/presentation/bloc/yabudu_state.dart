import 'package:flutter/foundation.dart';
import 'package:yabudu/features/yabudu/data/models/event_item_model.dart';
import 'package:yabudu/features/yabudu/data/models/filter_option_model.dart';

@immutable
class YabuduState {
  final bool loading;
  final String selectedFilterId;
  final int navIndex;
  final int recommendationPage;
  final List<FilterOptionModel> filters;
  final List<EventItemModel> nearbyEvents;
  final List<EventItemModel> recommendedEvents;
  final List<EventItemModel> popularEvents;

  const YabuduState({
    required this.loading,
    required this.selectedFilterId,
    required this.navIndex,
    required this.recommendationPage,
    required this.filters,
    required this.nearbyEvents,
    required this.recommendedEvents,
    required this.popularEvents,
  });

  factory YabuduState.initial() => const YabuduState(
    loading: true,
    selectedFilterId: 'fav',
    navIndex: 0,
    recommendationPage: 0,
    filters: [],
    nearbyEvents: [],
    recommendedEvents: [],
    popularEvents: [],
  );

  List<EventItemModel> get nearby => nearbyEvents;
  List<EventItemModel> get recommended => recommendedEvents;
  int get bottomNav => navIndex;

  YabuduState copyWith({
    bool? loading,
    String? selectedFilterId,
    int? navIndex,
    int? recommendationPage,
    List<FilterOptionModel>? filters,
    List<EventItemModel>? nearbyEvents,
    List<EventItemModel>? recommendedEvents,
    List<EventItemModel>? popularEvents,
  }) {
    return YabuduState(
      loading: loading ?? this.loading,
      selectedFilterId: selectedFilterId ?? this.selectedFilterId,
      navIndex: navIndex ?? this.navIndex,
      recommendationPage: recommendationPage ?? this.recommendationPage,
      filters: filters ?? this.filters,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      recommendedEvents: recommendedEvents ?? this.recommendedEvents,
      popularEvents: popularEvents ?? this.popularEvents,
    );
  }
}
