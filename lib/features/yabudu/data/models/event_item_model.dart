import 'event_author_model.dart';

enum EventTag { free, paid }

class EventItemModel {
  final String id;
  final String title;
  final String dateLabel;
  final String district;
  final String imageUrl;
  final String priceLabel;
  final int likes;
  final bool isFavorite;
  final EventTag tag;
  final EventAuthorModel author;

  const EventItemModel({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.district,
    required this.imageUrl,
    required this.priceLabel,
    required this.likes,
    required this.isFavorite,
    required this.tag,
    required this.author,
  });
}
