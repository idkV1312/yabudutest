import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabudu/features/yabudu/data/datasources/yabudu_mock_data.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_event.dart';
import 'package:yabudu/features/yabudu/presentation/bloc/yabudu_state.dart';

class YabuduBloc extends Bloc<YabuduEvent, YabuduState> {
  YabuduBloc() : super(YabuduState.initial()) {
    on<LoadYabudu>((event, emit) {
      emit(
        state.copyWith(
          loading: false,
          filters: YabuduMockData.filters,
          nearbyEvents: YabuduMockData.nearbyEvents,
          recommendedEvents: YabuduMockData.recommendedEvents,
          popularEvents: YabuduMockData.popularEvents,
        ),
      );
    });

    on<SelectFilter>((event, emit) {
      final filtered = event.filterId == 'fav'
          ? YabuduMockData.nearbyEvents.where((e) => e.isFavorite).toList()
          : YabuduMockData.nearbyEvents;

      emit(
        state.copyWith(
          selectedFilterId: event.filterId,
          nearbyEvents: filtered,
        ),
      );
    });

    on<ChangeBottomNav>((event, emit) {
      emit(state.copyWith(navIndex: event.index));
    });

    on<ChangeRecommendationPage>((event, emit) {
      emit(state.copyWith(recommendationPage: event.index));
    });
  }
}
