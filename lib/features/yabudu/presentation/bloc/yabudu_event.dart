import 'package:flutter/foundation.dart';

@immutable
abstract class YabuduEvent {
  const YabuduEvent();
}

class LoadYabudu extends YabuduEvent {
  const LoadYabudu();
}

class SelectFilter extends YabuduEvent {
  final String filterId;
  const SelectFilter(this.filterId);
}

class ChangeBottomNav extends YabuduEvent {
  final int index;
  const ChangeBottomNav(this.index);
}

class ChangeRecommendationPage extends YabuduEvent {
  final int index;
  const ChangeRecommendationPage(this.index);
}
