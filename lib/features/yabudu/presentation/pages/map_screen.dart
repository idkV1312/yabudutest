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
    if (controller == null) {
      return;
    }

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
    if (controller == null) {
      return;
    }

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
        ? const ['Избранные', 'Дата', 'Тип событий']
        : widget.filterLabels.take(3).toList();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: YandexMap(onMapCreated: _onMapCreated),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Карта',
                    style: TextStyle(
                      color: Color(0xFFB0B3BB),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FindSansPro',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xF7FFFFFF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                size: 18,
                                color: Color(0xFFB2B7C4),
                              ),
                              const SizedBox(width: 6),
                              const Expanded(
                                child: Text(
                                  'Название события',
                                  style: TextStyle(
                                    color: Color(0xFFB2B7C4),
                                    fontSize: 12,
                                    fontFamily: 'FindSansPro',
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 16,
                                color: const Color(0xFFD9DBE1),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.tune_rounded,
                                size: 18,
                                color: Color(0xFF2F33F9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 38,
                        height: 38,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Color(0xFF2F33F9),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: labels.asMap().entries.map((entry) {
                        final index = entry.key;
                        final label = entry.value;
                        final isPrimary = index == 0;
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: EdgeInsets.symmetric(
                            horizontal: isPrimary ? 12 : 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isPrimary
                                ? const Color(0xFF2F33F9)
                                : const Color(0xFFF4F5FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  color: isPrimary
                                      ? Colors.white
                                      : const Color(0xFF2F33F9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FindSansPro',
                                ),
                              ),
                              if (label.toLowerCase().contains('дата')) ...[
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 14,
                                  color: isPrimary
                                      ? Colors.white
                                      : const Color(0xFF2F33F9),
                                ),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
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
                        const SizedBox(height: 6),
                        _RoundIconButton(
                          icon: Icons.remove_rounded,
                          onTap: () => _changeZoom(-1),
                        ),
                        const SizedBox(height: 6),
                        _RoundIconButton(
                          icon: Icons.my_location_rounded,
                          onTap: _moveToCenter,
                          iconSize: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: widget.onShowListTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.view_list_rounded,
                                color: Color(0xFFFF6B3C),
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Список',
                                style: TextStyle(
                                  color: Color(0xFFFF6B3C),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  fontFamily: 'FindSansPro',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B3C),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 58,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xF5FFFFFF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2F33F9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const Icon(
                          Icons.groups_2_outlined,
                          size: 20,
                          color: Color(0xFF252A37),
                        ),
                        const Icon(
                          Icons.wallet_outlined,
                          size: 20,
                          color: Color(0xFF252A37),
                        ),
                        const Icon(
                          Icons.mail_outline_rounded,
                          size: 20,
                          color: Color(0xFF252A37),
                        ),
                        const Icon(
                          Icons.grid_view_rounded,
                          size: 20,
                          color: Color(0xFF252A37),
                        ),
                      ],
                    ),
                  ),
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
  final double iconSize;

  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: const Color(0xFF252A37),
          size: iconSize,
        ),
      ),
    );
  }
}
