import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:yabudu/features/yabudu/presentation/widgets/events_feed_draft/events_feed_draft_widgets.dart';

class YandexMapScreen extends StatefulWidget {
  const YandexMapScreen({super.key});

  @override
  State<YandexMapScreen> createState() => _YandexMapScreenState();
}

class _YandexMapScreenState extends State<YandexMapScreen> {
  static const Point _moscowCenter = Point(
    latitude: 55.751244,
    longitude: 37.618423,
  );

  YandexMapController? _controller;

  Future<void> _onMapCreated(YandexMapController controller) async {
    _controller = controller;
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: _moscowCenter, zoom: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: YandexMap(onMapCreated: _onMapCreated)),

          // HUD поверх карты: верхние фильтры + нижняя навигация
          SafeArea(
            child: Column(
              children: [
                const EventsFeedTopFilters(),
                const Spacer(),
                const EventsFeedBottomNav(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
