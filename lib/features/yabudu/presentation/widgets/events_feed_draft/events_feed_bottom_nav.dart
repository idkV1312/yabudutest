import 'package:flutter/material.dart';

class EventsFeedBottomNav extends StatelessWidget {
  const EventsFeedBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E9),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: const [
          _ActiveNavItem(),
          Expanded(
            child: Icon(Icons.groups_2_outlined, size: 24, color: Color(0xFF2D2D2D)),
          ),
          Expanded(
            child: Icon(Icons.confirmation_num_outlined, size: 24, color: Color(0xFF2D2D2D)),
          ),
          Expanded(
            child: Icon(Icons.grid_view_outlined, size: 24, color: Color(0xFF2D2D2D)),
          ),
        ],
      ),
    );
  }
}

class _ActiveNavItem extends StatelessWidget {
  const _ActiveNavItem();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: const Color(0xFF2F33F9),
          borderRadius: BorderRadius.circular(23),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.home_rounded, size: 24, color: Colors.white),
      ),
    );
  }
}
