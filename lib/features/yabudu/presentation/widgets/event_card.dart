import 'package:flutter/material.dart';
import 'package:yabudu/features/yabudu/data/models/event_item_model.dart';
import 'package:yabudu/theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final EventItemModel item;
  final bool compact;

  const EventCard({super.key, required this.item, required this.compact});

  @override
  Widget build(BuildContext context) {
    final ui = Theme.of(context).extension<AppUiTheme>() ?? AppTheme.ui;

    final imageWidth = compact ? ui.compactImageWidth : double.infinity;
    final imageHeight = compact ? ui.compactImageHeight : 156.0;
    final titleSize = compact ? 11.0 : 21.0;
    final titleHeight = compact ? 1.05 : 0.95;
    final titleWeight = compact ? FontWeight.w700 : FontWeight.w800;

    return SizedBox(
      width: compact ? ui.compactCardWidth : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: imageWidth,
            height: imageHeight,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ui.cardRadius),
                  child: Image.network(
                    item.imageUrl,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFCFD4DC),
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 6,
                  child: _LikesBadge(item: item),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      size: 13,
                      color: ui.accent,
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: item.tag == EventTag.free ? ui.freeBg : ui.paidBg,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.priceLabel,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: item.tag == EventTag.free ? ui.freeText : ui.paidText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Text(
            item.title,
            maxLines: compact ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: titleSize,
              height: titleHeight,
              fontWeight: titleWeight,
              color: const Color(0xFF131722),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 10, color: ui.mutedIcon),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.dateLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ui.cardMetaSize,
                    color: ui.mutedText,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 10, color: ui.mutedIcon),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.district,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ui.cardMetaSize,
                    color: ui.mutedText,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LikesBadge extends StatelessWidget {
  final EventItemModel item;

  const _LikesBadge({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 2, 6, 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              item.author.avatarUrl,
              width: 14,
              height: 14,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 14,
                height: 14,
                color: const Color(0xFFE1E4EB),
                child: const Icon(Icons.person, size: 10, color: Color(0xFF6F7585)),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '+${item.likes}',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C202B),
            ),
          ),
        ],
      ),
    );
  }
}
