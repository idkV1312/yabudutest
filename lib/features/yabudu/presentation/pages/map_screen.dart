import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapScreen extends StatefulWidget {
  final VoidCallback onShowListTap;
  final List<String> filterLabels;

  const YandexMapScreen({
    super.key,
    required this.onShowListTap,
    required this.filterLabels,
  });

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

  Future<void> _changeZoom(double delta) async {
    final controller = _controller;
    if (controller == null) return;

    final current = await controller.getCameraPosition();
    final nextZoom = (current.zoom + delta).clamp(2.0, 20.0);
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: current.target,
          zoom: nextZoom,
          azimuth: current.azimuth,
          tilt: current.tilt,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 0.18,
      ),
    );
  }

  Future<void> _moveToCenter() async {
    final controller = _controller;
    if (controller == null) return;

    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: _moscowCenter, zoom: 12),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 0.25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = widget.filterLabels.isEmpty
        ? const ['Избранные', 'Дата', 'Тип события']
        : widget.filterLabels.take(3).toList();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: YandexMap(onMapCreated: _onMapCreated),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Карта',
                    style: TextStyle(
                      color: Color(0xFF2F33F9),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 20,
                                color: Color(0xFFB2B7C4),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Название события',
                                style: TextStyle(
                                  color: Color(0xFFB2B7C4),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _RoundIconButton(
                        icon: Icons.filter_alt_outlined,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      _RoundIconButton(
                        icon: Icons.person,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: labels
                          .map(
                            (label) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2F33F9),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        _RoundIconButton(
                          icon: Icons.add_rounded,
                          onTap: () => _changeZoom(1),
                        ),
                        const SizedBox(height: 8),
                        _RoundIconButton(
                          icon: Icons.remove_rounded,
                          onTap: () => _changeZoom(-1),
                        ),
                        const SizedBox(height: 8),
                        _RoundIconButton(
                          icon: Icons.my_location_rounded,
                          onTap: _moveToCenter,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: widget.onShowListTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.view_list_rounded,
                            color: Color(0xFFFF6B3C),
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Список',
                            style: TextStyle(
                              color: Color(0xFFFF6B3C),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF252A37), size: 22),
      ),
    );
  }
}
